// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Kebena Heritage';

  @override
  String get appSubtitle => 'Special Woreda Portal';

  @override
  String get askKebenaAI => 'Ask Kebena AI';

  @override
  String get goodEvening => 'Good Evening,';

  @override
  String get exploreKebena => 'Explore Kebena';

  @override
  String get wordOfTheDay => 'WORD OF THE DAY';

  @override
  String get didYouKnow => 'Did You Know?';

  @override
  String get kebenaHeroes => 'Kebena Heroes';

  @override
  String get latestNews => 'Latest News';

  @override
  String get quickFacts => 'Quick Facts';

  @override
  String get seeAll => 'See all';

  @override
  String get readMore => 'Read more';

  @override
  String get read => 'Read';

  @override
  String get navHome => 'Home';

  @override
  String get navHeritage => 'Heritage';

  @override
  String get navDictionary => 'Dictionary';

  @override
  String get navNews => 'News';

  @override
  String get navHeroes => 'Heroes';

  @override
  String get heritageTimeline => 'Heritage Timeline';

  @override
  String get noHeritageArticles => 'No heritage articles yet';

  @override
  String get affooLanguage => 'Affoo Language · Kebena Woreda';

  @override
  String get affooDictionary => 'Affoo Dictionary';

  @override
  String get searchHint => 'Search Kebena, Amharic or English…';

  @override
  String wordsInLibrary(int count) {
    return '$count words in the library';
  }

  @override
  String searchResults(int count, String query) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 's',
      one: '',
    );
    return '$count result$_temp0 for \"$query\"';
  }

  @override
  String noResultsFor(String query) {
    return 'No results for \"$query\"';
  }

  @override
  String get tryDifferentSpelling => 'Try a different spelling or language';

  @override
  String get dictionaryEmpty => 'Dictionary is empty';

  @override
  String get wordsWillAppear => 'Words will appear here once synced';

  @override
  String get translations => 'Translations';

  @override
  String get exampleSentences => 'Example Sentences';

  @override
  String get synonyms => 'Synonyms';

  @override
  String get copyWord => 'Copy word';

  @override
  String wordCopied(String word) {
    return '\"$word\" copied';
  }

  @override
  String get audioUnavailable => 'Audio unavailable — check your connection';

  @override
  String get woredaNews => 'Woreda News';

  @override
  String get noNewsYet => 'No news yet';

  @override
  String get previousPage => '← Previous';

  @override
  String get nextPage => 'Next →';

  @override
  String page(int number) {
    return 'Page $number';
  }

  @override
  String get hallOfLegends => 'HALL OF LEGENDS';

  @override
  String get heroesSubtitle =>
      'Warriors, scholars & spiritual leaders\nwho shaped our history';

  @override
  String get noHeroesFound => 'No heroes found';

  @override
  String get filterAll => 'All';

  @override
  String get filterWarrior => 'Warrior';

  @override
  String get filterScholar => 'Scholar';

  @override
  String get filterLeader => 'Leader';

  @override
  String get filterSpiritual => 'Spiritual';

  @override
  String get settings => 'Settings';

  @override
  String get appearance => 'Appearance';

  @override
  String get theme => 'Theme';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeLight => 'Light';

  @override
  String get themeSystem => 'System default';

  @override
  String get notifications => 'Notifications';

  @override
  String get pushNotifications => 'Push Notifications';

  @override
  String get pushNotificationsSubtitle => 'Receive alerts from the Woreda';

  @override
  String get woredaUpdates => 'Woreda Updates';

  @override
  String get woredaUpdatesSubtitle => 'News and announcements';

  @override
  String get culturalEvents => 'Cultural Events';

  @override
  String get culturalEventsSubtitle => 'Festivals and community gatherings';

  @override
  String get dataSync => 'Data & Sync';

  @override
  String get offlineMode => 'Offline Mode';

  @override
  String get offlineModeSubtitle => 'Use only cached data, skip network calls';

  @override
  String get syncNow => 'Sync Now';

  @override
  String get syncNowSubtitle => 'Refresh heritage & dictionary data';

  @override
  String get syncComplete => 'Sync complete';

  @override
  String get clearCache => 'Clear Cache';

  @override
  String get clearCacheSubtitle => 'Remove all locally stored data';

  @override
  String get clearCacheDialogContent =>
      'This will remove all locally stored heritage and dictionary data. You will need an internet connection to reload content.';

  @override
  String get cacheCleared => 'Cache cleared';

  @override
  String get cancel => 'Cancel';

  @override
  String get clear => 'Clear';

  @override
  String get language => 'Language';

  @override
  String get appLanguage => 'App Language';

  @override
  String get about => 'About';

  @override
  String get aboutApp => 'About Kebena Heritage';

  @override
  String get version => 'Version 1.0.0';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get privacyPolicySubtitle => 'How we handle your data';

  @override
  String get termsOfUse => 'Terms of Use';

  @override
  String get termsOfUseSubtitle => 'Usage guidelines';

  @override
  String get appFooter =>
      'Kebena Heritage App v1.0.0\nBuilt with ❤️ for the Kebena Community';

  @override
  String get retry => 'Retry';

  @override
  String error(String message) {
    return 'Error: $message';
  }
}
