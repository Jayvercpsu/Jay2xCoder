import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jay2xcoder/core/constants/app_constants.dart';
import 'package:jay2xcoder/providers/app_providers.dart';
import 'package:jay2xcoder/presentation/shared/widgets/reference_kit.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future<void>.microtask(_startFlow);
  }

  Future<void> _startFlow() async {
    setState(() {
      _visible = true;
    });

    await Future<void>.delayed(const Duration(milliseconds: 1800));
    if (!mounted) {
      return;
    }

    final bool seen = ref.read(appStateControllerProvider).onboardingSeen;
    context.go(seen ? '/home' : '/onboarding');
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: ReferenceBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 26),
            child: AnimatedOpacity(
              opacity: _visible ? 1 : 0,
              duration: const Duration(milliseconds: 650),
              curve: Curves.easeOut,
              child: Column(
                children: <Widget>[
                  const Spacer(),
                  Text(
                    AppConstants.appName,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: ReferencePalette.textPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Learn coding step by step',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: ReferencePalette.textMuted,
                    ),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/illustrations/programming.svg',
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
