import '../database.dart';

class GardenPlotsTable extends SupabaseTable<GardenPlotsRow> {
  @override
  String get tableName => 'garden_plots';

  @override
  GardenPlotsRow createRow(Map<String, dynamic> data) => GardenPlotsRow(data);
}

class GardenPlotsRow extends SupabaseDataRow {
  GardenPlotsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => GardenPlotsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String get gardenId => getField<String>('garden_id')!;
  set gardenId(String value) => setField<String>('garden_id', value);

  int? get plotNumber => getField<int>('plot_number');
  set plotNumber(int? value) => setField<int>('plot_number', value);

  int? get rowIndex => getField<int>('row_index');
  set rowIndex(int? value) => setField<int>('row_index', value);

  int? get colIndex => getField<int>('col_index');
  set colIndex(int? value) => setField<int>('col_index', value);

  String? get plantId => getField<String>('plant_id');
  set plantId(String? value) => setField<String>('plant_id', value);
}
