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

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/dashboard',
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
          name: 'dashboard',
          builder: (context, state) => const DashboardPageBody(),
          routes: [
            GoRoute(
              path: 'new-project',
              name: 'new-project',
              builder: (context, state) => const NewProjectPage(),
            ),
          ],
        ),
        // Explore
        GoRoute(
          path: '/explore',
          name: 'explore',
          builder: (context, state) => const ExplorePageBody(),
          routes: [
            GoRoute(
              path: 'learn-create-idea',
              name: 'learn-create-idea',
              builder: (context, state) => const NewProjectPage(),
            ),
          ],
        ),
        GoRoute(
          path: '/settings',
          name: 'settings',
          builder: (context, state) => const SettingsPageBody(),
        ),
      ],
    ),
  ],
);
