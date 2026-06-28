import '../database.dart';

class GardenJournalEntriesTable extends SupabaseTable<GardenJournalEntriesRow> {
  @override
  String get tableName => 'garden_journal_entries';

  @override
  GardenJournalEntriesRow createRow(Map<String, dynamic> data) =>
      GardenJournalEntriesRow(data);
}

class GardenJournalEntriesRow extends SupabaseDataRow {
  GardenJournalEntriesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => GardenJournalEntriesTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  String? get gardenId => getField<String>('garden_id');
  set gardenId(String? value) => setField<String>('garden_id', value);

  String? get plantId => getField<String>('plant_id');
  set plantId(String? value) => setField<String>('plant_id', value);

  String? get title => getField<String>('title');
  set title(String? value) => setField<String>('title', value);

  String? get entryText => getField<String>('entry_text');
  set entryText(String? value) => setField<String>('entry_text', value);

  String? get imageUrl => getField<String>('image_url');
  set imageUrl(String? value) => setField<String>('image_url', value);

  DateTime? get entryDate => getField<DateTime>('entry_date');
  set entryDate(DateTime? value) => setField<DateTime>('entry_date', value);
}
