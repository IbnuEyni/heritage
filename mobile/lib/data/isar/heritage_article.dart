import 'package:isar/isar.dart';

part 'heritage_article.g.dart';

@Collection()
class HeritageArticle {
  Id id = Isar.autoIncrement;
  late int serverId;
  late String title;
  late String content;
  late String era;
  String? imageUrl;
  String? videoUrl;
  List<String> gallery = [];
  String? audioUrl;
  DateTime? updatedAt;
}
