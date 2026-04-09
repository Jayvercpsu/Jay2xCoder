import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jay2xcoder/core/constants/progression_utils.dart';
import 'package:jay2xcoder/core/extensions/l10n_extension.dart';
import 'package:jay2xcoder/core/localization/localization_helpers.dart';
import 'package:jay2xcoder/data/models/code_practice_template.dart';
import 'package:jay2xcoder/data/models/learning_level.dart';
import 'package:jay2xcoder/data/models/lesson_item.dart';
import 'package:jay2xcoder/presentation/shared/widgets/dev_background.dart';
import 'package:jay2xcoder/presentation/shared/widgets/reference_kit.dart';
import 'package:jay2xcoder/providers/app_providers.dart';

class LessonScreen extends ConsumerWidget {
  const LessonScreen({super.key, required this.lessonId});

  final String lessonId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final l10n = context.l10n;
    final state = ref.watch(appStateControllerProvider);
    final List<LearningLevel> levels = ref.watch(levelsProvider);
    final Map<String, CodePracticeTemplate> templates = ref.watch(
      codePracticeTemplatesProvider,
    );

    final LessonItem? lesson = findLessonById(levels, lessonId);
    if (lesson == null) {
      return Scaffold(body: const Center(child: Text('Lesson not found.')));
    }

    final bool unlocked = isLessonUnlocked(
      lesson: lesson,
      levels: levels,
      state: state,
    );
    final bool quizPassed = state.passedQuizzes.contains(lesson.id);
    final bool completed = state.completedLessons.contains(lesson.id);
    final bool bookmarked = state.bookmarkedLessons.contains(lesson.id);

    final LessonItem? next = nextLessonAfter(
      levels: levels,
      currentLesson: lesson,
    );
    final bool canGoNext = next != null && quizPassed;

    final String title = localizedLessonTitle(l10n, lesson);
    final String intro = localizedLessonIntro(l10n, lesson);
    final String output = localizedLessonExpectedOutput(
      l10n,
      lesson,
      lesson.miniActivity,
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          const DevBackground(),
          SafeArea(
            child: unlocked
                ? SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            IconButton(
                              onPressed: () => context.pop(),
                              icon: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  color: ReferencePalette.textPrimary,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                await ref
                                    .read(appStateControllerProvider.notifier)
                                    .toggleBookmark(lesson.id);
                              },
                              icon: Icon(
                                bookmarked
                                    ? Icons.bookmark_rounded
                                    : Icons.bookmark_outline_rounded,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ReferenceCard(
                          color: const Color(0xFFEFEFFF),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'What is this?',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: ReferencePalette.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                intro,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: ReferencePalette.textMuted,
                                  height: 1.45,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Example',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: ReferencePalette.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E2536),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  lesson.example,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: const Color(0xFFB9E4FF),
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Key Notes',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: ReferencePalette.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ...lesson.keyTakeaways
                                  .take(3)
                                  .map(
                                    (String note) => Padding(
                                      padding: const EdgeInsets.only(bottom: 6),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const Padding(
                                            padding: EdgeInsets.only(top: 2),
                                            child: Icon(
                                              Icons.circle,
                                              size: 8,
                                              color: ReferencePalette.primary,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              note,
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                    color: ReferencePalette
                                                        .textMuted,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              const SizedBox(height: 4),
                              Text(
                                output,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: ReferencePalette.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: ReferenceSecondaryButton(
                                label: completed
                                    ? 'Review Lesson'
                                    : 'Start Lesson',
                                onPressed: () async {
                                  if (!completed) {
                                    await ref
                                        .read(
                                          appStateControllerProvider.notifier,
                                        )
                                        .markLessonComplete(lesson.id);
                                  }

                                  if (!context.mounted) {
                                    return;
                                  }

                                  final CodePracticeTemplate? template =
                                      templates[lesson.id];
                                  if (template != null) {
                                    context.push(
                                      '/lesson/${lesson.id}/playground',
                                    );
                                  } else {
                                    context.push(
                                      '/lesson/${lesson.id}/practice',
                                    );
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ReferencePrimaryButton(
                                label: 'Next Lesson',
                                onPressed: canGoNext
                                    ? () => context.push('/lesson/${next.id}')
                                    : () {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              next == null
                                                  ? 'No next lesson yet.'
                                                  : 'Pass the quiz first to unlock next.',
                                            ),
                                          ),
                                        );
                                      },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : SafeArea(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: ReferenceCard(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const <Widget>[
                              Icon(
                                Icons.lock_outline_rounded,
                                size: 42,
                                color: ReferencePalette.primary,
                              ),
                              SizedBox(height: 10),
                              Text('Lesson is locked right now.'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
