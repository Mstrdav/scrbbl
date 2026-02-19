import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/search/presentation/search_screen.dart';
import '../features/training/presentation/training_screen.dart';
import '../features/score/presentation/score_screen.dart';
import '../features/settings/presentation/settings_screen.dart';

// Clé de navigation pour gérer l'état
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/search', // TODO: Rendre configurable (Settings)
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return ScaffoldWithNavBar(child: child);
        },
        routes: [
          GoRoute(
            path: '/search',
            builder: (context, state) => const SearchScreen(),
          ),
          GoRoute(
            path: '/train',
            builder: (context, state) => const TrainingScreen(),
          ),
          GoRoute(
            path: '/score',
            builder: (context, state) => const ScoreScreen(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
  );
});

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (int index) => _onItemTapped(index, context),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center), // Ou model_training
            label: 'Train',
          ),
          NavigationDestination(
            icon: Icon(Icons.scoreboard), // Ou numbers
            label: 'Score',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/search')) return 0;
    if (location.startsWith('/train')) return 1;
    if (location.startsWith('/score')) return 2;
    if (location.startsWith('/settings')) return 3;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/search');
        break;
      case 1:
        GoRouter.of(context).go('/train');
        break;
      case 2:
        GoRouter.of(context).go('/score');
        break;
      case 3:
        GoRouter.of(context).go('/settings');
        break;
    }
  }
}
