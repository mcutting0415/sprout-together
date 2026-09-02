import 'dart:io';

import '/final_app_pages/paywall/paywall_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/services/plant_scan_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

/// Photo -> "what plant is this?" or "what's wrong with it?".
///
/// All of the expensive and spoofable parts (API key, Pro check, quota) live
/// in the `plant-scan` edge function. This screen captures a photo, shows a
/// result, and sends people to the paywall when the free allowance runs out.
class PlantScanPageWidget extends StatefulWidget {
  const PlantScanPageWidget({super.key, this.initialMode = ScanMode.identify});

  static const String routeName = 'PlantScan';
  static const String routePath = '/plant-scan';

  final ScanMode initialMode;

  @override
  State<PlantScanPageWidget> createState() => _PlantScanPageWidgetState();
}

class _PlantScanPageWidgetState extends State<PlantScanPageWidget> {
  late ScanMode _mode = widget.initialMode;
  File? _image;
  bool _busy = false;
  PlantScanResponse? _response;
  int? _scansLeft;

  @override
  void initState() {
    super.initState();
    _refreshRemaining();
  }

  Future<void> _refreshRemaining() async {
    final left = await PlantScanService.instance.freeScansRemaining();
    if (mounted) setState(() => _scansLeft = left);
  }

  Future<void> _pick(ImageSource source) async {
    final file = await PlantScanService.instance.pickImage(source: source);
    if (file == null || !mounted) return;
    setState(() {
      _image = file;
      _response = null;
    });
    await _run();
  }

