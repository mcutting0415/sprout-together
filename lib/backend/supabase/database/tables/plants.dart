import '../database.dart';

class PlantsTable extends SupabaseTable<PlantsRow> {
  @override
  String get tableName => 'plants';

  @override
  PlantsRow createRow(Map<String, dynamic> data) => PlantsRow(data);
}

class PlantsRow extends SupabaseDataRow {
  PlantsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PlantsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get plantName => getField<String>('plant_name');
  set plantName(String? value) => setField<String>('plant_name', value);

  String? get category => getField<String>('category');
  set category(String? value) => setField<String>('category', value);

  int? get spacing => getField<int>('spacing');
  set spacing(int? value) => setField<int>('spacing', value);

  int? get daysToHarvest => getField<int>('days_to_harvest');
  set daysToHarvest(int? value) => setField<int>('days_to_harvest', value);

  String? get sunRequirement => getField<String>('sun_requirement');
  set sunRequirement(String? value) =>
      setField<String>('sun_requirement', value);

  String? get waterRequirement => getField<String>('water_requirement');
  set waterRequirement(String? value) =>
      setField<String>('water_requirement', value);

  String? get imageUrl => getField<String>('image_url');
  set imageUrl(String? value) => setField<String>('image_url', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  String? get growingTimeline => getField<String>('growing_timeline');
  set growingTimeline(String? value) =>
      setField<String>('growing_timeline', value);

  String? get whyGrow => getField<String>('why_grow');
  set whyGrow(String? value) => setField<String>('why_grow', value);

  String? get expertTips => getField<String>('expert_tips');
  set expertTips(String? value) => setField<String>('expert_tips', value);
}
