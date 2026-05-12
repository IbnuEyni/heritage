import 'package:isar/isar.dart';

part 'did_you_know_item.g.dart';

@Collection()
class DidYouKnowItem {
  Id id = Isar.autoIncrement;
  late int serverId;
  late String emoji;
  late String label;
  late String fact;
  late String detail;
  late String accentColor;
  String? source;
  late String category;
  DateTime? updatedAt;
}
