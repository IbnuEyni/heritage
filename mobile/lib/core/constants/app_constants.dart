class AppConstants {
  // ── Base URL resolution order ────────────────────────────────────────────────
  // 1. Pass at build/run time:  flutter run --dart-define=BASE_URL=http://192.168.x.x:8000/api
  // 2. Falls back to Android emulator default (10.0.2.2 → host machine)
  // 3. For physical device: flutter run --dart-define=BASE_URL=http://<your-ip>:8000/api
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://heritage-production-4728.up.railway.app/api',
  );

  static const String fcmTopicWoreda  = 'woreda_updates';
  static const String fcmTopicCulture = 'cultural_events';
  static const int    pageSize        = 10;
}
