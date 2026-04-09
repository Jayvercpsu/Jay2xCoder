# Localization Setup (English, Bisaya, Filipino)

This project uses Flutter's built-in localization workflow (`gen-l10n`) with ARB files.

## Files
- `l10n.yaml`
- `lib/l10n/app_en.arb`
- `lib/l10n/app_ceb.arb`
- `lib/l10n/app_fil.arb`
- generated: `lib/l10n/app_localizations.dart`

## How it works
1. Add keys in `app_en.arb`.
2. Add translated values in `app_ceb.arb` and `app_fil.arb` using the same keys.
3. Run:
   ```bash
   flutter gen-l10n
   ```
4. Access localized strings in UI:
   ```dart
   final l10n = context.l10n;
   Text(l10n.settingsTitle);
   ```

## Current language switcher
- Stored in local app state: `AppState.localeCode`
- Selector is in `SettingsScreen`
- Supported locale codes:
  - `en`
  - `ceb`
  - `fil`

## Best practice for freshmen
- Keep keys descriptive (`settingsDarkModeSubtitle`)
- Translate UI labels first before long lesson content
- Avoid hardcoded strings inside widgets
- Use placeholders for dynamic values (`{score}`, `{name}`)
