import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jay2xcoder/providers/app_providers.dart';
import 'package:jay2xcoder/presentation/shared/widgets/reference_kit.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  bool _busy = false;

  Future<void> _finish() async {
    setState(() {
      _busy = true;
    });

    await ref.read(appStateControllerProvider.notifier).completeOnboarding();
    if (!mounted) {
      return;
    }
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: ReferenceBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 18),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _busy ? null : _finish,
                    child: const Text('Skip'),
                  ),
                ),
                Expanded(
                  child: ReferenceCard(
                    color: const Color(0xFFF3F8FF),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/illustrations/online-learning.svg',
                          height: 180,
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Welcome boss!',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: ReferencePalette.textPrimary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Let\'s start your coding journey.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: ReferencePalette.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ReferencePrimaryButton(
                  label: _busy ? 'Loading...' : 'Start Learning',
                  onPressed: _busy ? null : _finish,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
