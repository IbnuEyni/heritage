import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heritage/l10n/app_localizations.dart';
import 'package:heritage/l10n/app_localizations_en.dart';
import 'package:heritage/l10n/app_localizations_am.dart';
import 'package:heritage/l10n/app_localizations_om.dart';
import 'package:heritage/main.dart';

// Cache instances — no need to recreate on every build
final _en = AppLocalizationsEn();
final _am = AppLocalizationsAm();
final _om = AppLocalizationsOm();

extension AppLocalizationsX on BuildContext {
  /// Returns the correct AppLocalizations based on localeProvider,
  /// completely bypassing MaterialApp's locale pipeline.
  /// This means om (Oromo) works even though GlobalMaterialLocalizations
  /// doesn't support it.
  AppLocalizations get l {
    try {
      final container = ProviderScope.containerOf(this, listen: false);
      final lang = container.read(localeProvider).languageCode;
      return switch (lang) {
        'am' => _am,
        'om' => _om,
        _    => _en,
      };
    } catch (_) {
      return _en;
    }
  }
}
