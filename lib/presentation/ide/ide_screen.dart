import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jay2xcoder/presentation/shared/widgets/dev_background.dart';
import 'package:jay2xcoder/presentation/shared/widgets/reference_kit.dart';
import 'package:jay2xcoder/providers/app_providers.dart';

class IdeScreen extends ConsumerWidget {
  const IdeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final templates = ref.watch(codePracticeTemplatesProvider);

    final List<_MiniProject> ideas = <_MiniProject>[
      const _MiniProject(
        templateId: 'l2_1',
        title: 'Personal Profile Page',
        difficulty: 'Difficulty: Level',
        note: 'Build your profile page using HTML structure.',
      ),
      const _MiniProject(
        templateId: 'l3_1',
        title: 'To-Do List UI',
        difficulty: 'Difficulty: Level',
        note: 'Style task list cards with clean spacing.',
      ),
      const _MiniProject(
        templateId: 'l4_1',
        title: 'Simple Calculator',
        difficulty: 'Difficulty: Level',
        note: 'Use JS functions and basic operators.',
      ),
    ];

    final List<_MiniProject> available = ideas
        .where((item) => templates.containsKey(item.templateId))
        .toList();

    return Stack(
      children: <Widget>[
        const DevBackground(),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const ReferenceTopTitle(title: 'Mini Project Ideas'),
                const SizedBox(height: 12),
                if (available.isEmpty)
                  const ReferenceCard(
                    child: Text('No mini project templates available yet.'),
                  )
                else
                  ...available.map(
                    (_MiniProject item) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ReferenceCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item.title,
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: ReferencePalette.textPrimary,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item.difficulty,
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: ReferencePalette.textMuted,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.note,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: ReferencePalette.textMuted,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ReferencePrimaryButton(
                              label: 'Start Project',
                              onPressed: () => context.push(
                                '/ide/playground/${item.templateId}',
                              ),
                            ),
                          ],
                        ),
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
}

class _MiniProject {
  const _MiniProject({
    required this.templateId,
    required this.title,
    required this.difficulty,
    required this.note,
  });

  final String templateId;
  final String title;
  final String difficulty;
  final String note;
}
