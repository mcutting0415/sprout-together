import '../database.dart';

class GardenTasksTable extends SupabaseTable<GardenTasksRow> {
  @override
  String get tableName => 'garden_tasks';

  @override
  GardenTasksRow createRow(Map<String, dynamic> data) => GardenTasksRow(data);
}

class GardenTasksRow extends SupabaseDataRow {
  GardenTasksRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => GardenTasksTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String get gardenId => getField<String>('garden_id')!;
  set gardenId(String value) => setField<String>('garden_id', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  String? get taskName => getField<String>('task_name');
  set taskName(String? value) => setField<String>('task_name', value);

  DateTime? get dueDate => getField<DateTime>('due_date');
  set dueDate(DateTime? value) => setField<DateTime>('due_date', value);

  bool? get completed => getField<bool>('completed');
  set completed(bool? value) => setField<bool>('completed', value);

  String? get taskType => getField<String>('task_type');
  set taskType(String? value) => setField<String>('task_type', value);

  String? get notes => getField<String>('notes');
  set notes(String? value) => setField<String>('notes', value);
}
