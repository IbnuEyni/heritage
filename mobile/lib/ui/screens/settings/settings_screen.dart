import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/datasources/sync_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../../main.dart';

// ── Persisted bool providers ──────────────────────────────────────────────────
final notificationsEnabledProvider = StateNotifierProvider<_BoolNotifier, bool>(
  (ref) => _BoolNotifier('notifications_enabled', true),
);
final woredaAlertsProvider = StateNotifierProvider<_BoolNotifier, bool>(
  (ref) => _BoolNotifier('woreda_alerts', true),
);
final culturalEventsProvider = StateNotifierProvider<_BoolNotifier, bool>(
  (ref) => _BoolNotifier('cultural_events', true),
);
final offlineModeProvider = StateNotifierProvider<_BoolNotifier, bool>(
  (ref) => _BoolNotifier('offline_mode', false),
);

class _BoolNotifier extends StateNotifier<bool> {
  final String _key;
  _BoolNotifier(this._key, bool defaultVal) : super(defaultVal) { _load(); }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool(_key) ?? state;
  }

  Future<void> toggle() async {
    state = !state;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, state);
  }
}

// ── Screen ────────────────────────────────────────────────────────────────────
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    final localeName = switch (locale.languageCode) {
      'am' => 'አማርኛ (Amharic)',
      'om' => 'Affoo (Kebena)',
      _    => 'English',
    };

    return Scaffold(
      appBar: AppBar(title: Text(l.settings)),
      body: ListView(
        children: [
          // ── Appearance ──────────────────────────────────────
          _SectionHeader(l.appearance),
          _SettingsTile(
            icon: Icons.palette_outlined,
            title: l.theme,
            subtitle: themeMode == ThemeMode.dark
                ? l.themeDark
                : themeMode == ThemeMode.light
                    ? l.themeLight
                    : l.themeSystem,
            trailing: _ThemeSelector(
              current: themeMode,
              onChanged: (mode) =>
                  ref.read(themeModeProvider.notifier).setTheme(mode),
            ),
          ),

          // ── Language ────────────────────────────────────────
          _SectionHeader(l.language),
          _SettingsTile(
            icon: Icons.translate_outlined,
            title: l.appLanguage,
            subtitle: localeName,
            onTap: () => _showLanguageSheet(context, ref, locale),
          ),

          // ── Notifications ───────────────────────────────────
          _SectionHeader(l.notifications),
          _SwitchTile(
            icon: Icons.notifications_outlined,
            title: l.pushNotifications,
            subtitle: l.pushNotificationsSubtitle,
            provider: notificationsEnabledProvider,
            ref: ref,
          ),
          _SwitchTile(
            icon: Icons.location_city_outlined,
            title: l.woredaUpdates,
            subtitle: l.woredaUpdatesSubtitle,
            provider: woredaAlertsProvider,
            ref: ref,
          ),
          _SwitchTile(
            icon: Icons.celebration_outlined,
            title: l.culturalEvents,
            subtitle: l.culturalEventsSubtitle,
            provider: culturalEventsProvider,
            ref: ref,
          ),

          // ── Data & Sync ─────────────────────────────────────
          _SectionHeader(l.dataSync),
          _SwitchTile(
            icon: Icons.offline_bolt_outlined,
            title: l.offlineMode,
            subtitle: l.offlineModeSubtitle,
            provider: offlineModeProvider,
            ref: ref,
          ),
          _SettingsTile(
            icon: Icons.sync_outlined,
            title: l.syncNow,
            subtitle: l.syncNowSubtitle,
            onTap: () async {
              await ref.read(syncServiceProvider).sync();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l.syncComplete),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          ),
          _SettingsTile(
            icon: Icons.delete_outline,
            title: l.clearCache,
            subtitle: l.clearCacheSubtitle,
            iconColor: Colors.red,
            onTap: () => _showClearCacheDialog(context, ref, l),
          ),

          // ── About ───────────────────────────────────────────
          _SectionHeader(l.about),
          _SettingsTile(
            icon: Icons.info_outline,
            title: l.aboutApp,
            subtitle: l.version,
            onTap: () => _showAboutDialog(context, l),
          ),
          _SettingsTile(
            icon: Icons.shield_outlined,
            title: l.privacyPolicy,
            subtitle: l.privacyPolicySubtitle,
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.gavel_outlined,
            title: l.termsOfUse,
            subtitle: l.termsOfUseSubtitle,
            onTap: () {},
          ),

          const SizedBox(height: 40),
          Center(
            child: Text(
              l.appFooter,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context, WidgetRef ref, AppLocalizations l) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(l.clearCache),
        content: Text(l.clearCacheDialogContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l.cacheCleared),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Text(l.clear, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showLanguageSheet(BuildContext context, WidgetRef ref, Locale current) {
    final l = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.appLanguage, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            _LangOption(
              label: 'English',
              flag: '🇬🇧',
              selected: current.languageCode == 'en',
              onTap: () {
                ref.read(localeProvider.notifier).setLocale(const Locale('en'));
                Navigator.pop(context);
              },
            ),
            _LangOption(
              label: 'አማርኛ (Amharic)',
              flag: '🇪🇹',
              selected: current.languageCode == 'am',
              onTap: () {
                ref.read(localeProvider.notifier).setLocale(const Locale('am'));
                Navigator.pop(context);
              },
            ),
            _LangOption(
              label: 'Affoo (Kebena)',
              flag: '🏛️',
              selected: current.languageCode == 'om',
              onTap: () {
                ref.read(localeProvider.notifier).setLocale(const Locale('om'));
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context, AppLocalizations l) {
    showAboutDialog(
      context: context,
      applicationName: l.appTitle,
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.account_balance, color: Colors.white, size: 32),
      ),
      children: const [
        Text(
          'A digital platform preserving the heritage, language (Affoo), '
          'and culture of the Kebena people — a community with over 700 years '
          'of history in the Ethiopian highlands.',
        ),
      ],
    );
  }
}

// ── Reusable widgets ──────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.gold,
              letterSpacing: 1.2,
            ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? iconColor;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = iconColor ?? AppColors.primary;

    return ListTile(
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(title, style: Theme.of(context).textTheme.titleSmall),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
      trailing: trailing ??
          (onTap != null
              ? Icon(
                  Icons.chevron_right,
                  color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                  size: 20,
                )
              : null),
      onTap: onTap,
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final StateNotifierProvider<_BoolNotifier, bool> provider;
  final WidgetRef ref;

  const _SwitchTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.provider,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(provider);
    return _SettingsTile(
      icon: icon,
      title: title,
      subtitle: subtitle,
      onTap: () => ref.read(provider.notifier).toggle(),
      trailing: Switch.adaptive(
        value: value,
        onChanged: (_) => ref.read(provider.notifier).toggle(),
        activeThumbColor: Colors.white,
        activeTrackColor: AppColors.primary,
      ),
    );
  }
}

class _ThemeSelector extends StatelessWidget {
  final ThemeMode current;
  final ValueChanged<ThemeMode> onChanged;
  const _ThemeSelector({required this.current, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ThemeMode>(
      style: SegmentedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        visualDensity: VisualDensity.compact,
      ),
      segments: const [
        ButtonSegment(value: ThemeMode.light, icon: Icon(Icons.light_mode, size: 16)),
        ButtonSegment(value: ThemeMode.system, icon: Icon(Icons.brightness_auto, size: 16)),
        ButtonSegment(value: ThemeMode.dark, icon: Icon(Icons.dark_mode, size: 16)),
      ],
      selected: {current},
      onSelectionChanged: (s) => onChanged(s.first),
    );
  }
}

class _LangOption extends StatelessWidget {
  final String label, flag;
  final bool selected;
  final VoidCallback onTap;

  const _LangOption({
    required this.label,
    required this.flag,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(flag, style: const TextStyle(fontSize: 24)),
      title: Text(label),
      trailing: selected
          ? const Icon(Icons.check_circle, color: AppColors.primary)
          : null,
      onTap: onTap,
    );
  }
}
