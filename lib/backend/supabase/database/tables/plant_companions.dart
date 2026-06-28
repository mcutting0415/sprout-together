import '../database.dart';

class PlantCompanionsTable extends SupabaseTable<PlantCompanionsRow> {
  @override
  String get tableName => 'plant_companions';

  @override
  PlantCompanionsRow createRow(Map<String, dynamic> data) =>
      PlantCompanionsRow(data);
}

class PlantCompanionsRow extends SupabaseDataRow {
  PlantCompanionsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PlantCompanionsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String get plantId => getField<String>('plant_id')!;
  set plantId(String value) => setField<String>('plant_id', value);

  String get relatedPlantId => getField<String>('related_plant_id')!;
  set relatedPlantId(String value) =>
      setField<String>('related_plant_id', value);

  String get relationshipType => getField<String>('relationship_type')!;
  set relationshipType(String value) =>
      setField<String>('relationship_type', value);

  String? get reason => getField<String>('reason');
  set reason(String? value) => setField<String>('reason', value);
}
