import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/services/seed_inventory_service.dart';

class SeedInventoryPageWidget extends StatefulWidget {
  const SeedInventoryPageWidget({super.key});

  static const String routeName = 'SeedInventoryPage';
  static const String routePath = '/seedInventory';

  @override
  State<SeedInventoryPageWidget> createState() => _SeedInventoryPageWidgetState();
}

class _SeedInventoryPageWidgetState extends State<SeedInventoryPageWidget> {
  final _searchCtrl = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    SeedInventoryService.instance.load();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _openAddSheet({SeedItem? editing}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _SeedEditSheet(editing: editing),
    ).then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return ListenableBuilder(
      listenable: SeedInventoryService.instance,
      builder: (context, _) {
        final results = SeedInventoryService.instance.search(_query);
        final grouped = <String, List<SeedItem>>{};
        final sorted = [...results]
          ..sort((a, b) => a.plantName.toLowerCase().compareTo(b.plantName.toLowerCase()));
        for (final item in sorted) {
          final letter = item.plantName.isEmpty ? '#' : item.plantName[0].toUpperCase();
          grouped.putIfAbsent(letter, () => []).add(item);
        }

        return Scaffold(
          backgroundColor: theme.primaryBackground,
          body: SafeArea(
            child: Column(
              children: [
                // ── Header ────────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_new_rounded,
                            color: theme.primaryText, size: 20),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Expanded(
                        child: Text(
                          'Seed Inventory',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: theme.primaryText,
                          ),
                        ),
                      ),
                      // Stats chip
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0x1A6F8F72),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${SeedInventoryService.instance.items.length} varieties',
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF6F8F72)),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Search bar ────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                  child: TextField(
                    controller: _searchCtrl,
                    onChanged: (v) => setState(() => _query = v),
                    decoration: InputDecoration(
                      hintText: 'Search seeds…',
                      hintStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          color: theme.secondaryText),
                      prefixIcon: Icon(Icons.search_rounded,
                          color: theme.secondaryText),
                      suffixIcon: _query.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded),
                              onPressed: () {
                                _searchCtrl.clear();
                                setState(() => _query = '');
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: theme.secondaryBackground,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                ),

                // ── List ──────────────────────────────────────────────────
                Expanded(
                  child: results.isEmpty
                      ? _buildEmpty(theme)
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(20, 4, 20, 100),
                          itemCount: grouped.length,
                          itemBuilder: (ctx, sectionIdx) {
                            final letter =
                                grouped.keys.elementAt(sectionIdx);
                            final sectionItems = grouped[letter]!;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 16, bottom: 6),
                                  child: Text(
                                    letter,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: theme.secondaryText),
                                  ),
                                ),
                                ...sectionItems.map((item) =>
                                    _SeedTile(
                                      item: item,
                                      onEdit: () => _openAddSheet(editing: item),
                                      onDelete: () async {
                                        await SeedInventoryService.instance
                                            .remove(item.id);
                                      },
                                    )),
                              ],
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _openAddSheet(),
            backgroundColor: const Color(0xFF6F8F72),
            foregroundColor: Colors.white,
            icon: const Icon(Icons.add_rounded),
            label: Text('Add Seeds',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ),
        );
      },
    );
  }

  Widget _buildEmpty(FlutterFlowTheme theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🌱', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          Text('Your seed collection is empty',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: theme.primaryText)),
          const SizedBox(height: 8),
          Text('Tap "Add Seeds" to start tracking\nyour seed packets',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 14, color: theme.secondaryText)),
        ],
      ),
    );
  }
}

// ── Seed list tile ──────────────────────────────────────────────────────────

class _SeedTile extends StatelessWidget {
  final SeedItem item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _SeedTile({
    required this.item,
    required this.onEdit,
    required this.onDelete,
  });

  Color _expiryColor(BuildContext context) {
    final year = int.tryParse(item.expiryYear ?? '');
    if (year == null) return Colors.transparent;
    final now = DateTime.now().year;
    if (year < now) return Colors.red.shade100;
    if (year == now) return Colors.orange.shade100;
    return Colors.green.shade50;
  }

  Color _expiryTextColor(BuildContext context) {
    final year = int.tryParse(item.expiryYear ?? '');
    if (year == null) return Colors.transparent;
    final now = DateTime.now().year;
    if (year < now) return Colors.red.shade700;
    if (year == now) return Colors.orange.shade700;
    return Colors.green.shade700;
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(16),
        ),
        child:
            const Icon(Icons.delete_rounded, color: Colors.white, size: 24),
      ),
      onDismissed: (_) => onDelete(),
      child: GestureDetector(
        onTap: onEdit,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: theme.secondaryBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.alternate),
          ),
          child: Row(
            children: [
              // Plant icon
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0x1A6F8F72),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  item.isOpen
                      ? Icons.grass_rounded
                      : Icons.inventory_2_rounded,
                  color: const Color(0xFF6F8F72),
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),

              // Name + variety
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.plantName,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: theme.primaryText),
                    ),
                    if (item.variety.isNotEmpty)
                      Text(
                        item.variety,
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: theme.secondaryText),
                      ),
                    if (item.source.isNotEmpty)
                      Text(
                        item.source,
                        style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: theme.secondaryText,
                            fontStyle: FontStyle.italic),
                      ),
                  ],
                ),
              ),

              // Right side: packets + expiry
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(Icons.inventory_2_outlined,
                          size: 13, color: theme.secondaryText),
                      const SizedBox(width: 3),
                      Text(
                        '${item.packets} pkt${item.packets != 1 ? 's' : ''}',
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: theme.primaryText),
                      ),
                    ],
                  ),
                  if (item.expiryYear != null && item.expiryYear!.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _expiryColor(context),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Exp ${item.expiryYear}',
                        style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _expiryTextColor(context)),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Add / Edit sheet ───────────────────────────────────────────────────────

