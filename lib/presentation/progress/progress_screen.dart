import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jay2xcoder/core/constants/progression_utils.dart';
import 'package:jay2xcoder/core/extensions/l10n_extension.dart';
import 'package:jay2xcoder/core/localization/localization_helpers.dart';
import 'package:jay2xcoder/data/models/learning_level.dart';
import 'package:jay2xcoder/data/models/lesson_item.dart';
import 'package:jay2xcoder/presentation/shared/widgets/dev_background.dart';
import 'package:jay2xcoder/presentation/shared/widgets/reference_kit.dart';
import 'package:jay2xcoder/presentation/shared/widgets/tech_icon.dart';
import 'package:jay2xcoder/providers/app_providers.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final l10n = context.l10n;
    final state = ref.watch(appStateControllerProvider);
    final List<LearningLevel> levels = sortLevels(ref.watch(levelsProvider));

    final List<LessonItem> lessons = <LessonItem>[
      for (final LearningLevel level in levels) ...sortLessons(level.lessons),
    ];

    final int totalLessons = lessons.length;
    final int completedLessons = state.completedLessons.length;

    final _TrackProgress html = _progressFor(
      lessons: lessons,
      completed: state.completedLessons,
      matcher: (LessonItem lesson) =>
          lesson.techLabel.toLowerCase().contains('html'),
    );
    final _TrackProgress css = _progressFor(
      lessons: lessons,
      completed: state.completedLessons,
      matcher: (LessonItem lesson) =>
          lesson.techLabel.toLowerCase().contains('css'),
    );
    final _TrackProgress js = _progressFor(
      lessons: lessons,
      completed: state.completedLessons,
      matcher: (LessonItem lesson) =>
          lesson.techLabel.toLowerCase().contains('javascript') ||
          lesson.techLabel.toLowerCase().contains('react'),
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
                  title: 'My Coding Journey',
                  subtitle: 'Completed Lessons',
                  trailing: Text(
                    '[$completedLessons/$totalLessons]',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: ReferencePalette.textPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                ReferenceCard(
                  child: Column(
                    children: <Widget>[
                      _TrackBar(
                        label: 'HTML',
                        color: const Color(0xFFF08B54),
                        value: html.value,
                        right: '${html.done}',
                      ),
                      const SizedBox(height: 10),
                      _TrackBar(
                        label: 'CSS',
                        color: const Color(0xFF67BEE3),
                        value: css.value,
                        right: '${css.done}',
                      ),
                      const SizedBox(height: 10),
                      _TrackBar(
                        label: 'JS',
                        color: const Color(0xFFF3D353),
                        value: js.value,
                        right: '${js.done}',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                ReferenceCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Earned badges',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: ReferencePalette.textPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          _BadgeTile(
                            asset: 'assets/tech/html5.svg',
                            label: 'HTML\nStarter',
                          ),
                          const SizedBox(width: 10),
                          _BadgeTile(
                            asset: 'assets/tech/css3.svg',
                            label: 'CSS\nExplorer',
                          ),
                          const SizedBox(width: 10),
                          _BadgeTile(
                            asset: 'assets/tech/javascript.svg',
                            label: 'JS\nExplorer',
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              height: 84,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF2F6FF),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: ReferencePalette.border,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Icon(
                                    Icons.workspace_premium_rounded,
                                    color: ReferencePalette.primary,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${state.badges.length}',
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(
                                          color: ReferencePalette.textPrimary,
                                          fontWeight: FontWeight.w800,
                                        ),
                                  ),
                                  Text(
                                    'Total',
                                    style: theme.textTheme.labelSmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (state.badges.isNotEmpty) ...<Widget>[
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: state.badges
                              .take(5)
                              .map(
                                (String id) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 9,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEEF3FF),
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Text(
                                    localizedBadge(l10n, id),
                                    style: theme.textTheme.labelSmall,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
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

  _TrackProgress _progressFor({
    required List<LessonItem> lessons,
    required Set<String> completed,
    required bool Function(LessonItem lesson) matcher,
  }) {
    final List<LessonItem> filtered = lessons.where(matcher).toList();
    if (filtered.isEmpty) {
      return const _TrackProgress(value: 0.15, done: 0);
    }

    final int done = filtered
        .where((LessonItem lesson) => completed.contains(lesson.id))
        .length;
    return _TrackProgress(value: done / filtered.length, done: done);
  }
}

class _TrackBar extends StatelessWidget {
  const _TrackBar({
    required this.label,
    required this.color,
    required this.value,
    required this.right,
  });

  final String label;
  final Color color;
  final double value;
  final String right;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      children: <Widget>[
        SizedBox(
          width: 46,
          child: Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: ReferencePalette.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              minHeight: 6,
              value: value.clamp(0, 1),
              color: color,
              backgroundColor: const Color(0xFFE6EBF8),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 22,
          child: Text(
            right,
            textAlign: TextAlign.right,
            style: theme.textTheme.bodySmall?.copyWith(
              color: ReferencePalette.textMuted,
            ),
          ),
        ),
      ],
    );
  }
}

class _BadgeTile extends StatelessWidget {
  const _BadgeTile({required this.asset, required this.label});

  final String asset;
  final String label;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Expanded(
      child: Container(
        height: 84,
        decoration: BoxDecoration(
          color: const Color(0xFFF2F6FF),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: ReferencePalette.border),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TechIcon(asset: asset, size: 30),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelSmall?.copyWith(
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

class _TrackProgress {
  const _TrackProgress({required this.value, required this.done});

  final double value;
  final int done;
}
