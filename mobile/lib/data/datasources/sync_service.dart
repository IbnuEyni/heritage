import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../datasources/api_client.dart';
import '../datasources/isar_service.dart';
import '../isar/dictionary_entry.dart';
import '../isar/did_you_know_item.dart';
import '../isar/heritage_article.dart';
import '../isar/hero_item.dart';
import '../../core/network/network_info.dart';
import '../../main.dart';

class SyncService {
  final IsarService _isar;
  final Ref _ref;
  SyncService(this._isar, this._ref);

  String get _lang => _ref.read(localeProvider).languageCode;

  Future<void> sync() async {
    if (!await NetworkInfo.isConnected) return;

    final lang = _lang;

    try {
      final lastSync = await _isar.getLastSyncAt();
      final data = await ApiClient.fetchSync(lastSync, lang: lang);

      final heritageData   = data['heritage']   as List;
      final dictionaryData = data['dictionary']  as List;

      if (heritageData.isNotEmpty) {
        final articles = heritageData.map((h) => HeritageArticle()
          ..serverId  = h['id']
          ..title     = h['title']
          ..content   = h['content']
          ..era       = h['era']
          ..imageUrl  = h['image_url']
          ..updatedAt = h['updated_at'] != null
              ? DateTime.parse(h['updated_at'])
              : null).toList();
        await _isar.upsertHeritageArticles(articles);
      }

      if (dictionaryData.isNotEmpty) {
        final entries = dictionaryData.map((d) => DictionaryEntry()
          ..kebenaWord         = d['kebena_word']
          ..amharicTranslation = d['amharic_translation']
          ..englishTranslation = d['english_translation']
          ..audioUrl           = d['audio_url']
          ..category           = d['category']
          ..updatedAt          = d['updated_at'] != null
              ? DateTime.parse(d['updated_at'])
              : null).toList();
        await _isar.upsertDictionaryEntries(entries);
      }

      await _isar.setLastSyncAt(DateTime.parse(data['synced_at']));

      // Heroes
      try {
        final heroes = await ApiClient.fetchHeroes(lang: lang);
        await _isar.syncHeroes(heroes.map((h) => HeroItem()
          ..serverId    = h.id
          ..name        = h.name
          ..title       = h.title
          ..era         = h.era
          ..birthYear   = h.birthYear
          ..deathYear   = h.deathYear
          ..shortBio    = h.shortBio
          ..fullStory   = h.fullStory
          ..legacy      = h.legacy
          ..braveryQuote = h.braveryQuote
          ..imageUrl    = h.imageUrl
          ..category    = h.category).toList());
      } catch (_) {}

      // Did You Know
      try {
        final dyks = await ApiClient.fetchDidYouKnow(lang: lang);
        await _isar.syncDidYouKnow(dyks.map((d) => DidYouKnowItem()
          ..serverId    = d.id
          ..emoji       = d.emoji
          ..label       = d.label
          ..fact        = d.fact
          ..detail      = d.detail
          ..accentColor = d.accentColor
          ..source      = d.source
          ..category    = d.category).toList());
      } catch (_) {}

      // News page 1
      try {
        final news = await ApiClient.fetchNews(lang: lang);
        await _isar.cacheNews(1, news);
      } catch (_) {}
    } catch (_) {
      // Sync failure is silent — cached data remains available
    }
  }
}

final syncServiceProvider = Provider(
  (ref) => SyncService(IsarService(), ref),
);
