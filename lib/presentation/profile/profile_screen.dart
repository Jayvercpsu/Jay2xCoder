import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jay2xcoder/presentation/shared/widgets/dev_background.dart';
import 'package:jay2xcoder/presentation/shared/widgets/reference_kit.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);

    return Stack(
      children: <Widget>[
        const DevBackground(),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const ReferenceTopTitle(title: 'About Jay2xCoder'),
                const SizedBox(height: 18),
                Expanded(
                  child: ReferenceCard(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/illustrations/code-typing.svg',
                          height: 180,
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'About Jay2xCoder',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: ReferencePalette.textPrimary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Jay2xCoder helps freshers learn coding step-by-step. '
                          'This app focuses on simple lessons, practice, and '
                          'progress tracking for your daily journey.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: ReferencePalette.textMuted,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF3FF),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            'No plagiarism message.',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: ReferencePalette.textMuted,
                              fontWeight: FontWeight.w700,
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
      ],
    );
  }
}
