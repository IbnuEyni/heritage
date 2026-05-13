import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'data/datasources/isar_service.dart';
import 'data/datasources/sync_service.dart';
import 'data/isar/notification_item.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'ui/router.dart';

// Firebase is not supported on Linux (dev desktop only).
bool get _firebaseSupported =>
    !kIsWeb && defaultTargetPlatform != TargetPlatform.linux;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

const _kThemeKey = 'app_theme_mode';
const _kLocaleKey = 'app_locale';

// ── Supported locales ─────────────────────────────────────────────────────────
const _supportedLocales = [
  Locale('en'),
  Locale('am'),
  Locale('om'),
];

// ── Locale provider ───────────────────────────────────────────────────────────
class _LocaleNotifier extends StateNotifier<Locale> {
  _LocaleNotifier(super.initial);

  Future<void> setLocale(Locale locale) async {
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kLocaleKey, locale.languageCode);
  }
}

final localeProvider = StateNotifierProvider<_LocaleNotifier, Locale>(
  (ref) => _LocaleNotifier(const Locale('en')),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (_firebaseSupported) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  await IsarService.init();

  // Load persisted theme before app starts
  final prefs = await SharedPreferences.getInstance();
  final savedTheme = prefs.getString(_kThemeKey);
  final initialTheme = switch (savedTheme) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.light,
  };

  final savedLocale = prefs.getString(_kLocaleKey);
  final initialLocale = switch (savedLocale) {
    'am' => const Locale('am'),
    'om' => const Locale('om'),
    _ => const Locale('en'),
  };

  if (_firebaseSupported) {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final n = message.notification;
      if (n == null) return;
      final item = NotificationItem()
        ..title = n.title ?? 'New Update'
        ..body = n.body ?? ''
        ..topic = message.from
        ..isRead = false
        ..receivedAt = DateTime.now();
      await IsarService().saveNotification(item);
    });

    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    await fcm.subscribeToTopic(AppConstants.fcmTopicWoreda);
    await fcm.subscribeToTopic(AppConstants.fcmTopicCulture);
  }

  runApp(ProviderScope(
    overrides: [
      themeModeProvider.overrideWith((ref) => _ThemeModeNotifier(initialTheme)),
      localeProvider.overrideWith((ref) => _LocaleNotifier(initialLocale)),
    ],
    child: const HeritageApp(),
  ));
}

// ── Persisted theme notifier ──────────────────────────────────────────────────
class _ThemeModeNotifier extends StateNotifier<ThemeMode> {
  _ThemeModeNotifier(super.initial);

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _kThemeKey,
        switch (mode) {
          ThemeMode.light => 'light',
          ThemeMode.dark => 'dark',
          ThemeMode.system => 'system',
        });
  }
}

final themeModeProvider = StateNotifierProvider<_ThemeModeNotifier, ThemeMode>(
  (ref) => _ThemeModeNotifier(ThemeMode.light),
);

class HeritageApp extends ConsumerStatefulWidget {
  const HeritageApp({super.key});

  @override
  ConsumerState<HeritageApp> createState() => _HeritageAppState();
}

class _HeritageAppState extends ConsumerState<HeritageApp> {
  late final AppLifecycleListener _lifecycleListener;

  @override
  void initState() {
    super.initState();
    ref.read(syncServiceProvider).sync();
    _lifecycleListener = AppLifecycleListener(
      onResume: () => ref.read(syncServiceProvider).sync(),
    );
  }

  @override
  void dispose() {
    _lifecycleListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    // Material delegates don't support 'om' — pass 'en' to them.
    // AppLocalizations is handled separately via context.l which reads
    // localeProvider directly, bypassing MaterialApp's locale.
    final materialLocale =
        locale.languageCode == 'om' ? const Locale('en') : locale;
    return MaterialApp.router(
      title: 'Kebena Heritage',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      locale: materialLocale,
      supportedLocales: const [Locale('en'), Locale('am')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
