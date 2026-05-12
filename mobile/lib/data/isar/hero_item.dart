import 'package:isar/isar.dart';

part 'hero_item.g.dart';

@Collection()
class HeroItem {
  Id id = Isar.autoIncrement;
  late int serverId;
  late String name;
  late String title;
  late String era;
  String? birthYear;
  String? deathYear;
  late String shortBio;
  late String fullStory;
  late String legacy;
  String? braveryQuote;
  String? imageUrl;
  late String category;
  DateTime? updatedAt;
}
