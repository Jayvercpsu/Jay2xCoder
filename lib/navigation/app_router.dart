import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jay2xcoder/core/constants/progression_utils.dart';
import 'package:jay2xcoder/core/extensions/l10n_extension.dart';
import 'package:jay2xcoder/presentation/home/home_screen.dart';
import 'package:jay2xcoder/presentation/lesson/lesson_screen.dart';
import 'package:jay2xcoder/presentation/onboarding/onboarding_screen.dart';
import 'package:jay2xcoder/presentation/practice/coding_playground_screen.dart';
import 'package:jay2xcoder/presentation/practice/practice_screen.dart';
import 'package:jay2xcoder/presentation/profile/profile_screen.dart';
import 'package:jay2xcoder/presentation/progress/progress_screen.dart';
import 'package:jay2xcoder/presentation/quiz/quiz_screen.dart';
import 'package:jay2xcoder/presentation/roadmap/roadmap_screen.dart';
import 'package:jay2xcoder/presentation/settings/settings_screen.dart';
import 'package:jay2xcoder/presentation/shell/app_shell.dart';
import 'package:jay2xcoder/presentation/splash/splash_screen.dart';
import 'package:jay2xcoder/providers/app_providers.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> _rootKey = GlobalKey<NavigatorState>();

  static GoRouter buildRouter() {
    return GoRouter(
      navigatorKey: _rootKey,
      initialLocation: '/splash',
      routes: <RouteBase>[
        GoRoute(
          path: '/splash',
          name: 'splash',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildPage(const SplashScreen(), state);
          },
        ),
        GoRoute(
          path: '/onboarding',
          name: 'onboarding',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildPage(const OnboardingScreen(), state);
          },
        ),
        StatefulShellRoute.indexedStack(
          builder:
              (
                BuildContext context,
                GoRouterState state,
                StatefulNavigationShell navigationShell,
              ) {
                return AppShell(navigationShell: navigationShell);
              },
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: '/home',
                  name: 'home',
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return _buildPage(const HomeScreen(), state);
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: '/roadmap',
                  name: 'roadmap',
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return _buildPage(const RoadmapScreen(), state);
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: '/ide',
                  name: 'ide',
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return _buildPage(const PracticeScreen(), state);
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: '/progress',
                  name: 'progress',
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return _buildPage(const ProgressScreen(), state);
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: '/about',
                  name: 'about',
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return _buildPage(const ProfileScreen(), state);
                  },
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          parentNavigatorKey: _rootKey,
          path: '/ide/playground/:templateId',
          name: 'ide_playground',
          pageBuilder: (BuildContext context, GoRouterState state) {
            final String templateId = state.pathParameters['templateId'] ?? '';
            final container = ProviderScope.containerOf(context);
            final templates = container.read(codePracticeTemplatesProvider);
            final levels = container.read(levelsProvider);
            final lesson = findLessonById(levels, templateId);
            final template = templates[templateId];

            if (template == null) {
              return _buildPage(const PracticeScreen(), state);
            }

            return _buildPage(
              CodingPlaygroundScreen(
                template: template,
                lessonTitle: lesson?.title ?? context.l10n.ideTitle,
              ),
              state,
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: _rootKey,
          path: '/profile',
          name: 'profile',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildPage(const ProfileScreen(), state);
          },
        ),
        GoRoute(
          parentNavigatorKey: _rootKey,
          path: '/settings',
          name: 'settings',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildPage(const SettingsScreen(), state);
          },
        ),
        GoRoute(
          parentNavigatorKey: _rootKey,
          path: '/lesson/:lessonId',
          name: 'lesson',
          pageBuilder: (BuildContext context, GoRouterState state) {
            final String lessonId = state.pathParameters['lessonId'] ?? '';
            return _buildPage(LessonScreen(lessonId: lessonId), state);
          },
          routes: <RouteBase>[
            GoRoute(
              parentNavigatorKey: _rootKey,
              path: 'quiz',
              name: 'quiz',
              pageBuilder: (BuildContext context, GoRouterState state) {
                final String lessonId = state.pathParameters['lessonId'] ?? '';
                return _buildPage(QuizScreen(lessonId: lessonId), state);
              },
            ),
            GoRoute(
              parentNavigatorKey: _rootKey,
              path: 'practice',
              name: 'practice',
              pageBuilder: (BuildContext context, GoRouterState state) {
                final String lessonId = state.pathParameters['lessonId'] ?? '';
                return _buildPage(PracticeScreen(lessonId: lessonId), state);
              },
            ),
            GoRoute(
              parentNavigatorKey: _rootKey,
              path: 'playground',
              name: 'playground',
              pageBuilder: (BuildContext context, GoRouterState state) {
                final String lessonId = state.pathParameters['lessonId'] ?? '';
                final container = ProviderScope.containerOf(context);
                final templates = container.read(codePracticeTemplatesProvider);
                final levels = container.read(levelsProvider);
                final lesson = findLessonById(levels, lessonId);
                final template = templates[lessonId];

                if (template == null || lesson == null) {
                  return _buildPage(PracticeScreen(lessonId: lessonId), state);
                }

                return _buildPage(
                  CodingPlaygroundScreen(
                    template: template,
                    lessonTitle: lesson.title,
                    lessonId: lessonId,
                  ),
                  state,
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  static CustomTransitionPage<void> _buildPage(
    Widget child,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 320),
      reverseTransitionDuration: const Duration(milliseconds: 220),
      transitionsBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            final Animatable<Offset> offsetTween = Tween<Offset>(
              begin: const Offset(0.06, 0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeOutCubic));

            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: animation.drive(offsetTween),
                child: child,
              ),
            );
          },
    );
  }
}
