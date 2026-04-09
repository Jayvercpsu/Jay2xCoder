import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jay2xcoder/core/constants/app_constants.dart';
import 'package:jay2xcoder/core/constants/progression_utils.dart';
import 'package:jay2xcoder/core/localization/localization_helpers.dart';
import 'package:jay2xcoder/data/mock/mock_learning_content.dart';
import 'package:jay2xcoder/data/models/app_state.dart';
import 'package:jay2xcoder/data/models/code_practice_template.dart';
import 'package:jay2xcoder/data/models/learning_level.dart';
import 'package:jay2xcoder/data/models/lesson_item.dart';
import 'package:jay2xcoder/data/models/lesson_quiz.dart';
import 'package:jay2xcoder/data/models/practice_set.dart';
import 'package:jay2xcoder/data/storage/local_storage_service.dart';

final localStorageProvider = Provider<LocalStorageService>((Ref ref) {
  throw UnimplementedError(
    'localStorageProvider must be overridden in main.dart',
  );
});

final initialAppStateProvider = Provider<AppState>((Ref ref) {
  return AppState.initial();
});

final levelsProvider = Provider<List<LearningLevel>>((Ref ref) {
  return mockLevels;
});

final quizzesProvider = Provider<Map<String, LessonQuiz>>((Ref ref) {
  return mockQuizzes;
});

final practicesProvider = Provider<Map<String, PracticeSet>>((Ref ref) {
  return mockPracticeSetsByLevel;
});

final codePracticeTemplatesProvider =
    Provider<Map<String, CodePracticeTemplate>>((Ref ref) {
      return mockCodePracticeTemplates;
    });

final appStateControllerProvider =
    StateNotifierProvider<AppStateController, AppState>((Ref ref) {
      final LocalStorageService storage = ref.watch(localStorageProvider);
      final AppState initial = ref.watch(initialAppStateProvider);
      return AppStateController(storage: storage, initialState: initial);
    });

final currentLevelProvider = Provider<int>((Ref ref) {
  final AppState state = ref.watch(appStateControllerProvider);
  final List<LearningLevel> levels = ref.watch(levelsProvider);
  return currentUnlockedLevelOrder(levels: levels, state: state);
});

final masteryProvider = Provider<double>((Ref ref) {
  final AppState state = ref.watch(appStateControllerProvider);
  final List<LearningLevel> levels = ref.watch(levelsProvider);
  return masteryProgress(levels: levels, state: state);
});

final nextLessonProvider = Provider<LessonItem?>((Ref ref) {
  final AppState state = ref.watch(appStateControllerProvider);
  final List<LearningLevel> levels = ref.watch(levelsProvider);
  return nextLesson(levels: levels, state: state);
});

final dailyQuoteIndexProvider = Provider<int>((Ref ref) {
  final DateTime now = DateTime.now();
  final int dayOfYear = now.difference(DateTime(now.year)).inDays;
  return dayOfYear % motivationQuotes.length;
});

final appLocaleCodeProvider = Provider<String>((Ref ref) {
  final String code = ref.watch(
    appStateControllerProvider.select((AppState state) => state.localeCode),
  );
  return normalizeLocaleCode(code);
});

class AppStateController extends StateNotifier<AppState> {
  AppStateController({
    required LocalStorageService storage,
    required AppState initialState,
  }) : _storage = storage,
       super(initialState);

  final LocalStorageService _storage;

  Future<void> completeOnboarding() async {
    await _setStateAndPersist(state.copyWith(onboardingSeen: true));
  }

  Future<void> toggleDarkMode(bool enabled) async {
    await _setStateAndPersist(state.copyWith(darkMode: enabled));
  }

  Future<void> toggleNotifications(bool enabled) async {
    await _setStateAndPersist(state.copyWith(notificationsEnabled: enabled));
  }

  Future<void> updateLocale(String localeCode) async {
    await _setStateAndPersist(
      state.copyWith(localeCode: normalizeLocaleCode(localeCode)),
    );
  }

  Future<void> updateLearnerName(String name) async {
    final String cleaned = name.trim();
    if (cleaned.isEmpty) {
      return;
    }
    await _setStateAndPersist(state.copyWith(learnerName: cleaned));
  }

