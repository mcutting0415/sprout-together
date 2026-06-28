import '../database.dart';

class UserSelectedPlantsTable extends SupabaseTable<UserSelectedPlantsRow> {
  @override
  String get tableName => 'user_selected_plants';

  @override
  UserSelectedPlantsRow createRow(Map<String, dynamic> data) =>
      UserSelectedPlantsRow(data);
}

class UserSelectedPlantsRow extends SupabaseDataRow {
  UserSelectedPlantsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UserSelectedPlantsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  String get plantId => getField<String>('plant_id')!;
  set plantId(String value) => setField<String>('plant_id', value);

  String? get season => getField<String>('season');
  set season(String? value) => setField<String>('season', value);
}
