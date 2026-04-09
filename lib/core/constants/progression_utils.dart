import 'package:jay2xcoder/data/models/app_state.dart';
import 'package:jay2xcoder/data/models/learning_level.dart';
import 'package:jay2xcoder/data/models/lesson_item.dart';

const Set<String> quizOptionalLessonIds = <String>{'l1_1', 'l1_2'};

bool lessonRequiresQuiz(String lessonId) {
  return !quizOptionalLessonIds.contains(lessonId);
}

bool isLessonMastered({required LessonItem lesson, required AppState state}) {
  final bool completed = state.completedLessons.contains(lesson.id);
  final bool quizSatisfied =
      !lessonRequiresQuiz(lesson.id) || state.passedQuizzes.contains(lesson.id);
  return completed && quizSatisfied;
}

List<LearningLevel> sortLevels(List<LearningLevel> levels) {
  final List<LearningLevel> sorted = List<LearningLevel>.from(levels);
  sorted.sort((LearningLevel a, LearningLevel b) => a.order.compareTo(b.order));
  return sorted;
}

List<LessonItem> sortLessons(List<LessonItem> lessons) {
  final List<LessonItem> sorted = List<LessonItem>.from(lessons);
  sorted.sort((LessonItem a, LessonItem b) => a.order.compareTo(b.order));
  return sorted;
}

LearningLevel? findLevelById(List<LearningLevel> levels, String levelId) {
  for (final LearningLevel level in levels) {
    if (level.id == levelId) {
      return level;
    }
  }
  return null;
}

LessonItem? findLessonById(List<LearningLevel> levels, String lessonId) {
  for (final LearningLevel level in levels) {
    for (final LessonItem lesson in level.lessons) {
      if (lesson.id == lessonId) {
        return lesson;
      }
    }
  }
  return null;
}

bool isLevelCompleted({required LearningLevel level, required AppState state}) {
  for (final LessonItem lesson in level.lessons) {
    if (!isLessonMastered(lesson: lesson, state: state)) {
      return false;
    }
  }
  return true;
}

bool isLevelUnlocked({
  required LearningLevel level,
  required List<LearningLevel> levels,
  required AppState state,
}) {
  if (level.order == 1) {
    return true;
  }

  final LearningLevel? previous = sortLevels(
    levels,
  ).where((LearningLevel item) => item.order == level.order - 1).firstOrNull;
  if (previous == null) {
    return false;
  }

  return isLevelCompleted(level: previous, state: state);
}

bool isLessonUnlocked({
  required LessonItem lesson,
  required List<LearningLevel> levels,
  required AppState state,
}) {
  final LearningLevel? level = findLevelById(levels, lesson.levelId);
  if (level == null) {
    return false;
  }

  if (!isLevelUnlocked(level: level, levels: levels, state: state)) {
    return false;
  }

  final List<LessonItem> orderedLessons = sortLessons(level.lessons);
  final int index = orderedLessons.indexWhere(
    (LessonItem item) => item.id == lesson.id,
  );
  if (index <= 0) {
    return true;
  }

  final LessonItem previousLesson = orderedLessons[index - 1];
  return isLessonMastered(lesson: previousLesson, state: state);
}

int currentUnlockedLevelOrder({
  required List<LearningLevel> levels,
  required AppState state,
}) {
  int latest = 1;
  for (final LearningLevel level in sortLevels(levels)) {
    if (isLevelUnlocked(level: level, levels: levels, state: state)) {
      latest = level.order;
    }
  }
  return latest;
}

LessonItem? nextLesson({
  required List<LearningLevel> levels,
  required AppState state,
}) {
  for (final LearningLevel level in sortLevels(levels)) {
    for (final LessonItem lesson in sortLessons(level.lessons)) {
      final bool unlocked = isLessonUnlocked(
        lesson: lesson,
        levels: levels,
        state: state,
      );
      if (!unlocked) {
        continue;
      }
      final bool done = isLessonMastered(lesson: lesson, state: state);
      if (!done) {
        return lesson;
      }
    }
  }
  return null;
}

LessonItem? nextLessonAfter({
  required List<LearningLevel> levels,
  required LessonItem currentLesson,
}) {
  final List<LessonItem> flattened = <LessonItem>[];
  for (final LearningLevel level in sortLevels(levels)) {
    flattened.addAll(sortLessons(level.lessons));
  }

  final int index = flattened.indexWhere(
    (LessonItem item) => item.id == currentLesson.id,
  );
  if (index == -1) {
    return null;
  }

  final int nextIndex = index + 1;
  if (nextIndex >= flattened.length) {
    return null;
  }
  return flattened[nextIndex];
}

double masteryProgress({
  required List<LearningLevel> levels,
  required AppState state,
}) {
  int totalLessonUnits = 0;
  for (final LearningLevel level in levels) {
    totalLessonUnits += level.lessons.length;
  }

  final int totalUnits = (totalLessonUnits * 2) + levels.length;
  if (totalUnits == 0) {
    return 0;
  }

  final int completedUnits =
      state.completedLessons.length +
      state.passedQuizzes.length +
      state.completedPractices.length;
  return completedUnits / totalUnits;
}

extension _FirstOrNullExtension<E> on Iterable<E> {
  E? get firstOrNull {
    if (isEmpty) {
      return null;
    }
    return first;
  }
}
