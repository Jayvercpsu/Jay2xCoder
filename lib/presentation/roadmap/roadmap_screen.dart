import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jay2xcoder/core/constants/progression_utils.dart';
import 'package:jay2xcoder/core/extensions/l10n_extension.dart';
import 'package:jay2xcoder/core/localization/localization_helpers.dart';
import 'package:jay2xcoder/data/models/app_state.dart';
import 'package:jay2xcoder/data/models/learning_level.dart';
import 'package:jay2xcoder/data/models/lesson_item.dart';
import 'package:jay2xcoder/presentation/shared/widgets/dev_background.dart';
import 'package:jay2xcoder/presentation/shared/widgets/reference_kit.dart';
import 'package:jay2xcoder/presentation/shared/widgets/stagger_reveal.dart';
import 'package:jay2xcoder/presentation/shared/widgets/tech_icon.dart';
import 'package:jay2xcoder/providers/app_providers.dart';

class RoadmapScreen extends ConsumerStatefulWidget {
  const RoadmapScreen({super.key});

  @override
  ConsumerState<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends ConsumerState<RoadmapScreen> {
  String _query = '';
  String _tab = 'All';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final l10n = context.l10n;
    final AppState state = ref.watch(appStateControllerProvider);
    final List<LearningLevel> levels = sortLevels(ref.watch(levelsProvider));

    final List<_LessonListItem> allLessons = <_LessonListItem>[
      for (final LearningLevel level in levels)
        for (final LessonItem lesson in sortLessons(level.lessons))
          _LessonListItem(level: level, lesson: lesson),
    ];

    final List<_LessonListItem> filtered = allLessons.where((item) {
      final String title = localizedLessonTitle(
        l10n,
        item.lesson,
      ).toLowerCase();
      final String tech = item.lesson.techLabel.toLowerCase();
      final String query = _query.trim().toLowerCase();

      final bool queryMatch =
          query.isEmpty || title.contains(query) || tech.contains(query);

      if (!queryMatch) {
        return false;
      }

      switch (_tab) {
        case 'Popular':
          return item.level.order <= 4;
        case 'New':
          return item.level.order >= 5;
        case 'Beginner':
          return item.level.order <= 3;
        case 'All':
        default:
          return true;
      }
    }).toList();

    return Stack(
      children: <Widget>[
        const DevBackground(),
        SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                child: Column(
                  children: <Widget>[
                    const ReferenceTopTitle(title: 'All Lessons'),
                    const SizedBox(height: 10),
                    TextField(
                      onChanged: (String value) {
                        setState(() {
                          _query = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search_rounded),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        _TabPill(
                          label: 'All',
                          selected: _tab == 'All',
                          onTap: () => setState(() => _tab = 'All'),
                        ),
                        const SizedBox(width: 8),
                        _TabPill(
                          label: 'Beginner',
                          selected: _tab == 'Beginner',
                          onTap: () => setState(() => _tab = 'Beginner'),
                        ),
                        const SizedBox(width: 8),
                        _TabPill(
                          label: 'Popular',
                          selected: _tab == 'Popular',
                          onTap: () => setState(() => _tab = 'Popular'),
                        ),
                        const SizedBox(width: 8),
                        _TabPill(
                          label: 'New',
                          selected: _tab == 'New',
                          onTap: () => setState(() => _tab = 'New'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 110),
                  itemCount: filtered.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (BuildContext context, int index) {
                    final _LessonListItem item = filtered[index];
                    final bool unlocked = isLessonUnlocked(
                      lesson: item.lesson,
                      levels: levels,
                      state: state,
                    );
                    final bool done =
                        state.completedLessons.contains(item.lesson.id) &&
                        state.passedQuizzes.contains(item.lesson.id);

                    final List<Color> colors = <Color>[
                      const Color(0xFFE9E8FF),
                      const Color(0xFFDDF5F0),
                      const Color(0xFFFFF1CC),
                      const Color(0xFFFDE6E0),
                    ];
                    final Color cardColor = colors[index % colors.length];

                    return StaggerReveal(
                      index: index,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: unlocked
                            ? () => context.push('/lesson/${item.lesson.id}')
                            : () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Complete previous lessons first.',
                                    ),
                                  ),
                                );
                              },
                        child: ReferenceCard(
                          color: cardColor,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      localizedLessonTitle(l10n, item.lesson),
                                      style: theme.textTheme.titleSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w800,
                                            color: ReferencePalette.onSurface(
                                              context,
                                            ),
                                          ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      item.lesson.shortExplanation,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                            color: ReferencePalette.onMuted(
                                              context,
                                            ),
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: ReferencePalette.accentStart,
                                            borderRadius: BorderRadius.circular(
                                              999,
                                            ),
                                          ),
                                          child: Text(
                                            done
                                                ? 'Completed'
                                                : unlocked
                                                ? 'Beginner'
                                                : 'Locked',
                                            style: theme.textTheme.labelSmall
                                                ?.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          item.lesson.techLabel,
                                          style: theme.textTheme.labelSmall
                                              ?.copyWith(
                                                color: ReferencePalette.onMuted(
                                                  context,
                                                ),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                children: <Widget>[
                                  SizedBox(
                                    width: 48,
                                    height: 48,
                                    child: TechIcon(
                                      asset: item.lesson.techIconAsset,
                                      size: 38,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Icon(
                                    done
                                        ? Icons.check_circle_rounded
                                        : Icons.chevron_right_rounded,
                                    color: done
                                        ? Colors.green
                                        : ReferencePalette.onMuted(context),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LessonListItem {
  const _LessonListItem({required this.level, required this.lesson});

  final LearningLevel level;
  final LessonItem lesson;
}

class _TabPill extends StatelessWidget {
  const _TabPill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? ReferencePalette.accentStart : Colors.white,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: ReferencePalette.border),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: selected
                ? Colors.white
                : ReferencePalette.onSurface(context),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
