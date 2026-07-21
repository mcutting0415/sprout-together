import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A single seed packet in the user's inventory.
class SeedItem {
  final String id;
  String plantName;
  String variety;        // e.g. "Cherry Roma", "Genovese Basil"
  int packets;           // number of packets
  String source;         // e.g. "Baker Creek", "Amazon", "Saved"
  String? purchaseDate;  // ISO date string
  String? expiryYear;    // "2026", "2027" etc.
  String notes;
  bool isOpen;           // has the packet been opened

  SeedItem({
    required this.id,
    required this.plantName,
    this.variety = '',
    this.packets = 1,
    this.source = '',
    this.purchaseDate,
    this.expiryYear,
    this.notes = '',
    this.isOpen = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'plantName': plantName,
        'variety': variety,
        'packets': packets,
        'source': source,
        'purchaseDate': purchaseDate,
        'expiryYear': expiryYear,
        'notes': notes,
        'isOpen': isOpen,
      };

  factory SeedItem.fromJson(Map<String, dynamic> j) => SeedItem(
        id: j['id'] as String,
        plantName: j['plantName'] as String,
        variety: j['variety'] as String? ?? '',
        packets: j['packets'] as int? ?? 1,
        source: j['source'] as String? ?? '',
        purchaseDate: j['purchaseDate'] as String?,
        expiryYear: j['expiryYear'] as String?,
        notes: j['notes'] as String? ?? '',
        isOpen: j['isOpen'] as bool? ?? false,
      );
}

/// Stores and retrieves the user's seed inventory using shared_preferences.
class SeedInventoryService extends ChangeNotifier {
  static final SeedInventoryService _instance = SeedInventoryService._();
  static SeedInventoryService get instance => _instance;
  SeedInventoryService._();

  static const _key = 'seed_inventory_v1';

  List<SeedItem> _items = [];
  List<SeedItem> get items => List.unmodifiable(_items);

  bool _loaded = false;

  Future<void> load() async {
    if (_loaded) return;
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw != null) {
      final list = jsonDecode(raw) as List;
      _items = list.map((e) => SeedItem.fromJson(e as Map<String, dynamic>)).toList();
    }
    _loaded = true;
    notifyListeners();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(_items.map((e) => e.toJson()).toList()));
  }

  Future<void> add(SeedItem item) async {
    _items.add(item);
    await _save();
    notifyListeners();
  }

  Future<void> update(SeedItem updated) async {
    final idx = _items.indexWhere((i) => i.id == updated.id);
    if (idx >= 0) {
      _items[idx] = updated;
      await _save();
      notifyListeners();
    }
  }

  Future<void> remove(String id) async {
    _items.removeWhere((i) => i.id == id);
    await _save();
    notifyListeners();
  }

  /// Returns items grouped by first letter of plant name.
  Map<String, List<SeedItem>> get grouped {
    final map = <String, List<SeedItem>>{};
    final sorted = [..._items]
      ..sort((a, b) => a.plantName.toLowerCase().compareTo(b.plantName.toLowerCase()));
    for (final item in sorted) {
      final letter = item.plantName.isEmpty ? '#' : item.plantName[0].toUpperCase();
      map.putIfAbsent(letter, () => []).add(item);
    }
    return map;
  }

  List<SeedItem> search(String query) {
    final q = query.toLowerCase().trim();
    if (q.isEmpty) return items;
    return _items.where((i) =>
        i.plantName.toLowerCase().contains(q) ||
        i.variety.toLowerCase().contains(q) ||
        i.source.toLowerCase().contains(q)).toList();
  }
}
