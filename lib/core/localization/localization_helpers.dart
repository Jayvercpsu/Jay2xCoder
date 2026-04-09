import 'package:flutter/material.dart';
import 'package:jay2xcoder/data/models/lesson_item.dart';
import 'package:jay2xcoder/l10n/app_localizations.dart';

const List<Locale> supportedAppLocales = <Locale>[
  Locale('en'),
  Locale('ceb'),
  Locale('fil'),
];

const List<Locale> supportedFrameworkLocales = <Locale>[
  Locale('en'),
  Locale('fil'),
];

const Set<String> _supportedLocaleCodes = <String>{'en', 'ceb', 'fil'};

String normalizeLocaleCode(String? localeCode) {
  final String raw = (localeCode ?? 'en').trim().toLowerCase();

  if (_supportedLocaleCodes.contains(raw)) {
    return raw;
  }

  if (raw == 'bisaya' || raw == 'cebuano') {
    return 'ceb';
  }

  if (raw == 'filipino' || raw == 'tagalog' || raw == 'tl') {
    return 'fil';
  }

  return 'en';
}

Locale appLocaleFromCode(String? localeCode) {
  return Locale(normalizeLocaleCode(localeCode));
}

Locale frameworkLocaleFromCode(String? localeCode) {
  final String code = normalizeLocaleCode(localeCode);
  if (code == 'fil') {
    return const Locale('fil');
  }
  // Use English Material/Cupertino localizations for Bisaya (`ceb`).
  return const Locale('en');
}

String languageLabel(AppLocalizations l10n, String localeCode) {
  switch (localeCode) {
    case 'ceb':
      return l10n.languageBisaya;
    case 'fil':
      return l10n.languageFilipino;
    case 'en':
    default:
      return l10n.languageEnglish;
  }
}

String localizedQuote(AppLocalizations l10n, int index) {
  switch (index) {
    case 0:
      return l10n.quote0;
    case 1:
      return l10n.quote1;
    case 2:
      return l10n.quote2;
    case 3:
      return l10n.quote3;
    case 4:
      return l10n.quote4;
    case 5:
      return l10n.quote5;
    case 6:
    default:
      return l10n.quote6;
  }
}

String localizedBadge(AppLocalizations l10n, String badgeId) {
  if (badgeId == 'first_step') {
    return l10n.badgeFirstStep;
  }
  if (badgeId == 'quiz_starter') {
    return l10n.badgeQuizStarter;
  }
  if (badgeId == 'practice_explorer') {
    return l10n.badgePracticeExplorer;
  }
  if (badgeId == 'momentum_coder') {
    return l10n.badgeMomentumCoder;
  }
  if (badgeId == 'expert_trailblazer') {
    return l10n.badgeExpertTrailblazer;
  }

  if (badgeId.startsWith('level_') && badgeId.endsWith('_cleared')) {
    final String numberText = badgeId
        .replaceFirst('level_', '')
        .replaceFirst('_cleared', '');
    final int? level = int.tryParse(numberText);
    if (level != null) {
      return l10n.badgeLevelCleared(level);
    }
  }

  // Fallback for legacy saved text before badge-id migration.
  return badgeId;
}

String localizedLessonTitle(AppLocalizations l10n, LessonItem lesson) {
  switch (lesson.id) {
    case 'l1_1':
      return l10n.lessonL11Title;
    case 'l1_2':
      return l10n.lessonL12Title;
    case 'l2_1':
      return l10n.lessonL21Title;
    case 'l2_2':
      return l10n.lessonL22Title;
    case 'l3_1':
      return l10n.lessonL31Title;
    case 'l3_2':
      return l10n.lessonL32Title;
    case 'l4_1':
      return l10n.lessonL41Title;
    case 'l4_2':
      return l10n.lessonL42Title;
    case 'l5_1':
      return l10n.lessonL51Title;
    case 'l5_2':
      return l10n.lessonL52Title;
    case 'l5_3':
      return l10n.lessonL53Title;
    case 'l7_1':
      return l10n.lessonL71Title;
    case 'l7_2':
      return l10n.lessonL72Title;
    default:
      return lesson.title;
  }
}

String localizedLessonIntro(AppLocalizations l10n, LessonItem lesson) {
  switch (lesson.id) {
    case 'l1_1':
      return l10n.lessonL11Intro;
    case 'l1_2':
      return l10n.lessonL12Intro;
    case 'l2_1':
      return l10n.lessonL21Intro;
    case 'l2_2':
      return l10n.lessonL22Intro;
    case 'l3_1':
      return l10n.lessonL31Intro;
    case 'l3_2':
      return l10n.lessonL32Intro;
    case 'l4_1':
      return l10n.lessonL41Intro;
    case 'l4_2':
      return l10n.lessonL42Intro;
    case 'l5_1':
      return l10n.lessonL51Intro;
    case 'l5_2':
      return l10n.lessonL52Intro;
    case 'l5_3':
      return l10n.lessonL53Intro;
    case 'l7_1':
      return l10n.lessonL71Intro;
    case 'l7_2':
      return l10n.lessonL72Intro;
    default:
      return lesson.shortExplanation;
  }
}

String localizedLessonExpectedOutput(
  AppLocalizations l10n,
  LessonItem lesson,
  String fallback,
) {
  switch (lesson.id) {
    case 'l1_1':
      return l10n.lessonL11Output;
    case 'l1_2':
      return l10n.lessonL12Output;
    case 'l2_1':
      return l10n.lessonL21Output;
    case 'l2_2':
      return l10n.lessonL22Output;
    case 'l3_1':
      return l10n.lessonL31Output;
    case 'l3_2':
      return l10n.lessonL32Output;
    case 'l4_1':
      return l10n.lessonL41Output;
    case 'l4_2':
      return l10n.lessonL42Output;
    case 'l5_1':
      return l10n.lessonL51Output;
    case 'l5_2':
      return l10n.lessonL52Output;
    case 'l5_3':
      return l10n.lessonL53Output;
    case 'l7_1':
      return l10n.lessonL71Output;
    case 'l7_2':
      return l10n.lessonL72Output;
    default:
      return fallback;
  }
}
