import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jay2xcoder/core/constants/progression_utils.dart';
import 'package:jay2xcoder/data/models/learning_level.dart';
import 'package:jay2xcoder/data/models/lesson_item.dart';
import 'package:jay2xcoder/presentation/shared/widgets/dev_background.dart';
import 'package:jay2xcoder/presentation/shared/widgets/reference_kit.dart';
import 'package:jay2xcoder/presentation/shared/widgets/stagger_reveal.dart';
import 'package:jay2xcoder/presentation/shared/widgets/tech_icon.dart';
import 'package:jay2xcoder/providers/app_providers.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
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
    final _TrackProgress php = _progressFor(
      lessons: lessons,
      completed: state.completedLessons,
      matcher: (LessonItem lesson) =>
          lesson.techLabel.toLowerCase().contains('php'),
    );

    return Stack(
      children: <Widget>[
        const DevBackground(),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 110),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 540),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ReferenceTopTitle(
                      title: 'My Coding Journey',
                      subtitle:
                          'Completed Lessons [$completedLessons/$totalLessons]',
                    ),
                    const SizedBox(height: 14),
                    StaggerReveal(
                      index: 0,
                      child: ReferenceCard(
                        child: Column(
                          children: <Widget>[
                            _TrackBar(
                              label: 'HTML',
                              color: const Color(0xFFE67E22),
                              value: html.value,
                              right: '${html.done}',
                            ),
                            const SizedBox(height: 12),
                            _TrackBar(
                              label: 'CSS',
                              color: ReferencePalette.softTeal,
                              value: css.value,
                              right: '${css.done}',
                            ),
                            const SizedBox(height: 12),
                            _TrackBar(
                              label: 'JS',
                              color: const Color(0xFFF1C40F),
                              value: js.value,
                              right: '${js.done}',
                            ),
                            const SizedBox(height: 12),
                            _TrackBar(
                              label: 'PHP',
                              color: const Color(0xFF8E44AD),
                              value: php.value,
                              right: '${php.done}',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    StaggerReveal(
                      index: 1,
                      child: ReferenceCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Earned badges',
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: ReferencePalette.onSurface(context),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: <Widget>[
                                const Expanded(
                                  child: _BadgeTile(
                                    logoAsset: 'assets/tech/html5.svg',
                                    label: 'HTML\nStarter',
                                    color: Color(0xFFFFE4D6),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Expanded(
                                  child: _BadgeTile(
                                    logoAsset: 'assets/tech/css3.svg',
                                    label: 'CSS\nExplorer',
                                    color: Color(0xFFDDF2FF),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Expanded(
                                  child: _BadgeTile(
                                    logoAsset: 'assets/tech/javascript.svg',
                                    label: 'JS\nExplorer',
                                    color: Color(0xFFFFF4C9),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5FF),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: ReferencePalette.border,
                                ),
                              ),
                              child: Text(
                                'Earned: ${state.badges.length} badge(s)',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: ReferencePalette.textNeutral,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
              color: ReferencePalette.onSurface(context),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              minHeight: 14,
              value: value.clamp(0, 1),
              color: color,
              backgroundColor: const Color(0xFFE2E8F0),
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
              color: ReferencePalette.onMuted(context),
            ),
          ),
        ),
      ],
    );
  }
}

class _BadgeTile extends StatelessWidget {
  const _BadgeTile({
    required this.logoAsset,
    required this.label,
    required this.color,
  });

  final String logoAsset;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      height: 114,
      decoration: BoxDecoration(
        color: const Color(0xFFF6FAFF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: ReferencePalette.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: ReferencePalette.border),
            ),
            child: Center(child: TechIcon(asset: logoAsset, size: 30)),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              color: ReferencePalette.textNeutral,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _TrackProgress {
  const _TrackProgress({required this.value, required this.done});

  final double value;
  final int done;
}
