// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Oromo (`om`).
class AppLocalizationsOm extends AppLocalizations {
  AppLocalizationsOm([String locale = 'om']) : super(locale);

  @override
  String get appTitle => 'Dhaalaa Qabeenya Kebena';

  @override
  String get appSubtitle => 'Portaala Aanaa Addaa';

  @override
  String get askKebenaAI => 'AI Kebena Gaafadhu';

  @override
  String get goodEvening => 'Galgala Gaarii,';

  @override
  String get exploreKebena => 'Kebena Qoradhu';

  @override
  String get wordOfTheDay => 'JECHA GUYYAA';

  @override
  String get didYouKnow => 'Beektuu?';

  @override
  String get kebenaHeroes => 'Gootota Kebena';

  @override
  String get latestNews => 'Oduu Haaraa';

  @override
  String get quickFacts => 'Dhugaalee Gabaabaa';

  @override
  String get seeAll => 'Hunda Ilaali';

  @override
  String get readMore => 'Dabalataan Dubbisi';

  @override
  String get read => 'Dubbisi';

  @override
  String get navHome => 'Mana';

  @override
  String get navHeritage => 'Dhaalaa';

  @override
  String get navDictionary => 'Galmee Jechootaa';

  @override
  String get navNews => 'Oduu';

  @override
  String get navHeroes => 'Gootota';

  @override
  String get heritageTimeline => 'Seenaa Dhaalaa';

  @override
  String get noHeritageArticles => 'Barreeffamni dhaalaa ammaaf hin jiru';

  @override
  String get affooLanguage => 'Afaan Affoo · Aanaa Kebena';

  @override
  String get affooDictionary => 'Galmee Jechootaa Affoo';

  @override
  String get searchHint => 'Kebena, Amaariffaa ykn Ingiliffaa barbaadi…';

  @override
  String wordsInLibrary(int count) {
    return 'Jechootni $count mana kitaabaa keessa jiru';
  }

  @override
  String searchResults(int count, String query) {
    return 'Filannoowwan $count \"$query\" dhaaf';
  }

  @override
  String noResultsFor(String query) {
    return '\"$query\" dhaaf bu\'aa hin argamne';
  }

  @override
  String get tryDifferentSpelling => 'Qubee ykn afaan biraa yaalii';

  @override
  String get dictionaryEmpty => 'Galmeen jechootaa duwwaadha';

  @override
  String get wordsWillAppear => 'Jechootni walitti makamuu booda mul\'atu';

  @override
  String get translations => 'Hiikkaalee';

  @override
  String get exampleSentences => 'Fakkeenya Gaalee';

  @override
  String get synonyms => 'Jechootni Walfakkaatoo';

  @override
  String get copyWord => 'Jecha Koppi Godhi';

  @override
  String wordCopied(String word) {
    return '\"$word\" koppi ta\'e';
  }

  @override
  String get audioUnavailable =>
      'Sagaleen hin argamu — walquunnamtii kee mirkaneessi';

  @override
  String get woredaNews => 'Oduu Aanaa';

  @override
  String get noNewsYet => 'Ammaaf oduu hin jiru';

  @override
  String get previousPage => '← Dura';

  @override
  String get nextPage => 'Itti Aanaa →';

  @override
  String page(int number) {
    return 'Fuula $number';
  }

  @override
  String get hallOfLegends => 'KUTAA GOOTOTA';

  @override
  String get heroesSubtitle =>
      'Loltootni, beektotni fi hoggantoota seenaa keenya bocanii';

  @override
  String get noHeroesFound => 'Goototi hin argamne';

  @override
  String get filterAll => 'Hunda';

  @override
  String get filterWarrior => 'Loltuu';

  @override
  String get filterScholar => 'Beekaa';

  @override
  String get filterLeader => 'Hogganaa';

  @override
  String get filterSpiritual => 'Amantii';

  @override
  String get settings => 'Qindaa\'ina';

  @override
  String get appearance => 'Mul\'ata';

  @override
  String get theme => 'Teemaa';

  @override
  String get themeDark => 'Dukkana';

