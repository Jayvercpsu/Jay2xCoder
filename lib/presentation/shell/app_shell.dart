import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:jay2xcoder/presentation/shared/widgets/reference_kit.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final bool ideMode = navigationShell.currentIndex == 2;
    final bool hideChrome = landscape || ideMode;

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: <Widget>[
          navigationShell,
          if (!hideChrome)
            Positioned(
              top: 10,
              right: 12,
              child: SafeArea(
                bottom: false,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => context.push('/settings'),
                    borderRadius: BorderRadius.circular(14),
                    child: Ink(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: ReferencePalette.card(
                          context,
                        ).withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: ReferencePalette.cardBorder(context),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withValues(
                              alpha: theme.brightness == Brightness.dark
                                  ? 0.22
                                  : 0.08,
                            ),
                            blurRadius: 12,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Icon(
                        LucideIcons.settings,
                        size: 19,
                        color: ReferencePalette.onSurface(context),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: hideChrome
          ? null
          : SafeArea(
              top: false,
              minimum: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Container(
                decoration: BoxDecoration(
                  color: ReferencePalette.card(context).withValues(alpha: 0.97),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: ReferencePalette.cardBorder(context),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: theme.brightness == Brightness.dark
                            ? 0.24
                            : 0.08,
                      ),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: NavigationBar(
                    selectedIndex: navigationShell.currentIndex,
                    onDestinationSelected: _onTap,
                    backgroundColor: Colors.transparent,
                    destinations: const <NavigationDestination>[
                      NavigationDestination(
                        icon: Icon(LucideIcons.home),
                        selectedIcon: Icon(LucideIcons.home),
                        label: 'Home',
                      ),
                      NavigationDestination(
                        icon: Icon(LucideIcons.bookOpen),
                        selectedIcon: Icon(LucideIcons.bookOpen),
                        label: 'Lessons',
                      ),
                      NavigationDestination(
                        icon: Icon(LucideIcons.squareCode),
                        selectedIcon: Icon(LucideIcons.squareCode),
                        label: 'Practice',
                      ),
                      NavigationDestination(
                        icon: Icon(LucideIcons.pieChart),
                        selectedIcon: Icon(LucideIcons.pieChart),
                        label: 'Progress',
                      ),
                      NavigationDestination(
                        icon: Icon(LucideIcons.userCircle),
                        selectedIcon: Icon(LucideIcons.userCircle),
                        label: 'About',
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