  Future<void> _run() async {
    final file = _image;
    if (file == null || _busy) return;

    setState(() => _busy = true);
    final res = await PlantScanService.instance.scan(image: file, mode: _mode);
    if (!mounted) return;
    setState(() {
      _busy = false;
      _response = res;
      if (res.ok) _scansLeft = res.isPro ? null : res.scansLeft;
    });

    if (res.needsUpgrade && mounted) {
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => const PaywallWidget(),
      );
      await _refreshRemaining();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryBackground,
      appBar: AppBar(
        backgroundColor: theme.primaryBackground,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: theme.primaryText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Plant Scanner',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: theme.primaryText)),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 32.0),
          children: [
            _modeToggle(theme),
            const SizedBox(height: 8.0),
            Text(
              _mode == ScanMode.identify
                  ? 'Take a photo of a plant and we’ll tell you what it is.'
                  : 'Photograph the affected leaves and we’ll work out what’s wrong.',
              style: GoogleFonts.poppins(
                  fontSize: 13.0, color: theme.secondaryText),
            ),
            const SizedBox(height: 16.0),
            _imageArea(theme),
            const SizedBox(height: 14.0),
            _captureButtons(theme),
            if (PlantScanService.freeScanLimit > 0 && _scansLeft != null) ...[
              const SizedBox(height: 12.0),
              _remainingBanner(theme, _scansLeft!),
            ] else if (PlantScanService.freeScanLimit == 0 &&
                _response?.isPro != true) ...[
              const SizedBox(height: 12.0),
              _proBadge(theme),
            ],
            const SizedBox(height: 20.0),
            if (_busy) _loading(theme),
            if (!_busy && _response != null) _resultArea(theme, _response!),
          ],
        ),
      ),
    );
  }

  Widget _modeToggle(FlutterFlowTheme theme) => Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: theme.alternate),
        ),
        child: Row(
          children: [
            _modeTab(theme, ScanMode.identify, 'Identify', Icons.search_rounded),
            _modeTab(theme, ScanMode.diagnose, 'Diagnose',
                Icons.healing_rounded),
          ],
        ),
      );

  Widget _modeTab(
      FlutterFlowTheme theme, ScanMode mode, String label, IconData icon) {
    final selected = _mode == mode;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() {
          _mode = mode;
          _response = null;
        }),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            color: selected ? theme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(11.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 16.0,
                  color: selected ? Colors.white : theme.secondaryText),
              const SizedBox(width: 6.0),
              Text(label,
                  style: GoogleFonts.poppins(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.white : theme.primaryText)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageArea(FlutterFlowTheme theme) => AspectRatio(
        aspectRatio: 4 / 3,
        child: Container(
          decoration: BoxDecoration(
            color: theme.secondaryBackground,
            borderRadius: BorderRadius.circular(18.0),
            border: Border.all(color: theme.alternate),
          ),
          clipBehavior: Clip.antiAlias,
          child: _image == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo_camera_outlined,
                        size: 34.0, color: theme.secondaryText),
                    const SizedBox(height: 8.0),
                    Text('No photo yet',
                        style: GoogleFonts.poppins(
                            fontSize: 13.0, color: theme.secondaryText)),
                  ],
                )
              : Image.file(_image!, fit: BoxFit.cover),
        ),
      );

  Widget _captureButtons(FlutterFlowTheme theme) => Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _busy ? null : () => _pick(ImageSource.camera),
              icon: const Icon(Icons.photo_camera_rounded, size: 18.0),
              label: Text('Camera',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 13.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13.0)),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _busy ? null : () => _pick(ImageSource.gallery),
              icon: const Icon(Icons.photo_library_outlined, size: 18.0),
              label: Text('Gallery',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              style: OutlinedButton.styleFrom(
                foregroundColor: theme.primary,
                side: BorderSide(color: theme.primary),
                padding: const EdgeInsets.symmetric(vertical: 13.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13.0)),
              ),
            ),
          ),
        ],
      );

  Widget _remainingBanner(FlutterFlowTheme theme, int left) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: const Color(0x1A6F8F72),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            Icon(Icons.auto_awesome_rounded, size: 15.0, color: theme.primary),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                left > 0
                    ? '$left free ${left == 1 ? 'scan' : 'scans'} left'
                    : 'You’ve used your free scans',
                style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: theme.primary),
              ),
            ),
          ],
        ),
      );

  Widget _proBadge(FlutterFlowTheme theme) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: const Color(0x1A6F8F72),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            Icon(Icons.workspace_premium_rounded,
                size: 15.0, color: theme.primary),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                'Included with Sprout Together Pro',
                style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: theme.primary),
              ),
            ),
          ],
        ),
      );

  Widget _loading(FlutterFlowTheme theme) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 26.0),
        child: Column(
          children: [
            CircularProgressIndicator(
                strokeWidth: 2.4, color: theme.primary),
            const SizedBox(height: 14.0),
            Text(
              _mode == ScanMode.identify
                  ? 'Looking at your photo…'
                  : 'Working out what’s wrong…',
              style: GoogleFonts.poppins(
                  fontSize: 13.0, color: theme.secondaryText),
            ),
          ],
        ),
      );

  Widget _resultArea(FlutterFlowTheme theme, PlantScanResponse res) {
    if (!res.ok) return _errorCard(theme, res);
    final r = res.result!;
    if (r['is_plant'] == false) {
      return _notice(theme, Icons.image_not_supported_outlined,
          'That doesn’t look like a plant',
          'Try a clearer photo of the plant itself — close enough to see the leaves.');
    }
    return _mode == ScanMode.identify
        ? _identifyResult(theme, r)
        : _diagnoseResult(theme, r);
  }

  Widget _identifyResult(FlutterFlowTheme theme, Map<String, dynamic> r) {
    final care = r['care_snapshot'] as Map?;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _card(theme, [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text('${r['common_name'] ?? 'Unknown'}',
                    style: GoogleFonts.poppins(
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                        color: theme.primaryText)),
              ),
              _confidenceChip(theme, r['confidence']?.toString()),
            ],
          ),
          if ((r['scientific_name'] ?? '').toString().isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text('${r['scientific_name']}',
                  style: GoogleFonts.poppins(
                      fontSize: 13.0,
                      fontStyle: FontStyle.italic,
                      color: theme.secondaryText)),
            ),
          const SizedBox(height: 10.0),
          Text('${r['summary'] ?? ''}',
              style: GoogleFonts.poppins(
                  fontSize: 13.5, height: 1.5, color: theme.primaryText)),
        ]),
        if (care != null) ...[
          const SizedBox(height: 12.0),
          _card(theme, [
            _sectionTitle(theme, 'At a glance'),
            const SizedBox(height: 8.0),
            _careRow(theme, Icons.wb_sunny_outlined, 'Sun', care['sun']),
            _careRow(theme, Icons.water_drop_outlined, 'Water', care['water']),
            _careRow(theme, Icons.straighten_rounded, 'Spacing',
                care['spacing']),
          ]),
        ],
        _bulletCard(theme, 'What to do next', r['next_steps']),
        const SizedBox(height: 12.0),
        _disclaimer(theme),
      ],
    );
  }

  Widget _diagnoseResult(FlutterFlowTheme theme, Map<String, dynamic> r) {
    final healthy = r['looks_healthy'] == true;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _card(theme, [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  healthy
                      ? 'Looks healthy'
                      : '${r['problem'] ?? 'Something’s off'}',
                  style: GoogleFonts.poppins(
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                      color: theme.primaryText),
                ),
              ),
              _confidenceChip(theme, r['confidence']?.toString()),
            ],
          ),
          if (!healthy) ...[
            const SizedBox(height: 8.0),
            _severityBar(theme, r['severity']?.toString()),
          ],
          if ((r['plant_guess'] ?? '').toString().isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('Looks like ${r['plant_guess']}',
                  style: GoogleFonts.poppins(
                      fontSize: 12.5, color: theme.secondaryText)),
            ),
        ]),
        if (!healthy) _bulletCard(theme, 'Likely causes', r['likely_causes']),
        _bulletCard(theme, healthy ? 'Keep it that way' : 'What to do',
            r['treatment']),
        _bulletCard(theme, 'Preventing it next time', r['prevention']),
        const SizedBox(height: 12.0),
        _disclaimer(theme),
      ],
    );
  }

  Widget _errorCard(FlutterFlowTheme theme, PlantScanResponse res) {
    switch (res.error) {
      case 'free_limit_reached':
        return _notice(
            theme,
            Icons.lock_outline_rounded,
            PlantScanService.freeScanLimit == 0
                ? 'Plant Scanner is a Pro feature'
                : 'You’ve used your free scans',
            'Upgrade to Pro for unlimited plant identification and diagnosis.');
      case 'daily_cap_reached':
        return _notice(theme, Icons.hourglass_empty_rounded,
            'That’s a lot of scanning',
            'You’ve hit today’s limit. It resets in 24 hours.');
      case 'image_too_large':
        return _notice(theme, Icons.photo_size_select_large_rounded,
            'That photo is too big', 'Try taking a new one with the camera.');
      case 'unauthorized':
        return _notice(theme, Icons.person_outline_rounded, 'Please sign in',
            'You need an account to use the scanner.');
      case 'busy':
        return _notice(theme, Icons.cloud_off_rounded, 'Too busy right now',
            'Give it a minute and try again.');
      case 'network':
        return _notice(theme, Icons.wifi_off_rounded, 'No connection',
            'The scanner needs internet. Check your connection and retry.');
      default:
        return _notice(theme, Icons.error_outline_rounded,
            'That didn’t work', 'Something went wrong. Try again.');
    }
  }

  // ---- small pieces -------------------------------------------------------

  Widget _card(FlutterFlowTheme theme, List<Widget> children) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: theme.alternate),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: children),
      );

  Widget _sectionTitle(FlutterFlowTheme theme, String text) => Text(
        text.toUpperCase(),
        style: GoogleFonts.poppins(
            fontSize: 11.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: theme.primary),
      );

  Widget _bulletCard(FlutterFlowTheme theme, String title, dynamic items) {
    if (items is! List || items.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: _card(theme, [
        _sectionTitle(theme, title),
        const SizedBox(height: 8.0),
        ...items.map((i) => Padding(
              padding: const EdgeInsets.only(bottom: 7.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0, right: 9.0),
                    child: Container(
                      width: 5.0,
                      height: 5.0,
                      decoration: BoxDecoration(
                          color: theme.primary, shape: BoxShape.circle),
                    ),
                  ),
                  Expanded(
                    child: Text('$i',
                        style: GoogleFonts.poppins(
                            fontSize: 13.5,
                            height: 1.45,
                            color: theme.primaryText)),
                  ),
                ],
              ),
            )),
      ]),
    );
  }

  Widget _careRow(FlutterFlowTheme theme, IconData icon, String label,
          dynamic value) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 16.0, color: theme.primary),
            const SizedBox(width: 9.0),
            SizedBox(
              width: 62.0,
              child: Text(label,
                  style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: theme.secondaryText)),
            ),
            Expanded(
              child: Text('${value ?? '—'}',
                  style: GoogleFonts.poppins(
                      fontSize: 13.0, color: theme.primaryText)),
            ),
          ],
        ),
      );

  Widget _confidenceChip(FlutterFlowTheme theme, String? confidence) {
    if (confidence == null || confidence.isEmpty) return const SizedBox.shrink();
    final color = confidence == 'high'
        ? theme.primary
        : confidence == 'medium'
            ? const Color(0xFFAA7430)
            : const Color(0xFFA65C46);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text('$confidence confidence',
          style: GoogleFonts.poppins(
              fontSize: 10.5, fontWeight: FontWeight.w700, color: color)),
    );
  }

  Widget _severityBar(FlutterFlowTheme theme, String? severity) {
    const order = ['none', 'low', 'medium', 'high'];
    final idx = order.indexOf(severity ?? 'low').clamp(0, 3);
    const labels = {
      'none': 'No action needed',
      'low': 'Minor',
      'medium': 'Worth acting on',
      'high': 'Act soon',
    };
    final color = idx >= 3
        ? const Color(0xFFA65C46)
        : idx == 2
            ? const Color(0xFFAA7430)
            : theme.primary;
    return Row(
      children: [
        ...List.generate(
          3,
          (i) => Container(
            width: 26.0,
            height: 5.0,
            margin: const EdgeInsets.only(right: 4.0),
            decoration: BoxDecoration(
              color: i < idx ? color : theme.alternate,
              borderRadius: BorderRadius.circular(3.0),
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Text(labels[order[idx]] ?? '',
            style: GoogleFonts.poppins(
                fontSize: 12.0, fontWeight: FontWeight.w600, color: color)),
      ],
    );
  }

  Widget _notice(FlutterFlowTheme theme, IconData icon, String title,
          String body) =>
      _card(theme, [
        Row(
          children: [
            Icon(icon, size: 19.0, color: theme.primary),
            const SizedBox(width: 9.0),
            Expanded(
              child: Text(title,
                  style: GoogleFonts.poppins(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                      color: theme.primaryText)),
            ),
          ],
        ),
        const SizedBox(height: 7.0),
        Text(body,
            style: GoogleFonts.poppins(
                fontSize: 13.0, height: 1.45, color: theme.secondaryText)),
      ]);

  /// Photo diagnosis is a guess from one image. Saying so protects the user
  /// from acting on a wrong answer, and protects us from the claim that we
  /// promised certainty.
  Widget _disclaimer(FlutterFlowTheme theme) => Text(
        'AI suggestions based on one photo — treat them as a starting point, '
        'not a certainty. Check with a local nursery before treating a plant '
        'you rely on, and never eat a plant identified only by an app.',
        style: GoogleFonts.poppins(
            fontSize: 11.0, height: 1.5, color: theme.secondaryText),
      );
}
