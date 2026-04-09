import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jay2xcoder/core/constants/progression_utils.dart';
import 'package:jay2xcoder/core/extensions/l10n_extension.dart';
import 'package:jay2xcoder/core/localization/localization_helpers.dart';
import 'package:jay2xcoder/data/models/learning_level.dart';
import 'package:jay2xcoder/data/models/lesson_item.dart';
import 'package:jay2xcoder/presentation/shared/widgets/dev_background.dart';
import 'package:jay2xcoder/presentation/shared/widgets/progress_ring.dart';
import 'package:jay2xcoder/presentation/shared/widgets/reference_kit.dart';
import 'package:jay2xcoder/presentation/shared/widgets/stagger_reveal.dart';
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

    final Map<String, LessonItem> byId = <String, LessonItem>{
      for (final LessonItem lesson in lessons) lesson.id: lesson,
    };

    final List<LessonItem> featured = <String>[
      'l1_1',
      'l2_1',
      'l3_1',
      'l4_1',
      'l5_1',
      'l9_1',
    ].map((String id) => byId[id]).whereType<LessonItem>().toList();

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
    final _TechProgress phpProgress = _techProgress(
      lessons: lessons,
      completed: appState.completedLessons,
      matcher: (LessonItem lesson) =>
          lesson.techLabel.toLowerCase().contains('php'),
      fallbackTotal: 8,
      fallbackDone: 0,
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
                  title: 'Hi ${appState.learnerName}',
                  subtitle: 'Ready to learn today?',
                  trailing: IconButton(
                    onPressed: () => context.push('/settings'),
                    icon: const Icon(Icons.settings_outlined),
                  ),
                ),
                const SizedBox(height: 12),
                StaggerReveal(
                  index: 0,
                  child: ReferenceCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Continue Learning',
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: ReferencePalette.onSurface(context),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          next == null
                              ? 'All lessons completed.'
                              : localizedLessonTitle(l10n, next),
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: ReferencePalette.onSurface(context),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          next == null
                              ? 'Great work! review your roadmap.'
                              : '[${(mastery * 100).round()}%]',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: ReferencePalette.onMuted(context),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: LinearProgressIndicator(
                            minHeight: 14,
                            value: mastery,
                            color: ReferencePalette.accentStart,
                            backgroundColor: const Color(0xFFE2E8F0),
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
                ),
                const SizedBox(height: 14),
                Row(
                  children: <Widget>[
                    Text(
                      'Featured Courses',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: ReferencePalette.onSurface(context),
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
                StaggerReveal(
                  index: 1,
                  child: SizedBox(
                    height: 170,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: featured.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 10),
                      itemBuilder: (BuildContext context, int index) {
                        final LessonItem lesson = featured[index];
                        final List<Color> colors = <Color>[
                          const Color(0xFFFFF4D9),
                          const Color(0xFFE4F0FF),
                          const Color(0xFFE7FBF6),
                          const Color(0xFFF8EFFF),
                        ];

                        return _FeaturedTile(
                          lesson: lesson,
                          color: colors[index % colors.length],
                          onTap: () => context.push('/lesson/${lesson.id}'),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                StaggerReveal(
                  index: 2,
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      final bool compact = constraints.maxWidth < 460;

                      if (compact) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _DailyTipCard(quote: quote),
                            const SizedBox(height: 10),
                            Center(
                              child: SizedBox(
                                width: 170,
                                child: ReferenceCard(
                                  padding: const EdgeInsets.all(10),
                                  color: const Color(0xFFF8FAFC),
                                  borderColor: ReferencePalette.border,
                                  child: ProgressRing(
                                    value: mastery,
                                    label: 'Progress',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(child: _DailyTipCard(quote: quote)),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 130,
                            child: ReferenceCard(
                              padding: const EdgeInsets.all(10),
                              color: const Color(0xFFF8FAFC),
                              borderColor: ReferencePalette.border,
                              child: ProgressRing(
                                value: mastery,
                                label: 'Progress',
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 14),
                StaggerReveal(
                  index: 3,
                  child: ReferenceCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Progress Overview',
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: ReferencePalette.onSurface(context),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _ProgressBar(
                          label: 'HTML',
                          progress: htmlProgress.progress,
                          rightText:
                              '${htmlProgress.done}/${htmlProgress.total} | ${(htmlProgress.progress * 100).round()}%',
                          color: const Color(0xFFE67E22),
                        ),
                        const SizedBox(height: 10),
                        _ProgressBar(
                          label: 'CSS',
                          progress: cssProgress.progress,
                          rightText:
                              '${cssProgress.done}/${cssProgress.total} | ${(cssProgress.progress * 100).round()}%',
                          color: ReferencePalette.softTeal,
                        ),
                        const SizedBox(height: 10),
                        _ProgressBar(
                          label: 'JS',
                          progress: jsProgress.progress,
                          rightText:
                              '${jsProgress.done}/${jsProgress.total} | ${(jsProgress.progress * 100).round()}%',
                          color: const Color(0xFFF1C40F),
                        ),
                        const SizedBox(height: 10),
                        _ProgressBar(
                          label: 'PHP',
                          progress: phpProgress.progress,
                          rightText:
                              '${phpProgress.done}/${phpProgress.total} | ${(phpProgress.progress * 100).round()}%',
                          color: const Color(0xFF8E44AD),
                        ),
                      ],
                    ),
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
    const Color titleColor = ReferencePalette.textNeutral;
    const Color subtitleColor = Color(0xFF475569);

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        width: 138,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: ReferencePalette.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.86),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: TechIcon(asset: lesson.techIconAsset, size: 32),
              ),
            ),
            const Spacer(),
            Text(
              lesson.techLabel.toUpperCase(),
              style: theme.textTheme.labelSmall?.copyWith(
                color: subtitleColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              lesson.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: titleColor,
                fontWeight: FontWeight.w600,
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
                color: ReferencePalette.onSurface(context),
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Text(
              rightText,
              style: theme.textTheme.bodySmall?.copyWith(
                color: ReferencePalette.onMuted(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: progress.clamp(0, 1),
            minHeight: 14,
            color: color,
            backgroundColor: const Color(0xFFE2E8F0),
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

class _DailyTipCard extends StatelessWidget {
  const _DailyTipCard({required this.quote});

  final String quote;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ReferenceCard(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: <Color>[
                        ReferencePalette.accentStart,
                        ReferencePalette.accentEnd,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'Daily Tip',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  quote,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: ReferencePalette.onMuted(context),
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: ReferencePalette.surfaceSoft(context),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: ReferencePalette.cardBorder(context),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/tech/html5.svg',
                        width: 14,
                        height: 14,
                      ),
                      const SizedBox(width: 5),
                      SvgPicture.asset(
                        'assets/tech/css3.svg',
                        width: 14,
                        height: 14,
                      ),
                      const SizedBox(width: 5),
                      SvgPicture.asset(
                        'assets/tech/javascript.svg',
                        width: 14,
                        height: 14,
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        child: Text(
                          'Code small, learn fast.',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: ReferencePalette.textNeutral,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 76,
            height: 76,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: <Color>[
                  ReferencePalette.surfaceSoft(context),
                  ReferencePalette.surfaceSoft(context).withValues(alpha: 0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: ReferencePalette.cardBorder(context)),
            ),
            child: SvgPicture.asset(
              'assets/illustrations/online-learning.svg',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
