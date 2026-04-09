import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jay2xcoder/presentation/shared/widgets/reference_kit.dart';
import 'package:jay2xcoder/providers/app_providers.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  bool _busy = false;
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: ref.read(appStateControllerProvider).learnerName,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    setState(() {
      _busy = true;
    });

    final String name = _nameController.text.trim();
    if (name.isNotEmpty) {
      await ref
          .read(appStateControllerProvider.notifier)
          .updateLearnerName(name);
    }

    await ref.read(appStateControllerProvider.notifier).completeOnboarding();
    if (!mounted) {
      return;
    }
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool dark = theme.brightness == Brightness.dark;

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
                    color: dark
                        ? const Color(0xFF111827)
                        : const Color(0xFFF9FBFF),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/illustrations/splash_programming.svg',
                          height: 190,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Welcome boss!',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: dark
                                ? Colors.white
                                : ReferencePalette.onSurface(context),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'What is your name?',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: dark
                                ? Colors.white70
                                : ReferencePalette.onMuted(context),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _nameController,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) {
                            if (!_busy) {
                              _finish();
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: 'Enter your name',
                            prefixIcon: Icon(Icons.person_outline_rounded),
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
