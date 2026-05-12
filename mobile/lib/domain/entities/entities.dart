import 'package:flutter/foundation.dart';

@immutable
class HeritageEntity {
  final int id;
  final String title;
  final String content;
  final String era;
  final String? imageUrl;
  final String? videoUrl;
  final List<String> gallery;
  final String? audioUrl;

  const HeritageEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.era,
    this.imageUrl,
    this.videoUrl,
    this.gallery = const [],
    this.audioUrl,
  });
}

@immutable
class DictionaryEntity {
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

  const DictionaryEntity({
    required this.id,
    required this.kebenaWord,
    required this.amharicTranslation,
    required this.englishTranslation,
    this.audioUrl,
    this.videoUrl,
    this.imageUrl,
    this.category,
    this.examples = const [],
    this.synonyms = const [],
  });
}

@immutable
class NewsEntity {
  final int id;
  final String title;
  final String content;
  final String? imageUrl;
  final String? videoUrl;
  final List<String> gallery;
  final String category;
  final DateTime timestamp;

  const NewsEntity({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl,
    this.videoUrl,
    this.gallery = const [],
    required this.category,
    required this.timestamp,
  });
}

@immutable
class EventEntity {
  final int id;
  final String title;
  final String description;
  final String location;
  final DateTime startDate;
  final DateTime endDate;
  final String? imageUrl;
  final String? videoUrl;
  final List<String> gallery;

  const EventEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.startDate,
    required this.endDate,
    this.imageUrl,
    this.videoUrl,
    this.gallery = const [],
  });
}

@immutable
class HeroEntity {
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

  const HeroEntity({
    required this.id,
    required this.name,
    required this.title,
    required this.era,
    this.birthYear,
    this.deathYear,
    required this.shortBio,
    required this.fullStory,
    required this.legacy,
    this.braveryQuote,
    this.imageUrl,
    required this.category,
  });
}

@immutable
class DidYouKnowEntity {
  final int id;
  final String emoji;
  final String label;
  final String fact;
  final String detail;
  final String accentColor;
  final String? source;
  final String category;

  const DidYouKnowEntity({
    required this.id,
    required this.emoji,
    required this.label,
    required this.fact,
    required this.detail,
    required this.accentColor,
    this.source,
    required this.category,
  });
}

@immutable
class PaginatedResult<T> {
  final List<T> items;
  final int total;
  final int page;
  final int totalPages;

  const PaginatedResult({
    required this.items,
    required this.total,
    required this.page,
    required this.totalPages,
  });

  bool get hasNextPage => page < totalPages;
}
