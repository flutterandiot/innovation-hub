import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innovation_hub/app/dashboard/dashboard_body.dart';
import 'package:innovation_hub/app/explore/explore_body.dart';
import 'package:innovation_hub/app/home/home_page.dart';
import 'package:innovation_hub/app/project/new_project_page.dart';
import 'package:innovation_hub/app/settings/explore_body.dart';

// GoRouter configuration
// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  dashboard,
  explore,
  settings,
  addProject,
  learnSIT,
}

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/dashboard',
  debugLogDiagnostics: true,
  routes: [
    // GoRoute(
    //   path: '/',
    //   name: 'home',
    //   builder: (context, state) => const HomePage(),
    // ),
    // GoRoute(
    //   path: 'new-project',
    //   name: 'new-project',
    //   builder: (context, state) => const NewProjectPage(),
    // ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return HomePage(body: child);
      },
      routes: [
        // Dashboard
        GoRoute(
          path: '/dashboard',
          name: AppRoute.dashboard.name,
          builder: (context, state) => const DashboardPageBody(),
          routes: [
            GoRoute(
              path: 'add-project',
              name: AppRoute.addProject.name,
              builder: (context, state) => const NewProjectPage(),
            ),
          ],
        ),
        // Explore
        GoRoute(
          path: '/explore',
          name: AppRoute.explore.name,
          builder: (context, state) => const ExplorePageBody(),
          routes: [
            GoRoute(
              path: 'learn-sit',
              name: AppRoute.learnSIT.name,
              builder: (context, state) => const NewProjectPage(),
            ),
          ],
        ),
        // Settings
        GoRoute(
          path: '/settings',
          name: AppRoute.settings.name,
          builder: (context, state) => const SettingsPageBody(),
        ),
      ],
    ),
  ],
);
