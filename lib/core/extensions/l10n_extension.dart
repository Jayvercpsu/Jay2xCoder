import 'package:flutter/material.dart';
import 'package:jay2xcoder/l10n/app_localizations.dart';

extension L10nBuildContextX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
