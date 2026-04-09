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

    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: SafeArea(
        top: false,
        minimum: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Container(
          decoration: BoxDecoration(
            color: ReferencePalette.card(context).withValues(alpha: 0.97),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: ReferencePalette.cardBorder(context)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: theme.brightness == Brightness.dark ? 0.24 : 0.08,
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
