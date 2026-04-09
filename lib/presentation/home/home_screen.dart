import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jay2xcoder/core/extensions/l10n_extension.dart';
import 'package:jay2xcoder/core/constants/progression_utils.dart';
import 'package:jay2xcoder/core/localization/localization_helpers.dart';
import 'package:jay2xcoder/data/models/learning_level.dart';
import 'package:jay2xcoder/data/models/lesson_item.dart';
import 'package:jay2xcoder/presentation/shared/widgets/dev_background.dart';
import 'package:jay2xcoder/presentation/shared/widgets/progress_ring.dart';
import 'package:jay2xcoder/presentation/shared/widgets/reference_kit.dart';
import 'package:jay2xcoder/presentation/shared/widgets/tech_icon.dart';
import 'package:jay2xcoder/providers/app_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final l10n = context.l10n;
    final appState = ref.watch(appStateControllerProvider);
    final List<LearningLevel> levels = sortLevels(ref.watch(levelsProvider));
    final LessonItem? next = ref.watch(nextLessonProvider);
    final double mastery = ref.watch(masteryProvider).clamp(0, 1);
    final int quoteIndex = ref.watch(dailyQuoteIndexProvider);

    final List<LessonItem> lessons = <LessonItem>[
      for (final LearningLevel level in levels) ...sortLessons(level.lessons),
    ];

    final List<LessonItem> featured = lessons.take(4).toList();
    final String quote = localizedQuote(l10n, quoteIndex);

    final _TechProgress htmlProgress = _techProgress(
      lessons: lessons,
      completed: appState.completedLessons,
      matcher: (LessonItem lesson) =>
          lesson.techLabel.toLowerCase().contains('html'),
      fallbackTotal: 12,
      fallbackDone: 4,
    );
    final _TechProgress cssProgress = _techProgress(
      lessons: lessons,
      completed: appState.completedLessons,
      matcher: (LessonItem lesson) =>
          lesson.techLabel.toLowerCase().contains('css'),
      fallbackTotal: 10,
      fallbackDone: 3,
    );
    final _TechProgress jsProgress = _techProgress(
      lessons: lessons,
      completed: appState.completedLessons,
      matcher: (LessonItem lesson) =>
          lesson.techLabel.toLowerCase().contains('javascript') ||
          lesson.techLabel.toLowerCase().contains('react'),
      fallbackTotal: 15,
      fallbackDone: 2,
    );

    return Stack(
      children: <Widget>[
        const DevBackground(),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ReferenceTopTitle(
                  title: 'Hi ${appState.learnerName},',
                  subtitle: 'Ready to learn today?',
                  trailing: IconButton(
                    onPressed: () => context.push('/settings'),
                    icon: const Icon(Icons.notifications_none_rounded),
                  ),
                ),
                const SizedBox(height: 12),
                ReferenceCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Continue Learning',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: ReferencePalette.textPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        next == null
                            ? 'All lessons completed.'
                            : localizedLessonTitle(l10n, next),
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: ReferencePalette.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        next == null
                            ? 'Great work! review your roadmap.'
                            : '${(mastery * 100).round()}% complete',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: ReferencePalette.textMuted,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          minHeight: 8,
                          value: mastery,
                          color: ReferencePalette.primary,
                          backgroundColor: const Color(0xFFD7DFF1),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ReferencePrimaryButton(
                        label: next == null ? 'View Lessons' : 'Continue',
                        onPressed: () {
                          if (next == null) {
                            context.go('/roadmap');
                            return;
                          }
                          context.push('/lesson/${next.id}');
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: <Widget>[
                    Text(
                      'Featured Courses',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: ReferencePalette.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => context.go('/roadmap'),
                      child: const Text('See All'),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                SizedBox(
                  height: 160,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: featured.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 10),
                    itemBuilder: (BuildContext context, int index) {
                      final LessonItem lesson = featured[index];
                      final List<Color> colors = <Color>[
                        const Color(0xFFFFEFC7),
                        const Color(0xFFDFF0FF),
                        const Color(0xFFE6F7F2),
                        const Color(0xFFFBE5DF),
                      ];

                      return _FeaturedTile(
                        lesson: lesson,
                        color: colors[index % colors.length],
                        onTap: () => context.push('/lesson/${lesson.id}'),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: ReferenceCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Daily Tip',
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: ReferencePalette.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              quote,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: ReferencePalette.textMuted,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ReferenceCard(
                      padding: const EdgeInsets.all(8),
                      child: ProgressRing(value: mastery, label: 'Progress'),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                ReferenceCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Progress Overview',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: ReferencePalette.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _ProgressBar(
                        label: 'HTML',
                        progress: htmlProgress.progress,
                        rightText: '${htmlProgress.done}/${htmlProgress.total}',
                        color: const Color(0xFFF08B54),
                      ),
                      const SizedBox(height: 8),
                      _ProgressBar(
                        label: 'CSS',
                        progress: cssProgress.progress,
                        rightText: '${cssProgress.done}/${cssProgress.total}',
                        color: const Color(0xFF6EC2E8),
                      ),
                      const SizedBox(height: 8),
                      _ProgressBar(
                        label: 'JS',
                        progress: jsProgress.progress,
                        rightText: '${jsProgress.done}/${jsProgress.total}',
                        color: const Color(0xFFF3D45A),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _TechProgress _techProgress({
    required List<LessonItem> lessons,
    required Set<String> completed,
    required bool Function(LessonItem lesson) matcher,
    required int fallbackTotal,
    required int fallbackDone,
  }) {
    final List<LessonItem> matched = lessons.where(matcher).toList();
    if (matched.isEmpty) {
      return _TechProgress(
        done: fallbackDone,
        total: fallbackTotal,
        progress: fallbackDone / fallbackTotal,
      );
    }

    final int done = matched
        .where((LessonItem lesson) => completed.contains(lesson.id))
        .length;
    final int total = matched.length;

    return _TechProgress(
      done: done,
      total: total,
      progress: total == 0 ? 0 : done / total,
    );
  }
}

class _FeaturedTile extends StatelessWidget {
  const _FeaturedTile({
    required this.lesson,
    required this.color,
    required this.onTap,
  });

  final LessonItem lesson;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        width: 132,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ReferencePalette.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: TechIcon(asset: lesson.techIconAsset, size: 26),
              ),
            ),
            const Spacer(),
            Text(
              lesson.techLabel.toUpperCase(),
              style: theme.textTheme.labelSmall?.copyWith(
                color: ReferencePalette.textMuted,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              lesson.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: ReferencePalette.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({
    required this.label,
    required this.progress,
    required this.rightText,
    required this.color,
  });

  final String label;
  final double progress;
  final String rightText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: ReferencePalette.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Text(
              rightText,
              style: theme.textTheme.bodySmall?.copyWith(
                color: ReferencePalette.textMuted,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: progress.clamp(0, 1),
            minHeight: 6,
            color: color,
            backgroundColor: const Color(0xFFE5EBF8),
          ),
        ),
      ],
    );
  }
}

class _TechProgress {
  const _TechProgress({
    required this.done,
    required this.total,
    required this.progress,
  });

  final int done;
  final int total;
  final double progress;
}
