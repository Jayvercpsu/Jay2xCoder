import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jay2xcoder/presentation/shared/widgets/dev_background.dart';
import 'package:jay2xcoder/presentation/shared/widgets/reference_kit.dart';
import 'package:jay2xcoder/presentation/shared/widgets/stagger_reveal.dart';

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
                  child: StaggerReveal(
                    index: 0,
                    child: ReferenceCard(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/illustrations/splash_programming.svg',
                            height: 180,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 18),
                          Text(
                            'About Jay2xCoder',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: ReferencePalette.onSurface(context),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Jay2xCoder helps students learn coding step-by-step with clear lessons, guided practice, and progress tracking.',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: ReferencePalette.onMuted(context),
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: ReferencePalette.surfaceSoft(context),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: ReferencePalette.cardBorder(context),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Send feedback to:',
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: ReferencePalette.onMuted(context),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'jayver.cpsu@gmail.com',
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    color: ReferencePalette.accentStart,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Powered by Jayver Algadipe',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: ReferencePalette.onMuted(context),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
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
