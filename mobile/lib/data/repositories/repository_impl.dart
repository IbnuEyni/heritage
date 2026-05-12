import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../core/constants/app_constants.dart';
import '../../core/errors/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/api_client.dart';
import '../datasources/isar_service.dart';
import '../isar/dictionary_entry.dart';
import '../isar/heritage_article.dart';
import '../isar/hero_item.dart';
import '../isar/did_you_know_item.dart';

// ── Heritage ──────────────────────────────────────────────────────────────────
class HeritageRepository implements IHeritageRepository {
  final IsarService _isar;
  HeritageRepository(this._isar);

  @override
  Result<List<HeritageEntity>> getHeritage() async {
    // Always try network first — don't rely on cache being empty
    final connected = await NetworkInfo.isConnected;
    debugPrint('[HeritageRepo] connected=$connected baseUrl=${AppConstants.baseUrl}');
    if (connected) {
      try {
        final remote = await ApiClient.fetchHeritage();
        debugPrint('[HeritageRepo] fetched ${remote.length} articles');
        final articles = remote
            .map((h) => HeritageArticle()
              ..serverId = h.id
              ..title    = h.title
              ..content  = h.content
              ..era      = h.era
              ..imageUrl = h.imageUrl
              ..videoUrl = h.videoUrl
              ..gallery  = h.gallery
              ..audioUrl = h.audioUrl)
            .toList();
        await _isar.syncHeritage(articles);
      } catch (_) {
        // network fetch failed — fall through to cache
      }
    }

    // Return whatever is in cache (fresh or stale)
    final cached = await _isar.getHeritageArticles();
    if (cached.isEmpty) {
      return (data: null, failure: const ServerFailure('No data available. Make sure the server is running and the IP in app_constants.dart is correct.'));
    }
    return (data: cached.map(_toEntity).toList(), failure: null);
  }

  HeritageEntity _toEntity(HeritageArticle a) => HeritageEntity(
        id:       a.serverId,
        title:    a.title,
        content:  a.content,
        era:      a.era,
        imageUrl: a.imageUrl,
        videoUrl: a.videoUrl,
        gallery:  a.gallery,
        audioUrl: a.audioUrl,
      );
}

// ── Dictionary ────────────────────────────────────────────────────────────────
class DictionaryRepository implements IDictionaryRepository {
  final IsarService _isar;
  DictionaryRepository(this._isar);

  @override
  Result<List<DictionaryEntity>> getDictionary() => searchDictionary('');

  @override
  Result<List<DictionaryEntity>> searchDictionary(String query) async {
    // Always try to refresh from network when query is empty (full list)
    if (query.isEmpty && await NetworkInfo.isConnected) {
      try {
        final remote = await ApiClient.fetchDictionary();
        final entries = remote
            .map((d) => DictionaryEntry()
              ..kebenaWord          = d.kebenaWord
              ..amharicTranslation  = d.amharicTranslation
              ..englishTranslation  = d.englishTranslation
              ..audioUrl            = d.audioUrl
              ..videoUrl            = d.videoUrl
              ..imageUrl            = d.imageUrl
              ..category            = d.category)
            .toList();
        await _isar.syncDictionary(entries);
      } catch (_) {
        // fall through to cache
      }
    }

    final results = await _isar.searchWords(query);
    if (results.isEmpty && query.isEmpty) {
      return (data: null, failure: const ServerFailure('Dictionary not loaded yet. Check server connection.'));
    }
    return (data: results.map(_toEntity).toList(), failure: null);
  }

  DictionaryEntity _toEntity(DictionaryEntry e) => DictionaryEntity(
        id:                  e.id,
        kebenaWord:          e.kebenaWord,
        amharicTranslation:  e.amharicTranslation,
        englishTranslation:  e.englishTranslation,
        audioUrl:            e.audioUrl,
        videoUrl:            e.videoUrl,
        imageUrl:            e.imageUrl,
        category:            e.category,
        // examples & synonyms come from API only; not cached in Isar
        examples:            const [],
        synonyms:            const [],
      );
}

