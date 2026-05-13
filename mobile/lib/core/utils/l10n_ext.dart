import 'package:flutter/material.dart';
import 'package:heritage/l10n/app_localizations.dart';
import 'package:heritage/l10n/app_localizations_en.dart';

extension AppLocalizationsX on BuildContext {
  /// Returns AppLocalizations for the current locale, falling back to English
  /// if the locale is not fully supported by Flutter's Material delegates (e.g. om).
  AppLocalizations get l => AppLocalizations.of(this) ?? AppLocalizationsEn();
}
