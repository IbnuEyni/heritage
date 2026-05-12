class NewsModel {
  final int id;
  final String title;
  final String content;
  final String? imageUrl;
  final String? videoUrl;
  final List<String> gallery;
  final String category;
  final DateTime timestamp;

  NewsModel({
    required this.id, required this.title, required this.content,
    this.imageUrl, this.videoUrl, this.gallery = const [],
    required this.category, required this.timestamp,
  });

  factory NewsModel.fromJson(Map<String, dynamic> j) => NewsModel(
        id: j['id'], title: j['title'], content: j['content'],
        imageUrl: j['image_url'], videoUrl: j['video_url'],
        gallery: List<String>.from(j['gallery'] ?? []),
        category: j['category'],
        timestamp: DateTime.parse(j['timestamp']),
      );
}

class PaginatedNewsModel {
  final List<NewsModel> items;
  final int total;
  final int page;
  final int totalPages;

  PaginatedNewsModel({
    required this.items, required this.total,
    required this.page, required this.totalPages,
  });

  factory PaginatedNewsModel.fromJson(Map<String, dynamic> j) =>
      PaginatedNewsModel(
        items: (j['items'] as List).map((e) => NewsModel.fromJson(e)).toList(),
        total: j['total'], page: j['page'], totalPages: j['pages'],
      );
}

class HeritageModel {
  final int id;
  final String title;
  final String content;
  final String era;
  final String? imageUrl;
  final String? videoUrl;
  final List<String> gallery;
  final String? audioUrl;

  HeritageModel({
    required this.id, required this.title, required this.content,
    required this.era, this.imageUrl, this.videoUrl,
    this.gallery = const [], this.audioUrl,
  });

  factory HeritageModel.fromJson(Map<String, dynamic> j) => HeritageModel(
        id: j['id'], title: j['title'], content: j['content'], era: j['era'],
        imageUrl: j['image_url'], videoUrl: j['video_url'],
        gallery: List<String>.from(j['gallery'] ?? []),
        audioUrl: j['audio_url'],
      );
}

class DictionaryModel {
  final int id;
  final String kebenaWord;
  final String amharicTranslation;
  final String englishTranslation;
  final String? audioUrl;
  final String? videoUrl;
  final String? imageUrl;
  final String? category;
  final List<String> examples;
  final List<String> synonyms;

  DictionaryModel({
    required this.id, required this.kebenaWord,
    required this.amharicTranslation, required this.englishTranslation,
    this.audioUrl, this.videoUrl, this.imageUrl, this.category,
    this.examples = const [], this.synonyms = const [],
  });

  factory DictionaryModel.fromJson(Map<String, dynamic> j) => DictionaryModel(
        id: j['id'], kebenaWord: j['kebena_word'],
        amharicTranslation: j['amharic_translation'],
        englishTranslation: j['english_translation'],
        audioUrl: j['audio_url'], videoUrl: j['video_url'],
        imageUrl: j['image_url'], category: j['category'],
        examples: List<String>.from(j['examples'] ?? []),
        synonyms: List<String>.from(j['synonyms'] ?? []),
      );
}

class HeroModel {
  final int id;
  final String name;
  final String title;
  final String era;
  final String? birthYear;
  final String? deathYear;
  final String shortBio;
  final String fullStory;
  final String legacy;
  final String? braveryQuote;
  final String? imageUrl;
  final String category;

  HeroModel({
    required this.id, required this.name, required this.title,
    required this.era, this.birthYear, this.deathYear,
    required this.shortBio, required this.fullStory, required this.legacy,
    this.braveryQuote, this.imageUrl, required this.category,
  });

  factory HeroModel.fromJson(Map<String, dynamic> j) => HeroModel(
        id: j['id'], name: j['name'], title: j['title'], era: j['era'],
        birthYear: j['birth_year'], deathYear: j['death_year'],
        shortBio: j['short_bio'], fullStory: j['full_story'],
        legacy: j['legacy'], braveryQuote: j['bravery_quote'],
        imageUrl: j['image_url'], category: j['category'],
      );
}

class DidYouKnowModel {
  final int id;
  final String emoji;
  final String label;
  final String fact;
  final String detail;
  final String accentColor;
  final String? source;
  final String category;

  DidYouKnowModel({
    required this.id, required this.emoji, required this.label,
    required this.fact, required this.detail, required this.accentColor,
    this.source, required this.category,
  });

  factory DidYouKnowModel.fromJson(Map<String, dynamic> j) => DidYouKnowModel(
        id: j['id'], emoji: j['emoji'], label: j['label'],
        fact: j['fact'], detail: j['detail'],
        accentColor: j['accent_color'], source: j['source'],
        category: j['category'],
      );
}
