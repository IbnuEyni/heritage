import '../entities/entities.dart';
import '../repositories/repositories.dart';

class GetHeritageUseCase {
  final IHeritageRepository _repo;
  const GetHeritageUseCase(this._repo);
  Result<List<HeritageEntity>> call() => _repo.getHeritage();
}

class GetDictionaryUseCase {
  final IDictionaryRepository _repo;
  const GetDictionaryUseCase(this._repo);
  Result<List<DictionaryEntity>> call() => _repo.getDictionary();
}

class SearchDictionaryUseCase {
  final IDictionaryRepository _repo;
  const SearchDictionaryUseCase(this._repo);
  Result<List<DictionaryEntity>> call(String query) =>
      _repo.searchDictionary(query);
}

class GetNewsUseCase {
  final INewsRepository _repo;
  const GetNewsUseCase(this._repo);
  Result<PaginatedResult<NewsEntity>> call({int page = 1}) =>
      _repo.getNews(page: page);
}

class GetEventsUseCase {
  final IEventsRepository _repo;
  const GetEventsUseCase(this._repo);
  Result<List<EventEntity>> call() => _repo.getEvents();
}

class GetWordOfTheDayUseCase {
  final IDictionaryRepository _repo;
  const GetWordOfTheDayUseCase(this._repo);

  Result<DictionaryEntity?> call() async {
    final result = await _repo.getDictionary();
    final words = result.data;
    if (words == null || words.isEmpty) return (data: null, failure: result.failure);
    final dayIndex = DateTime.now().difference(DateTime(DateTime.now().year)).inDays;
    return (data: words[dayIndex % words.length], failure: null);
  }
}
