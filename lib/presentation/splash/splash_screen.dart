import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jay2xcoder/core/constants/app_constants.dart';
import 'package:jay2xcoder/presentation/shared/widgets/reference_kit.dart';
import 'package:jay2xcoder/providers/app_providers.dart';

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
    final bool dark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: AnimatedOpacity(
        opacity: _visible ? 1 : 0,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeOut,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: dark
                  ? const <Color>[Color(0xFF172033), Color(0xFF0F172A)]
                  : const <Color>[Color(0xFFBFD8F9), Color(0xFF8BB7EE)],
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(24, 18, 24, 12),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 10),
                      Text(
                        AppConstants.appName,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: dark
                              ? Colors.white
                              : ReferencePalette.onSurface(context),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Learn coding step by step',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: dark
                              ? Colors.white70
                              : ReferencePalette.onSurface(
                                  context,
                                ).withValues(alpha: 0.75),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            'assets/illustrations/splash_programming.svg',
                            width: constraints.maxWidth,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