// ── News ──────────────────────────────────────────────────────────────────────
class NewsRepository implements INewsRepository {
  final IsarService _isar;
  NewsRepository(this._isar);

  @override
  Result<PaginatedResult<NewsEntity>> getNews({int page = 1}) async {
    if (await NetworkInfo.isConnected) {
      try {
        final remote = await ApiClient.fetchNews(page: page);
        await _isar.cacheNews(page, remote);
        return (data: _toPaginated(remote), failure: null);
      } on DioException catch (e) {
        // fall through to cache
        debugPrint('[NewsRepo] network error: ${e.message}');
      } catch (_) {}
    }
    final cached = await _isar.getCachedNews(page);
    if (cached == null) return (data: null, failure: const NetworkFailure());
    return (data: _toPaginated(cached), failure: null);
  }

  PaginatedResult<NewsEntity> _toPaginated(remote) => PaginatedResult(
        items: (remote.items as List).map((n) => NewsEntity(
          id: n.id, title: n.title, content: n.content,
          imageUrl: n.imageUrl, videoUrl: n.videoUrl,
          gallery: n.gallery, category: n.category, timestamp: n.timestamp,
        )).toList(),
        total: remote.total, page: remote.page, totalPages: remote.totalPages,
      );
}

// ── Events ────────────────────────────────────────────────────────────────────
class EventsRepository implements IEventsRepository {
  @override
  Result<List<EventEntity>> getEvents() async {
    return (data: const <EventEntity>[], failure: null);
  }
}

// ── Heroes ────────────────────────────────────────────────────────────────────
class HeroesRepository {
  final IsarService _isar;
  HeroesRepository(this._isar);

  Result<List<HeroEntity>> getHeroes() async {
    if (await NetworkInfo.isConnected) {
      try {
        final remote = await ApiClient.fetchHeroes();
        await _isar.syncHeroes(remote.map((h) => HeroItem()
          ..serverId = h.id ..name = h.name ..title = h.title ..era = h.era
          ..birthYear = h.birthYear ..deathYear = h.deathYear
          ..shortBio = h.shortBio ..fullStory = h.fullStory ..legacy = h.legacy
          ..braveryQuote = h.braveryQuote ..imageUrl = h.imageUrl
          ..category = h.category).toList());
      } catch (_) {}
    }
    final cached = await _isar.getHeroes();
    if (cached.isEmpty) return (data: null, failure: const NetworkFailure());
    return (data: cached.map(_toEntity).toList(), failure: null);
  }

  HeroEntity _toEntity(HeroItem h) => HeroEntity(
        id: h.serverId, name: h.name, title: h.title, era: h.era,
        birthYear: h.birthYear, deathYear: h.deathYear,
        shortBio: h.shortBio, fullStory: h.fullStory, legacy: h.legacy,
        braveryQuote: h.braveryQuote, imageUrl: h.imageUrl, category: h.category,
      );
}

// ── Did You Know ──────────────────────────────────────────────────────────────
class DidYouKnowRepository {
  final IsarService _isar;
  DidYouKnowRepository(this._isar);

  Result<List<DidYouKnowEntity>> getDidYouKnow() async {
    if (await NetworkInfo.isConnected) {
      try {
        final remote = await ApiClient.fetchDidYouKnow();
        await _isar.syncDidYouKnow(remote.map((d) => DidYouKnowItem()
          ..serverId = d.id ..emoji = d.emoji ..label = d.label
          ..fact = d.fact ..detail = d.detail ..accentColor = d.accentColor
          ..source = d.source ..category = d.category).toList());
      } catch (_) {}
    }
    final cached = await _isar.getDidYouKnow();
    if (cached.isEmpty) return (data: null, failure: const NetworkFailure());
    return (data: cached.map(_toEntity).toList(), failure: null);
  }

  DidYouKnowEntity _toEntity(DidYouKnowItem d) => DidYouKnowEntity(
        id: d.serverId, emoji: d.emoji, label: d.label, fact: d.fact,
        detail: d.detail, accentColor: d.accentColor,
        source: d.source, category: d.category,
      );
}
