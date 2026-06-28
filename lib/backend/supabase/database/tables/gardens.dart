import '../database.dart';

class GardensTable extends SupabaseTable<GardensRow> {
  @override
  String get tableName => 'gardens';

  @override
  GardensRow createRow(Map<String, dynamic> data) => GardensRow(data);
}

class GardensRow extends SupabaseDataRow {
  GardensRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => GardensTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  String? get gardenName => getField<String>('garden_name');
  set gardenName(String? value) => setField<String>('garden_name', value);

  String? get gardenType => getField<String>('garden_type');
  set gardenType(String? value) => setField<String>('garden_type', value);

  int? get width => getField<int>('width');
  set width(int? value) => setField<int>('width', value);

  int? get length => getField<int>('length');
  set length(int? value) => setField<int>('length', value);

  String? get measurementUnit => getField<String>('measurement_unit');
  set measurementUnit(String? value) =>
      setField<String>('measurement_unit', value);

  String? get orientation => getField<String>('orientation');
  set orientation(String? value) => setField<String>('orientation', value);

  String? get sunExposure => getField<String>('sun_exposure');
  set sunExposure(String? value) => setField<String>('sun_exposure', value);

  String? get notes => getField<String>('notes');
  set notes(String? value) => setField<String>('notes', value);

  bool? get isArchived => getField<bool>('is_archived');
  set isArchived(bool? value) => setField<bool>('is_archived', value);
}
