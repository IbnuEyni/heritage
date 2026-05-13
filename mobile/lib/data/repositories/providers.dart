import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';
import '../../core/errors/failures.dart';
import '../datasources/isar_service.dart';
import '../isar/notification_item.dart';
import '../repositories/repository_impl.dart';
import '../../main.dart';

// ── Services ──────────────────────────────────────────────────────────────────
final isarServiceProvider = Provider<IsarService>((ref) => IsarService());

// ── Repositories ──────────────────────────────────────────────────────────────
final heritageRepoProvider = Provider(
  (ref) => HeritageRepository(ref.read(isarServiceProvider)),
);
final dictionaryRepoProvider = Provider(
  (ref) => DictionaryRepository(ref.read(isarServiceProvider)),
);
final newsRepoProvider = Provider((ref) => NewsRepository(ref.read(isarServiceProvider)));
final eventsRepoProvider = Provider((ref) => EventsRepository());
final heroesRepoProvider = Provider((ref) => HeroesRepository(ref.read(isarServiceProvider)));
final didYouKnowRepoProvider = Provider((ref) => DidYouKnowRepository(ref.read(isarServiceProvider)));

// ── Use Cases ─────────────────────────────────────────────────────────────────
final getHeritageUseCaseProvider = Provider(
  (ref) => GetHeritageUseCase(ref.read(heritageRepoProvider)),
);
final getDictionaryUseCaseProvider = Provider(
  (ref) => GetDictionaryUseCase(ref.read(dictionaryRepoProvider)),
);
final searchDictionaryUseCaseProvider = Provider(
  (ref) => SearchDictionaryUseCase(ref.read(dictionaryRepoProvider)),
);
final getNewsUseCaseProvider = Provider(
  (ref) => GetNewsUseCase(ref.read(newsRepoProvider)),
);
final getEventsUseCaseProvider = Provider(
  (ref) => GetEventsUseCase(ref.read(eventsRepoProvider)),
);
final getWordOfTheDayUseCaseProvider = Provider(
  (ref) => GetWordOfTheDayUseCase(ref.read(dictionaryRepoProvider)),
);

// ── State ─────────────────────────────────────────────────────────────────────
typedef AsyncResult<T> = ({T? data, Failure? failure, bool isLoading});

// Heritage — re-fetches when locale changes
final heritageProvider =
    FutureProvider<({List<HeritageEntity>? data, Failure? failure})>(
        (ref) async {
  final lang = ref.watch(localeProvider).languageCode;
  return ref.read(heritageRepoProvider).getHeritage(lang: lang);
});

// Dictionary
final searchQueryProvider = StateProvider<String>((ref) => '');

final dictionaryProvider =
    FutureProvider<({List<DictionaryEntity>? data, Failure? failure})>(
        (ref) async {
  final lang = ref.watch(localeProvider).languageCode;
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) {
    return ref.read(dictionaryRepoProvider).getDictionary(lang: lang);
  }
  return ref.read(dictionaryRepoProvider).searchDictionary(query, lang: lang);
});

// News
final newsPageProvider = StateProvider<int>((ref) => 1);

final newsProvider =
    FutureProvider<({PaginatedResult<NewsEntity>? data, Failure? failure})>(
        (ref) async {
  final lang = ref.watch(localeProvider).languageCode;
  final page = ref.watch(newsPageProvider);
  return ref.read(newsRepoProvider).getNews(page: page, lang: lang);
});

// Events
final eventsProvider =
    FutureProvider<({List<EventEntity>? data, Failure? failure})>((ref) async {
  return ref.read(getEventsUseCaseProvider)();
});

// Heroes
final heroesProvider =
    FutureProvider<({List<HeroEntity>? data, Failure? failure})>((ref) async {
  final lang = ref.watch(localeProvider).languageCode;
  return ref.read(heroesRepoProvider).getHeroes(lang: lang);
});

// Word of the Day
final wordOfTheDayProvider =
    FutureProvider<({DictionaryEntity? data, Failure? failure})>((ref) async {
  ref.watch(localeProvider);
  return ref.read(getWordOfTheDayUseCaseProvider)();
});

// Did You Know
final didYouKnowProvider =
    FutureProvider<({List<DidYouKnowEntity>? data, Failure? failure})>((ref) async {
  final lang = ref.watch(localeProvider).languageCode;
  return ref.read(didYouKnowRepoProvider).getDidYouKnow(lang: lang);
});

// ── Notifications ─────────────────────────────────────────────────────────────
class NotificationNotifier extends StateNotifier<List<NotificationItem>> {
  final IsarService _isar;
  NotificationNotifier(this._isar) : super([]) {
    _load();
  }

  Future<void> _load() async {
    state = await _isar.getNotifications();
  }

  Future<void> add(NotificationItem item) async {
    await _isar.saveNotification(item);
    await _load();
  }

  Future<void> markAllRead() async {
    await _isar.markAllRead();
    await _load();
  }

  Future<void> delete(int id) async {
    await _isar.deleteNotification(id);
    await _load();
  }

  Future<void> clearAll() async {
    await _isar.clearAllNotifications();
    await _load();
  }

  int get unreadCount => state.where((n) => !n.isRead).length;
}

final notificationProvider =
    StateNotifierProvider<NotificationNotifier, List<NotificationItem>>(
  (ref) => NotificationNotifier(IsarService()),
);
