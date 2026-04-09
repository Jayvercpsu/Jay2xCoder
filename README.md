# Jay2xCoder

Learn Programming Step by Step.

A lightweight, offline-first Flutter learning app for incoming IT freshmen. It guides students from beginner to expert through locked lesson progression with local storage only.

## Highlights
- No login/signup/authentication
- Offline-friendly (local mock data + Hive local progress)
- Splash -> first-launch onboarding -> dashboard flow
- Locked progression by lesson and level
- Simple gamification: XP, badges, streak
- Lightweight practice activities and quizzes
- Lesson bookmarks/favorites
- Roadmap search + favorites filter
- Multilingual UI: English, Bisaya, Filipino
- Code-first lessons with expected output cards
- In-app coding playground (HTML/CSS/JS) with Run, Reload, Restart
- Clean UI with rounded cards, subtle shadows, and smooth transitions

## Tech Stack
- Flutter
- Riverpod (`flutter_riverpod`)
- GoRouter (`go_router`)
- Hive (`hive`, `hive_flutter`)
- SVG icons (`flutter_svg`)
- Flutter Localization (`flutter_localizations`, `intl`, ARB + gen-l10n)
- Web preview runner (`webview_flutter`)

## App Flow
1. App opens to Splash screen
2. If first launch: Onboarding (4 screens)
3. Then Home dashboard
4. Navigation tabs: Home, Roadmap, Progress, Profile, Settings

## Unlocking Rules
- `Level 1` starts unlocked
- `Level N` unlocks only when `Level N-1` is fully completed
- Lesson unlock inside a level:
  - Lesson 1: unlocked when level is unlocked
  - Lesson 2+: requires previous lesson **completed + quiz passed**
- Next progression requires quiz pass

Implementation references:
- `lib/core/constants/progression_utils.dart`
- `lib/providers/app_providers.dart`

## Project Structure
```text
lib/
  app/
    app.dart
  core/
    constants/
      app_constants.dart
      app_spacing.dart
      progression_utils.dart
    extensions/
      l10n_extension.dart
    localization/
      localization_helpers.dart
    theme/
      app_theme.dart
  l10n/
    app_en.arb
    app_ceb.arb
    app_fil.arb
    app_localizations.dart
  data/
    mock/
      mock_levels.dart
      mock_quizzes.dart
      mock_practice.dart
      mock_learning_content.dart
    models/
      app_state.dart
      learning_level.dart
      lesson_item.dart
      lesson_quiz.dart
      practice_set.dart
      quiz_question.dart
    storage/
      local_storage_service.dart
  navigation/
    app_router.dart
  presentation/
    splash/
    onboarding/
    shell/
    home/
    roadmap/
    lesson/
    quiz/
    practice/
    progress/
    profile/
    settings/
    shared/widgets/
  providers/
    app_providers.dart
  main.dart

assets/
  tech/
    html5.svg
    css3.svg
    javascript.svg
    git.svg
    api.svg
    json.svg
    flutter.svg
    firebase.svg
  data/
    lessons_sample.json

docs/
  localization_setup.md
  tech_logo_asset_setup.md
```

## Run the App
```bash
flutter pub get
flutter run
```

## Validation
```bash
flutter analyze
flutter test
```

## Notes
- Current learning content is local mock data in Dart files.
- Sample JSON data included at `assets/data/lessons_sample.json`.
- Localization setup guide: `docs/localization_setup.md`
- You can swap placeholder SVGs with official icons (Devicon/Simple Icons). See:
  - `docs/tech_logo_asset_setup.md`
# Jay2xCoder
