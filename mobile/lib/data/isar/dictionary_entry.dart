import 'package:isar/isar.dart';

part 'dictionary_entry.g.dart';

@Collection()
class DictionaryEntry {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  late String kebenaWord;

  late String amharicTranslation;
  late String englishTranslation;
  String? audioUrl;
  String? videoUrl;
  String? imageUrl;
  String? category;
  DateTime? updatedAt;
}
