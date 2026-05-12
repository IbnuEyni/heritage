import 'package:go_router/go_router.dart';
import 'screens/splash/splash_screen.dart';
import '../domain/entities/entities.dart';
import 'screens/app_shell.dart';
import 'screens/heritage/heritage_detail_screen.dart';
import 'screens/news/news_detail_screen.dart';
import 'screens/events/events_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'screens/heroes/hero_detail_screen.dart';
import 'screens/did_you_know/did_you_know_detail_screen.dart';
import 'screens/dictionary/dictionary_detail_screen.dart';
import 'screens/chat/chat_screen.dart';
import 'screens/notifications/notifications_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (_, __) => const SplashScreen(),
    ),
    // ── Shell (bottom nav) ────────────────────────────────────
    GoRoute(
      path: '/',
      builder: (_, __) => const AppShell(initialIndex: 0),
    ),
    GoRoute(
      path: '/heritage',
      builder: (_, __) => const AppShell(initialIndex: 1),
    ),
    GoRoute(
      path: '/dictionary',
      builder: (_, __) => const AppShell(initialIndex: 2),
    ),
    GoRoute(
      path: '/news',
      builder: (_, __) => const AppShell(initialIndex: 3),
    ),
    GoRoute(
      path: '/heroes',
      builder: (_, __) => const AppShell(initialIndex: 4),
    ),
    GoRoute(
      path: '/notifications',
      builder: (_, __) => const NotificationsScreen(),
    ),
    GoRoute(
      path: '/chat',
      builder: (_, __) => const ChatScreen(),
    ),

    // ── Detail screens (full-screen push over shell) ──────────
    GoRoute(
      path: '/heritage/detail',
      builder: (_, state) => HeritageDetailScreen(
        article: state.extra as HeritageEntity,
      ),
    ),
    GoRoute(
      path: '/news/detail',
      builder: (_, state) => NewsDetailScreen(
        article: state.extra as NewsEntity,
      ),
    ),
    GoRoute(
      path: '/heroes/detail',
      builder: (_, state) => HeroDetailScreen(
        hero: state.extra as HeroEntity,
      ),
    ),
    GoRoute(
      path: '/did-you-know/detail',
      builder: (_, state) => DidYouKnowDetailScreen(
        item: state.extra as DidYouKnowEntity,
      ),
    ),
    GoRoute(
      path: '/word-detail',
      builder: (_, state) => DictionaryDetailScreen(
        entry: state.extra as DictionaryEntity,
      ),
    ),
    GoRoute(
      path: '/events',
      builder: (_, __) => const EventsScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (_, __) => const SettingsScreen(),
    ),
  ],
);
