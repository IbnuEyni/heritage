import 'dart:convert';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../isar/dictionary_entry.dart';
import '../isar/did_you_know_item.dart';
import '../isar/heritage_article.dart';
import '../isar/hero_item.dart';
import '../isar/notification_item.dart';
import '../models/api_models.dart';

class IsarService {
  static late Isar _isar;
  static const _lastSyncKey = 'last_sync_at';

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [DictionaryEntrySchema, HeritageArticleSchema, HeroItemSchema, DidYouKnowItemSchema, NotificationItemSchema],
      directory: dir.path,
    );
  }

  // Last sync timestamp
  Future<DateTime?> getLastSyncAt() async {
    final prefs = await SharedPreferences.getInstance();
    final val = prefs.getString(_lastSyncKey);
    return val != null ? DateTime.parse(val) : null;
  }

  Future<void> setLastSyncAt(DateTime dt) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastSyncKey, dt.toIso8601String());
  }

  // Dictionary
  Future<List<DictionaryEntry>> searchWords(String query) {
    return _isar.dictionaryEntrys
        .filter()
        .kebenaWordContains(query, caseSensitive: false)
        .or()
        .englishTranslationContains(query, caseSensitive: false)
        .or()
        .amharicTranslationContains(query, caseSensitive: false)
        .findAll();
  }

  Future<void> syncDictionary(List<DictionaryEntry> entries) async {
    await _isar.writeTxn(() async {
      await _isar.dictionaryEntrys.clear();
      await _isar.dictionaryEntrys.putAll(entries);
    });
  }

  Future<void> upsertDictionaryEntries(List<DictionaryEntry> entries) async {
    await _isar.writeTxn(() => _isar.dictionaryEntrys.putAll(entries));
  }

  // Heritage
  Future<List<HeritageArticle>> getHeritageArticles() {
    return _isar.heritageArticles.where().findAll();
  }

  Future<void> syncHeritage(List<HeritageArticle> articles) async {
    await _isar.writeTxn(() async {
      await _isar.heritageArticles.clear();
      await _isar.heritageArticles.putAll(articles);
    });
  }

  Future<void> upsertHeritageArticles(List<HeritageArticle> articles) async {
    await _isar.writeTxn(() => _isar.heritageArticles.putAll(articles));
  }

  // Heroes
  Future<List<HeroItem>> getHeroes() => _isar.heroItems.where().findAll();

  Future<void> syncHeroes(List<HeroItem> items) async {
    await _isar.writeTxn(() async {
      await _isar.heroItems.clear();
      await _isar.heroItems.putAll(items);
    });
  }

  // Did You Know
  Future<List<DidYouKnowItem>> getDidYouKnow() => _isar.didYouKnowItems.where().findAll();

  Future<void> syncDidYouKnow(List<DidYouKnowItem> items) async {
    await _isar.writeTxn(() async {
      await _isar.didYouKnowItems.clear();
      await _isar.didYouKnowItems.putAll(items);
    });
  }

  // Notifications
  Future<List<NotificationItem>> getNotifications() =>
      _isar.notificationItems.where().sortByReceivedAtDesc().findAll();

  Future<int> getUnreadCount() =>
      _isar.notificationItems.filter().isReadEqualTo(false).count();

  Future<void> saveNotification(NotificationItem item) async {
    await _isar.writeTxn(() => _isar.notificationItems.put(item));
  }

  Future<void> markAllRead() async {
    await _isar.writeTxn(() async {
      final all = await _isar.notificationItems.where().findAll();
      for (final n in all) {
        n.isRead = true;
      }
      await _isar.notificationItems.putAll(all);
    });
  }

  Future<void> deleteNotification(Id id) async {
    await _isar.writeTxn(() => _isar.notificationItems.delete(id));
  }

  Future<void> clearAllNotifications() async {
    await _isar.writeTxn(() => _isar.notificationItems.clear());
  }

  // News (cached as JSON per page in SharedPreferences)
  static const _newsCachePrefix = 'news_page_';

  Future<PaginatedNewsModel?> getCachedNews(int page) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('$_newsCachePrefix$page');
    if (raw == null) return null;
    return PaginatedNewsModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> cacheNews(int page, PaginatedNewsModel data) async {
    final prefs = await SharedPreferences.getInstance();
    final json = {
      'items': data.items.map((n) => {
        'id': n.id, 'title': n.title, 'content': n.content,
        'image_url': n.imageUrl, 'video_url': n.videoUrl,
        'gallery': n.gallery, 'category': n.category,
        'timestamp': n.timestamp.toIso8601String(),
      }).toList(),
      'total': data.total,
      'page': data.page,
      'pages': data.totalPages,
    };
    await prefs.setString('$_newsCachePrefix$page', jsonEncode(json));
  }
}
