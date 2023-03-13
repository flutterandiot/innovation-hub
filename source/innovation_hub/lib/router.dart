import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innovation_hub/app/home/home_page.dart';
import 'package:innovation_hub/app/project/new_project_page.dart';

// GoRouter configuration
// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
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
        return const HomePage();
      },
      routes: [
        GoRoute(
          path: 'new-project',
          name: 'new-project',
          builder: (context, state) => const NewProjectPage(),
        ),
      ],
    ),
  ],
);
