import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:harry_potter/core/connectivity/offline_banner.dart';

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
    return Scaffold(
      body: OfflineBanner(child: navigationShell),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _onTap,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.menu_book_rounded),
              label: 'Books',
            ),
            NavigationDestination(
              icon: Icon(Icons.shield_rounded),
              label: 'Houses',
            ),
            NavigationDestination(
              icon: Icon(Icons.people_alt_rounded),
              label: 'Characters',
            ),
            NavigationDestination(
              icon: Icon(Icons.auto_fix_high_rounded),
              label: 'Spells',
            ),
            NavigationDestination(
              icon: Icon(Icons.school_rounded),
              label: 'Quiz',
            ),
          ],
        ),
      ),
    );
  }
}
