import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_am.dart';
import 'app_localizations_en.dart';
import 'app_localizations_om.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('am'),
    Locale('en'),
    Locale('om')
  ];

  /// App title
  ///
  /// In en, this message translates to:
  /// **'Kebena Heritage'**
  String get appTitle;

  /// App subtitle shown in collapsed app bar
  ///
  /// In en, this message translates to:
  /// **'Special Woreda Portal'**
  String get appSubtitle;

  /// FAB label on home screen
  ///
  /// In en, this message translates to:
  /// **'Ask Kebena AI'**
  String get askKebenaAI;

  /// Greeting on home screen banner
  ///
  /// In en, this message translates to:
  /// **'Good Evening,'**
  String get goodEvening;

  /// Hero title on home screen
  ///
  /// In en, this message translates to:
  /// **'Explore Kebena'**
  String get exploreKebena;

  /// Word of the day label
  ///
  /// In en, this message translates to:
  /// **'WORD OF THE DAY'**
  String get wordOfTheDay;

  /// Did you know section header
  ///
  /// In en, this message translates to:
  /// **'Did You Know?'**
  String get didYouKnow;

  /// Heroes section header
  ///
  /// In en, this message translates to:
  /// **'Kebena Heroes'**
  String get kebenaHeroes;

  /// News section header
  ///
  /// In en, this message translates to:
  /// **'Latest News'**
  String get latestNews;

  /// Quick facts section header
  ///
  /// In en, this message translates to:
  /// **'Quick Facts'**
  String get quickFacts;

  /// See all action label
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// Read more action label
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get readMore;

  /// Short read label on hero cards
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get read;

  /// Bottom nav home label
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// Bottom nav heritage label
  ///
  /// In en, this message translates to:
  /// **'Heritage'**
  String get navHeritage;

  /// Bottom nav dictionary label
  ///
  /// In en, this message translates to:
  /// **'Dictionary'**
  String get navDictionary;

  /// Bottom nav news label
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get navNews;

  /// Bottom nav heroes label
  ///
  /// In en, this message translates to:
  /// **'Heroes'**
  String get navHeroes;

  /// Heritage screen app bar title
  ///
  /// In en, this message translates to:
  /// **'Heritage Timeline'**
  String get heritageTimeline;

  /// Heritage empty state
  ///
  /// In en, this message translates to:
  /// **'No heritage articles yet'**
  String get noHeritageArticles;

  /// Dictionary detail subtitle
  ///
  /// In en, this message translates to:
  /// **'Affoo Language · Kebena Woreda'**
  String get affooLanguage;

  /// Dictionary screen and detail app bar title
  ///
  /// In en, this message translates to:
  /// **'Affoo Dictionary'**
  String get affooDictionary;

  /// Dictionary search field hint
  ///
  /// In en, this message translates to:
  /// **'Search Kebena, Amharic or English…'**
  String get searchHint;

  /// Word count label
  ///
  /// In en, this message translates to:
  /// **'{count} words in the library'**
  String wordsInLibrary(int count);

  /// Search results count label
  ///
  /// In en, this message translates to:
  /// **'{count} result{count, plural, one{} other{s}} for \"{query}\"'**
  String searchResults(int count, String query);

  /// No search results title
  ///
  /// In en, this message translates to:
  /// **'No results for \"{query}\"'**
  String noResultsFor(String query);

  /// No results subtitle
  ///
  /// In en, this message translates to:
  /// **'Try a different spelling or language'**
  String get tryDifferentSpelling;

  /// Empty dictionary title
  ///
  /// In en, this message translates to:
  /// **'Dictionary is empty'**
  String get dictionaryEmpty;

  /// Empty dictionary subtitle
  ///
  /// In en, this message translates to:
  /// **'Words will appear here once synced'**
  String get wordsWillAppear;

  /// Translations section title in word detail
  ///
  /// In en, this message translates to:
  /// **'Translations'**
  String get translations;

  /// Example sentences section title
  ///
  /// In en, this message translates to:
  /// **'Example Sentences'**
  String get exampleSentences;

  /// Synonyms section title
  ///
  /// In en, this message translates to:
  /// **'Synonyms'**
  String get synonyms;

  /// Copy word tooltip
  ///
  /// In en, this message translates to:
  /// **'Copy word'**
  String get copyWord;

  /// Word copied snackbar
  ///
  /// In en, this message translates to:
  /// **'\"{word}\" copied'**
  String wordCopied(String word);

  /// TTS error snackbar
  ///
  /// In en, this message translates to:
  /// **'Audio unavailable — check your connection'**
  String get audioUnavailable;

  /// News screen app bar title
  ///
  /// In en, this message translates to:
  /// **'Woreda News'**
  String get woredaNews;

  /// News empty state
  ///
  /// In en, this message translates to:
  /// **'No news yet'**
  String get noNewsYet;

  /// Pagination previous label
  ///
  /// In en, this message translates to:
  /// **'← Previous'**
  String get previousPage;

  /// Pagination next label
  ///
  /// In en, this message translates to:
  /// **'Next →'**
  String get nextPage;

  /// Pagination current page label
  ///
  /// In en, this message translates to:
  /// **'Page {number}'**
  String page(int number);

  /// Heroes screen badge
  ///
  /// In en, this message translates to:
  /// **'HALL OF LEGENDS'**
  String get hallOfLegends;

  /// Heroes screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Warriors, scholars & spiritual leaders\nwho shaped our history'**
  String get heroesSubtitle;

  /// Heroes empty state
  ///
  /// In en, this message translates to:
  /// **'No heroes found'**
  String get noHeroesFound;

  /// Heroes filter all tab
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// Heroes filter warrior tab
  ///
  /// In en, this message translates to:
  /// **'Warrior'**
  String get filterWarrior;

  /// Heroes filter scholar tab
  ///
  /// In en, this message translates to:
  /// **'Scholar'**
  String get filterScholar;

  /// Heroes filter leader tab
  ///
  /// In en, this message translates to:
  /// **'Leader'**
  String get filterLeader;

  /// Heroes filter spiritual tab
  ///
  /// In en, this message translates to:
  /// **'Spiritual'**
  String get filterSpiritual;

  /// Settings screen title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Settings appearance section
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// Settings theme tile title
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Dark theme label
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// Light theme label
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// System theme label
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get themeSystem;

  /// Notifications screen title
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// Push notifications tile title
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get pushNotifications;

  /// Push notifications tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Receive alerts from the Woreda'**
  String get pushNotificationsSubtitle;

  /// Woreda updates tile title
  ///
  /// In en, this message translates to:
  /// **'Woreda Updates'**
  String get woredaUpdates;

  /// Woreda updates tile subtitle
  ///
  /// In en, this message translates to:
  /// **'News and announcements'**
  String get woredaUpdatesSubtitle;

  /// Cultural events tile title
  ///
  /// In en, this message translates to:
  /// **'Cultural Events'**
  String get culturalEvents;

  /// Cultural events tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Festivals and community gatherings'**
  String get culturalEventsSubtitle;

  /// Settings data section
  ///
  /// In en, this message translates to:
  /// **'Data & Sync'**
  String get dataSync;

  /// Offline mode tile title
  ///
  /// In en, this message translates to:
  /// **'Offline Mode'**
  String get offlineMode;

  /// Offline mode tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Use only cached data, skip network calls'**
  String get offlineModeSubtitle;

  /// Sync now tile title
  ///
  /// In en, this message translates to:
  /// **'Sync Now'**
  String get syncNow;

  /// Sync now tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Refresh heritage & dictionary data'**
  String get syncNowSubtitle;

  /// Sync complete snackbar
  ///
  /// In en, this message translates to:
  /// **'Sync complete'**
  String get syncComplete;

  /// Clear cache tile title
  ///
  /// In en, this message translates to:
  /// **'Clear Cache'**
  String get clearCache;

  /// Clear cache tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Remove all locally stored data'**
  String get clearCacheSubtitle;

  /// Clear cache dialog body
  ///
  /// In en, this message translates to:
  /// **'This will remove all locally stored heritage and dictionary data. You will need an internet connection to reload content.'**
  String get clearCacheDialogContent;

  /// Cache cleared snackbar
  ///
  /// In en, this message translates to:
  /// **'Cache cleared'**
  String get cacheCleared;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Clear button
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// Settings language section
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// App language tile title
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get appLanguage;

  /// Settings about section
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// About tile title
  ///
  /// In en, this message translates to:
  /// **'About Kebena Heritage'**
  String get aboutApp;

  /// Version tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get version;

  /// Privacy policy tile title
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Privacy policy tile subtitle
  ///
  /// In en, this message translates to:
  /// **'How we handle your data'**
  String get privacyPolicySubtitle;

  /// Terms of use tile title
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get termsOfUse;

  /// Terms of use tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Usage guidelines'**
  String get termsOfUseSubtitle;

  /// Footer text in settings
  ///
  /// In en, this message translates to:
  /// **'Kebena Heritage App v1.0.0\nBuilt with ❤️ for the Kebena Community'**
  String get appFooter;

  /// Retry button label
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String error(String message);

  /// Events screen title
  ///
  /// In en, this message translates to:
  /// **'Community Events'**
  String get communityEvents;

  /// Add to calendar button
  ///
  /// In en, this message translates to:
  /// **'Add to Calendar'**
  String get addToCalendar;

  /// Mark all notifications read
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get markAllRead;

  /// Clear all tooltip
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get clearAll;

  /// Clear notifications dialog title
  ///
  /// In en, this message translates to:
  /// **'Clear all notifications?'**
  String get clearAllNotifications;

  /// Clear notifications dialog body
  ///
  /// In en, this message translates to:
  /// **'This cannot be undone.'**
  String get cannotBeUndone;

  /// Notifications empty state title
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get noNotificationsYet;

  /// Notifications empty state subtitle
  ///
  /// In en, this message translates to:
  /// **'You\'ll see updates from Kebena Woreda here'**
  String get notificationsSubtitle;

  /// Did you know detail section header
  ///
  /// In en, this message translates to:
  /// **'The Full Story'**
  String get theFullStory;

  /// Source label
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get source;

  /// Hero detail story section
  ///
  /// In en, this message translates to:
  /// **'The Story'**
  String get theStory;

  /// Hero detail legacy section
  ///
  /// In en, this message translates to:
  /// **'Legacy for This Generation'**
  String get legacySection;

  /// Chat screen title
  ///
  /// In en, this message translates to:
  /// **'Kebena Assistant'**
  String get kebenaAssistant;

  /// Chat screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Ask anything about Kebena'**
  String get askAnythingKebena;

  /// Chat input hint
  ///
  /// In en, this message translates to:
  /// **'Ask about Kebena…'**
  String get askAboutKebena;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['am', 'en', 'om'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'am':
      return AppLocalizationsAm();
    case 'en':
      return AppLocalizationsEn();
    case 'om':
      return AppLocalizationsOm();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