class _SeedEditSheet extends StatefulWidget {
  final SeedItem? editing;
  const _SeedEditSheet({this.editing});

  @override
  State<_SeedEditSheet> createState() => _SeedEditSheetState();
}

class _SeedEditSheetState extends State<_SeedEditSheet> {
  late TextEditingController _nameCtrl;
  late TextEditingController _varietyCtrl;
  late TextEditingController _sourceCtrl;
  late TextEditingController _notesCtrl;
  late TextEditingController _expiryCtrl;
  late int _packets;
  late bool _isOpen;

  @override
  void initState() {
    super.initState();
    final e = widget.editing;
    _nameCtrl = TextEditingController(text: e?.plantName ?? '');
    _varietyCtrl = TextEditingController(text: e?.variety ?? '');
    _sourceCtrl = TextEditingController(text: e?.source ?? '');
    _notesCtrl = TextEditingController(text: e?.notes ?? '');
    _expiryCtrl = TextEditingController(text: e?.expiryYear ?? '');
    _packets = e?.packets ?? 1;
    _isOpen = e?.isOpen ?? false;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _varietyCtrl.dispose();
    _sourceCtrl.dispose();
    _notesCtrl.dispose();
    _expiryCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_nameCtrl.text.trim().isEmpty) return;
    final svc = SeedInventoryService.instance;
    if (widget.editing != null) {
      final updated = widget.editing!
        ..plantName = _nameCtrl.text.trim()
        ..variety = _varietyCtrl.text.trim()
        ..source = _sourceCtrl.text.trim()
        ..notes = _notesCtrl.text.trim()
        ..expiryYear = _expiryCtrl.text.trim().isEmpty
            ? null
            : _expiryCtrl.text.trim()
        ..packets = _packets
        ..isOpen = _isOpen;
      await svc.update(updated);
    } else {
      await svc.add(SeedItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        plantName: _nameCtrl.text.trim(),
        variety: _varietyCtrl.text.trim(),
        source: _sourceCtrl.text.trim(),
        notes: _notesCtrl.text.trim(),
        expiryYear: _expiryCtrl.text.trim().isEmpty
            ? null
            : _expiryCtrl.text.trim(),
        packets: _packets,
        isOpen: _isOpen,
      ));
    }
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.primaryBackground,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: 24, right: 24, top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: theme.alternate,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.editing != null ? 'Edit Seed' : 'Add Seed',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: theme.primaryText),
            ),
            const SizedBox(height: 20),

            _field('Plant Name *', _nameCtrl, hint: 'e.g. Tomato'),
            const SizedBox(height: 12),
            _field('Variety', _varietyCtrl, hint: 'e.g. Cherry Roma'),
            const SizedBox(height: 12),
            _field('Source / Store', _sourceCtrl, hint: 'e.g. Baker Creek'),
            const SizedBox(height: 12),
            _field('Expiry Year', _expiryCtrl,
                hint: 'e.g. 2027', keyboard: TextInputType.number),
            const SizedBox(height: 12),

            // Packet count stepper
            Row(
              children: [
                Text('Packets:',
                    style: GoogleFonts.poppins(
                        fontSize: 14, color: theme.primaryText)),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline_rounded),
                  color: const Color(0xFF6F8F72),
                  onPressed: _packets > 1
                      ? () => setState(() => _packets--)
                      : null,
                ),
                Text('$_packets',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline_rounded),
                  color: const Color(0xFF6F8F72),
                  onPressed: () => setState(() => _packets++),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Open packet toggle
            SwitchListTile.adaptive(
              value: _isOpen,
              onChanged: (v) => setState(() => _isOpen = v),
              title: Text('Packet opened',
                  style: GoogleFonts.poppins(fontSize: 14)),
              activeColor: const Color(0xFF6F8F72),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 8),

            _field('Notes', _notesCtrl,
                hint: 'Germination %, special storage, etc.',
                maxLines: 3),
            const SizedBox(height: 20),

            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6F8F72),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(
                  widget.editing != null ? 'Save Changes' : 'Add to Inventory',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController ctrl, {
    String hint = '',
    int maxLines = 1,
    TextInputType keyboard = TextInputType.text,
  }) {
    final theme = FlutterFlowTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: theme.secondaryText)),
        const SizedBox(height: 4),
        TextField(
          controller: ctrl,
          maxLines: maxLines,
          keyboardType: keyboard,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                GoogleFonts.poppins(fontSize: 13, color: theme.secondaryText),
            filled: true,
            fillColor: theme.secondaryBackground,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          style: GoogleFonts.poppins(fontSize: 14),
        ),
      ],
    );
  }
}
