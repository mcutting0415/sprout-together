import '../database.dart';

class ProfilesTable extends SupabaseTable<ProfilesRow> {
  @override
  String get tableName => 'profiles';

  @override
  ProfilesRow createRow(Map<String, dynamic> data) => ProfilesRow(data);
}

class ProfilesRow extends SupabaseDataRow {
  ProfilesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ProfilesTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get fullName => getField<String>('full_name');
  set fullName(String? value) => setField<String>('full_name', value);

  String? get town => getField<String>('town');
  set town(String? value) => setField<String>('town', value);

  String? get profileImageUrl => getField<String>('profile_image_url');
  set profileImageUrl(String? value) =>
      setField<String>('profile_image_url', value);

  String? get gardeningZone => getField<String>('gardening_zone');
  set gardeningZone(String? value) => setField<String>('gardening_zone', value);

  String? get zipCode => getField<String>('zip_code');
  set zipCode(String? value) => setField<String>('zip_code', value);

  List<String> get gardenTypes => getListField<String>('garden_types');
  set gardenTypes(List<String>? value) =>
      setListField<String>('garden_types', value);

  String? get experienceLevel => getField<String>('experience_level');
  set experienceLevel(String? value) =>
      setField<String>('experience_level', value);

  List<String> get goals => getListField<String>('goals');
  set goals(List<String>? value) => setListField<String>('goals', value);

  bool? get hasCompletedSetup => getField<bool>('has_completed_setup');
  set hasCompletedSetup(bool? value) =>
      setField<bool>('has_completed_setup', value);
}
