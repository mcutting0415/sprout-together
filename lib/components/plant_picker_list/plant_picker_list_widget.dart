import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Plant chooser used by the Garden Builder sheets.
///
/// Replaces the flat A–Z list: plants are grouped under their `category`
/// (the same categories the Plant Library uses), with chips to jump straight
/// to one. Searching cuts across every category and shows a flat result list,
/// because when someone types "basil" they want basil, not a heading.
class PlantPickerList extends StatefulWidget {
  const PlantPickerList({
    super.key,
    required this.plants,
    required this.onSelect,
    this.selectedPlantId,
    this.shrinkWrap = false,
  });

  final List<PlantsRow> plants;
  final ValueChanged<PlantsRow> onSelect;
  final String? selectedPlantId;

  /// True when embedded in a parent scroll view (the Add Container sheet);
  /// false when it owns its own scrollable area (the Assign Plant sheet).
  final bool shrinkWrap;

  @override
  State<PlantPickerList> createState() => _PlantPickerListState();
}

class _PlantPickerListState extends State<PlantPickerList> {
  final _searchController = TextEditingController();
  String _category = _kAll;

  static const _kAll = 'All';

  /// Categories we want first and in this order; anything else in the data is
  /// appended alphabetically so a newly added category can't silently vanish.
  static const _preferredOrder = ['Vegetables', 'Herbs', 'Fruit', 'Flowers'];

  static const _categoryIcons = <String, IconData>{
    'Vegetables': Icons.eco_rounded,
    'Herbs': Icons.grass_rounded,
    'Fruit': Icons.apple_rounded,
    'Flowers': Icons.local_florist_rounded,
  };

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _categoryOf(PlantsRow p) {
    final c = (p.category ?? '').trim();
    return c.isEmpty ? 'Other' : c;
  }

  List<String> get _categories {
    final present = widget.plants.map(_categoryOf).toSet();
    final ordered = <String>[
      for (final c in _preferredOrder)
        if (present.remove(c)) c,
    ];
    final rest = present.toList()..sort();
    return [_kAll, ...ordered, ...rest];
  }

  List<PlantsRow> get _matchingSearch {
    final q = _searchController.text.trim().toLowerCase();
    if (q.isEmpty) return widget.plants;
    return widget.plants
        .where((p) => (p.plantName ?? '').toLowerCase().contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final searching = _searchController.text.trim().isNotEmpty;
    final matches = _matchingSearch;

    final body = <Widget>[];
    if (searching || _category != _kAll) {
      // Searching, or one category chosen -> flat list.
      final flat = searching
          ? matches
          : matches.where((p) => _categoryOf(p) == _category).toList();
      if (flat.isEmpty) {
        body.add(_emptyState(theme));
      } else {
        body.addAll(flat.map((p) => _tile(p, theme)));
      }
    } else {
      // "All" -> grouped sections, so it reads as categories not one long list.
      for (final c in _categories.skip(1)) {
        final inCategory = matches.where((p) => _categoryOf(p) == c).toList();
        if (inCategory.isEmpty) continue;
        body.add(_sectionHeader(c, inCategory.length, theme));
        body.addAll(inCategory.map((p) => _tile(p, theme)));
      }
      if (body.isEmpty) body.add(_emptyState(theme));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _searchField(theme),
        const SizedBox(height: 10.0),
        _categoryChips(theme),
        const SizedBox(height: 4.0),
        if (widget.shrinkWrap)
          ...body
        else
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 4.0, bottom: 12.0),
              children: body,
            ),
          ),
      ],
    );
  }

  Widget _searchField(FlutterFlowTheme theme) => TextField(
        controller: _searchController,
        textInputAction: TextInputAction.search,
        onChanged: (_) => setState(() {}),
        style: GoogleFonts.poppins(color: theme.primaryText, fontSize: 14.0),
        decoration: InputDecoration(
          hintText: 'Search plants...',
          prefixIcon: const Icon(Icons.search, size: 18.0),
          suffixIcon: _searchController.text.isEmpty
              ? null
              : IconButton(
                  icon: const Icon(Icons.close, size: 16.0),
                  onPressed: () => setState(_searchController.clear),
                ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: theme.alternate)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: theme.primary, width: 1.5)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        ),
      );

  Widget _categoryChips(FlutterFlowTheme theme) => SizedBox(
        height: 38.0,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8.0),
          itemBuilder: (_, i) {
            final c = _categories[i];
            final selected = _category == c;
            final icon = _categoryIcons[c];
            return GestureDetector(
              onTap: () => setState(() => _category = c),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: selected ? theme.primary : theme.secondaryBackground,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: selected ? theme.primary : theme.alternate,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      Icon(icon,
                          size: 14.0,
                          color: selected ? Colors.white : theme.secondaryText),
                      const SizedBox(width: 5.0),
                    ],
                    Text(
                      c,
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: selected ? Colors.white : theme.primaryText,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

  Widget _sectionHeader(String label, int count, FlutterFlowTheme theme) =>
      Padding(
        padding: const EdgeInsets.fromLTRB(2.0, 14.0, 2.0, 4.0),
        child: Row(
          children: [
            Icon(_categoryIcons[label] ?? Icons.spa_rounded,
                size: 14.0, color: theme.primary),
            const SizedBox(width: 6.0),
            Text(
              label.toUpperCase(),
              style: GoogleFonts.poppins(
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                color: theme.primary,
              ),
            ),
            const SizedBox(width: 6.0),
            Text('$count',
                style: GoogleFonts.poppins(
                    fontSize: 11.0, color: theme.secondaryText)),
            const SizedBox(width: 8.0),
            Expanded(child: Divider(height: 1.0, color: theme.alternate)),
          ],
        ),
      );

  Widget _tile(PlantsRow plant, FlutterFlowTheme theme) {
    final isSelected =
        widget.selectedPlantId != null && widget.selectedPlantId == plant.id;
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      leading: Container(
        width: 34.0,
        height: 34.0,
        decoration: BoxDecoration(
            color: const Color(0x1A6F8F72),
            borderRadius: BorderRadius.circular(8.0)),
        child: Icon(
            _categoryIcons[_categoryOf(plant)] ?? Icons.local_florist_rounded,
            color: theme.primary,
            size: 16.0),
      ),
      title: Text(plant.plantName ?? 'Unknown',
          style: GoogleFonts.poppins(fontSize: 13.5)),
      subtitle: plant.daysToHarvest == null
          ? null
          : Text('${plant.daysToHarvest} days to harvest',
              style: GoogleFonts.poppins(
                  fontSize: 11.0, color: theme.secondaryText)),
      trailing: isSelected
          ? Icon(Icons.check_circle_rounded, color: theme.primary, size: 18.0)
          : null,
      onTap: () => widget.onSelect(plant),
    );
  }

  Widget _emptyState(FlutterFlowTheme theme) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Center(
          child: Text('No plants found',
              style: GoogleFonts.poppins(color: theme.secondaryText)),
        ),
      );
}
