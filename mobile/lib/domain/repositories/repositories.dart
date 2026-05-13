import '../entities/entities.dart';
import '../../core/errors/failures.dart';

// Result type — either a Failure or a value
typedef Result<T> = Future<({T? data, Failure? failure})>;

abstract class IHeritageRepository {
  Result<List<HeritageEntity>> getHeritage({String lang = 'en'});
}

abstract class IDictionaryRepository {
  Result<List<DictionaryEntity>> getDictionary({String lang = 'en'});
  Result<List<DictionaryEntity>> searchDictionary(String query, {String lang = 'en'});
}

abstract class INewsRepository {
  Result<PaginatedResult<NewsEntity>> getNews({int page = 1, String lang = 'en'});
}

abstract class IEventsRepository {
  Result<List<EventEntity>> getEvents();
}
