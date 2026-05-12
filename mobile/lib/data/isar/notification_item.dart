import 'package:isar/isar.dart';

part 'notification_item.g.dart';

@Collection()
class NotificationItem {
  Id id = Isar.autoIncrement;
  late String title;
  late String body;
  String? topic;
  late bool isRead;
  late DateTime receivedAt;
}