  Future<void> toggleBookmark(String lessonId) async {
    final Set<String> bookmarked = Set<String>.from(state.bookmarkedLessons);
    if (bookmarked.contains(lessonId)) {
      bookmarked.remove(lessonId);
    } else {
      bookmarked.add(lessonId);
    }

    await _setStateAndPersist(state.copyWith(bookmarkedLessons: bookmarked));
  }

  Future<void> markLessonComplete(String lessonId) async {
    if (state.completedLessons.contains(lessonId)) {
      return;
    }

    final Set<String> lessons = Set<String>.from(state.completedLessons)
      ..add(lessonId);
    final Set<String> quizzes = Set<String>.from(state.passedQuizzes);
    if (!lessonRequiresQuiz(lessonId)) {
      quizzes.add(lessonId);
    }
    final AppState progress = _applyLearningActivity(
      state.copyWith(
        completedLessons: lessons,
        passedQuizzes: quizzes,
        xp: state.xp + AppConstants.lessonXp,
      ),
    );
    await _setStateAndPersist(_withUpdatedBadges(progress));
  }

  Future<void> markQuizPassed(String lessonId) async {
    if (state.passedQuizzes.contains(lessonId)) {
      return;
    }

    final Set<String> quizzes = Set<String>.from(state.passedQuizzes)
      ..add(lessonId);
    final AppState progress = _applyLearningActivity(
      state.copyWith(
        passedQuizzes: quizzes,
        xp: state.xp + AppConstants.quizXp,
      ),
    );
    await _setStateAndPersist(_withUpdatedBadges(progress));
  }

  Future<void> markPracticeComplete(String levelId) async {
    if (state.completedPractices.contains(levelId)) {
      return;
    }

    final Set<String> practices = Set<String>.from(state.completedPractices)
      ..add(levelId);
    final AppState progress = _applyLearningActivity(
      state.copyWith(
        completedPractices: practices,
        xp: state.xp + AppConstants.practiceXp,
      ),
    );
    await _setStateAndPersist(_withUpdatedBadges(progress));
  }

  Future<void> resetProgress() async {
    final bool keepTheme = state.darkMode;
    final bool keepNotifications = state.notificationsEnabled;
    final String keepLocale = normalizeLocaleCode(state.localeCode);
    final String keepName = state.learnerName;
    final bool keepOnboarding = state.onboardingSeen;

    final AppState reset = AppState.initial().copyWith(
      darkMode: keepTheme,
      notificationsEnabled: keepNotifications,
      localeCode: keepLocale,
      learnerName: keepName,
      onboardingSeen: keepOnboarding,
    );
    await _setStateAndPersist(reset);
  }

  AppState _applyLearningActivity(AppState source) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime? last = source.lastLearningDate;

    int updatedStreak = source.streak;
    if (last == null) {
      updatedStreak = 1;
    } else {
      final DateTime lastDay = DateTime(last.year, last.month, last.day);
      final int diffDays = today.difference(lastDay).inDays;
      if (diffDays == 1) {
        updatedStreak = source.streak + 1;
      } else if (diffDays > 1) {
        updatedStreak = 1;
      }
    }

    return source.copyWith(streak: updatedStreak, lastLearningDate: today);
  }

  AppState _withUpdatedBadges(AppState source) {
    final List<String> badges = <String>[];

    if (source.completedLessons.isNotEmpty) {
      badges.add('first_step');
    }
    if (source.passedQuizzes.isNotEmpty) {
      badges.add('quiz_starter');
    }
    if (source.completedPractices.length >= 3) {
      badges.add('practice_explorer');
    }
    if (source.xp >= 500) {
      badges.add('momentum_coder');
    }

    for (final LearningLevel level in mockLevels) {
      if (isLevelCompleted(level: level, state: source)) {
        badges.add(_levelBadgeId(level.order));
      }
    }

    final bool allDone = mockLevels.every(
      (LearningLevel level) => isLevelCompleted(level: level, state: source),
    );
    if (allDone) {
      badges.add('expert_trailblazer');
    }

    String? latest;
    for (final String badge in badges) {
      if (!source.badges.contains(badge)) {
        latest = badge;
      }
    }

    return source.copyWith(
      badges: badges,
      lastBadge: latest ?? source.lastBadge,
    );
  }

  Future<void> _setStateAndPersist(AppState updated) async {
    state = updated;
    await _storage.saveState(updated);
  }

  String _levelBadgeId(int levelOrder) => 'level_${levelOrder}_cleared';
}
