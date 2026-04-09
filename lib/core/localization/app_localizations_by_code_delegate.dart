import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:jay2xcoder/core/localization/localization_helpers.dart';
import 'package:jay2xcoder/l10n/app_localizations.dart';
import 'package:jay2xcoder/l10n/app_localizations_ceb.dart';
import 'package:jay2xcoder/l10n/app_localizations_en.dart';
import 'package:jay2xcoder/l10n/app_localizations_fil.dart';

class AppLocalizationsByCodeDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsByCodeDelegate({required this.localeCode});

  final String localeCode;

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<AppLocalizations> load(Locale locale) {
    final String code = normalizeLocaleCode(localeCode);
    switch (code) {
      case 'ceb':
        return SynchronousFuture<AppLocalizations>(AppLocalizationsCeb());
      case 'fil':
        return SynchronousFuture<AppLocalizations>(AppLocalizationsFil());
      case 'en':
      default:
        return SynchronousFuture<AppLocalizations>(AppLocalizationsEn());
    }
  }

  @override
  bool shouldReload(covariant AppLocalizationsByCodeDelegate old) {
    return normalizeLocaleCode(localeCode) !=
        normalizeLocaleCode(old.localeCode);
  }
}
