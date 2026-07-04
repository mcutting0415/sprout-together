import '../database.dart';

class UserGoalsTable extends SupabaseTable<UserGoalsRow> {
  @override
  String get tableName => 'user_goals';

  @override
  UserGoalsRow createRow(Map<String, dynamic> data) => UserGoalsRow(data);
}

class UserGoalsRow extends SupabaseDataRow {
  UserGoalsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UserGoalsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  String get goalText => getField<String>('goal_text')!;
  set goalText(String value) => setField<String>('goal_text', value);

  String get goalType => getField<String>('goal_type') ?? 'initial';
  set goalType(String value) => setField<String>('goal_type', value);

  String? get season => getField<String>('season');
  set season(String? value) => setField<String>('season', value);

  bool get completed => getField<bool>('completed') ?? false;
  set completed(bool value) => setField<bool>('completed', value);

  DateTime? get completedAt => getField<DateTime>('completed_at');
  set completedAt(DateTime? value) => setField<DateTime>('completed_at', value);
}
