import 'dart:convert';
import 'dart:io';

import '/backend/supabase/supabase.dart';
import 'package:image_picker/image_picker.dart';

/// Outcome of a scan. Either [result] is set, or [error] explains why not.
class PlantScanResponse {
  const PlantScanResponse({
    this.result,
    this.error,
    this.scansUsed = 0,
    this.freeLimit = 5,
    this.isPro = false,
  });

  final Map<String, dynamic>? result;

  /// One of: `free_limit_reached`, `daily_cap_reached`, `unauthorized`,
  /// `image_too_large`, `unreadable_image`, `refused`, `busy`, `scan_failed`,
  /// `network`.
  final String? error;

  final int scansUsed;
  final int freeLimit;
  final bool isPro;

  bool get ok => result != null;
  bool get needsUpgrade => error == 'free_limit_reached';
  int get scansLeft => (freeLimit - scansUsed).clamp(0, freeLimit);
}

enum ScanMode { identify, diagnose }

/// Talks to the `plant-scan` edge function.
///
/// The Anthropic key, the Pro check and the quota all live server-side — this
/// class only shuttles JSON. Anything it claimed about entitlement would be
/// trivially spoofable, so it doesn't try.
class PlantScanService {
  PlantScanService._();
  static final instance = PlantScanService._();

  /// Capture constraints. Phone cameras produce 8–12 MB files; Claude gains
  /// nothing from that resolution for leaf-level detail, and every extra pixel
  /// is upload time on a phone connection plus input tokens we pay for.
  /// `image_picker` does the resize natively, which is faster than decoding
  /// and re-encoding in Dart and avoids pulling in another package.
  static const captureMaxEdge = 1280.0;
  static const captureQuality = 82;

  /// Matches MAX_IMAGE_BYTES in the edge function. Checked here too so an
  /// oversized file fails instantly instead of after a slow upload.
  static const _maxBytes = 5 * 1024 * 1024;

  /// Pick a photo already sized for scanning.
  Future<File?> pickImage({required ImageSource source}) async {
    final picked = await ImagePicker().pickImage(
      source: source,
      maxWidth: captureMaxEdge,
      maxHeight: captureMaxEdge,
      imageQuality: captureQuality,
    );
    return picked == null ? null : File(picked.path);
  }

  Future<PlantScanResponse> scan({
    required File image,
    required ScanMode mode,
    String? note,
  }) async {
    final List<int> bytes;
    try {
      bytes = await image.readAsBytes();
    } catch (_) {
      return const PlantScanResponse(error: 'unreadable_image');
    }
    if (bytes.isEmpty) {
      return const PlantScanResponse(error: 'unreadable_image');
    }
    if (bytes.length > _maxBytes) {
      return const PlantScanResponse(error: 'image_too_large');
    }

    final mediaType = _mediaTypeFor(image.path);

    try {
      final res = await SupaFlow.client.functions.invoke(
        'plant-scan',
        body: {
          'mode': mode == ScanMode.diagnose ? 'diagnose' : 'identify',
          'media_type': mediaType,
          'image': base64Encode(bytes),
          if (note != null && note.trim().isNotEmpty) 'note': note.trim(),
        },
      );

      final data = res.data;
      if (data is! Map) {
        return const PlantScanResponse(error: 'scan_failed');
      }
      final map = Map<String, dynamic>.from(data);

      if (map['error'] != null) {
        return PlantScanResponse(
          error: map['error'].toString(),
          scansUsed: (map['used'] as num?)?.toInt() ?? 0,
          freeLimit: (map['limit'] as num?)?.toInt() ?? 5,
        );
      }

      return PlantScanResponse(
        result: Map<String, dynamic>.from(map['result'] as Map),
        scansUsed: (map['scans_used'] as num?)?.toInt() ?? 0,
        freeLimit: (map['free_limit'] as num?)?.toInt() ?? 5,
        isPro: map['is_pro'] == true,
      );
    } catch (e) {
      // functions.invoke throws on any non-2xx, and "out of free scans" is a
      // 402 — so read the body before treating this as a network failure.
      return _errorFromException(e) ??
          const PlantScanResponse(error: 'network');
    }
  }

  /// `image_picker` hands back whatever the platform wrote. It re-encodes to
  /// JPEG whenever resizing happens, but a small PNG can pass through.
  String _mediaTypeFor(String path) {
    final lower = path.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.webp')) return 'image/webp';
    return 'image/jpeg';
  }

  PlantScanResponse? _errorFromException(Object e) {
    final text = e.toString();
    for (final code in const [
      'free_limit_reached',
      'daily_cap_reached',
      'image_too_large',
      'unauthorized',
      'refused',
      'busy',
    ]) {
      if (text.contains(code)) return PlantScanResponse(error: code);
    }
    return null;
  }

  /// How many free scans this user has left, read straight from the ledger.
  /// Returns null when it can't be determined (offline, signed out).
  Future<int?> freeScansRemaining({int freeLimit = 5}) async {
    final uid = SupaFlow.client.auth.currentUser?.id;
    if (uid == null) return null;
    try {
      final rows = await SupaFlow.client
          .from('ai_scan_usage')
          .select('id')
          .eq('user_id', uid);
      return (freeLimit - (rows as List).length).clamp(0, freeLimit);
    } catch (_) {
      return null;
    }
  }
}