  @override
  String get themeLight => 'Ifa';

  @override
  String get themeSystem => 'Sirna Durtii';

  @override
  String get notifications => 'Beeksisaalee';

  @override
  String get pushNotifications => 'Beeksisa Push';

  @override
  String get pushNotificationsSubtitle => 'Beeksisa Aanaa irraa fudhachuu';

  @override
  String get woredaUpdates => 'Haaromsa Aanaa';

  @override
  String get woredaUpdatesSubtitle => 'Oduu fi beeksisaalee';

  @override
  String get culturalEvents => 'Ayyaanaalee Aadaa';

  @override
  String get culturalEventsSubtitle => 'Ayyaanaalee fi walga\'ii hawaasaa';

  @override
  String get dataSync => 'Daataa fi Walitti Makuu';

  @override
  String get offlineMode => 'Haala Offline';

  @override
  String get offlineModeSubtitle => 'Daataa kuufame qofa fayyadami';

  @override
  String get syncNow => 'Amma Walitti Maki';

  @override
  String get syncNowSubtitle => 'Daataa dhaalaa fi galmee jechootaa haaromsi';

  @override
  String get syncComplete => 'Walitti makuun xumurame';

  @override
  String get clearCache => 'Kuusaa Qulqulleessi';

  @override
  String get clearCacheSubtitle => 'Daataa naannoo kuufame hunda haqi';

  @override
  String get clearCacheDialogContent =>
      'Kun daataa dhaalaa fi galmee jechootaa naannoo kuufame hunda haqa. Qabiyyee irra deebi\'ee fe\'uuf walquunnamtii interneetii barbaachisa.';

  @override
  String get cacheCleared => 'Kuusaan qulqullaa\'e';

  @override
  String get cancel => 'Haqi';

  @override
  String get clear => 'Qulqulleessi';

  @override
  String get language => 'Afaan';

  @override
  String get appLanguage => 'Afaan Appii';

  @override
  String get about => 'Waa\'ee';

  @override
  String get aboutApp => 'Waa\'ee Dhaalaa Kebena';

  @override
  String get version => 'Versiyon 1.0.0';

  @override
  String get privacyPolicy => 'Imaammata Dhuunfaa';

  @override
  String get privacyPolicySubtitle => 'Daataa kee akkamitti qabanna';

  @override
  String get termsOfUse => 'Hayyama Fayyadamaa';

  @override
  String get termsOfUseSubtitle => 'Qajeelfama fayyadamaa';

  @override
  String get appFooter =>
      'Appii Dhaalaa Kebena v1.0.0\nJaalalaaan hawaasa Kebenaaf hojjetame ❤️';

  @override
  String get retry => 'Irra Deebi\'i Yaalii';

  @override
  String error(String message) {
    return 'Dogoggora: $message';
  }

  @override
  String get communityEvents => 'Ayyaanaalee Hawaasaa';

  @override
  String get addToCalendar => 'Kaalaandarii Irratti Ida\'i';

  @override
  String get markAllRead => 'Hunda Dubbifame Godhi';

  @override
  String get clearAll => 'Hunda Haqi';

  @override
  String get clearAllNotifications => 'Beeksisaalee hunda haqi?';

  @override
  String get cannotBeUndone => 'Kun deebi\'ee hojii irra ooluu hin danda\'u.';

  @override
  String get noNotificationsYet => 'Ammaaf beeksisa hin jiru';

  @override
  String get notificationsSubtitle =>
      'Haaromsa Aanaa Kebena irraa asitti argita';

  @override
  String get theFullStory => 'Seenaa Guutuu';

  @override
  String get source => 'Madda';

  @override
  String get theStory => 'Seenaa';

  @override
  String get legacySection => 'Dhaalaa Dhalootaaf';

  @override
  String get kebenaAssistant => 'Gargaaraa Kebena';

  @override
  String get askAnythingKebena => 'Waa\'ee Kebena waa\'ee kamiyyuu gaafadhu';

  @override
  String get askAboutKebena => 'Waa\'ee Kebena gaafadhu…';
}
