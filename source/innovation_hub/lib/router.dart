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
  //NOTE - Show debug info of routing
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
      pageBuilder: (context, state, child) {
        return NoTransitionPage(
          child: HomePage(body: child),
          key: state.pageKey,
        );
      },
      routes: [
        // Dashboard
        GoRoute(
          path: '/dashboard',
          name: AppRoute.dashboard.name,
          // builder: (context, state) => const DashboardPageBody(),
          //NOTE - We use a NoTransitionPage inside the main (/dashboard, /explore,/settings) routes to prevent unintended animations when switching between destination (this is the default behavior on popular iOS apps).

          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const DashboardPageBody(),
          ),
          routes: [
            GoRoute(
              path: 'add-project',
              name: AppRoute.addProject.name,

              // builder: (context, state) => const NewProjectPage(),
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  child: const NewProjectPage(),
                  transitionsBuilder: (context, animation, secondAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.ease;
                    final tween = Tween(begin: begin, end: end).chain(
                      CurveTween(curve: curve),
                    );
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: FadeTransition(
                        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                        child: child,
                      ),
                    );
                    // return FadeTransition(
                    //   opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                    //   child: child,
                    // );
                  },
                );
              },
              // pageBuilder: (context, state) => NoTransitionPage(
              //   key: state.pageKey,
              //   child: const NewProjectPage(),
              // ),
            ),
          ],
        ),
        // Explore
        GoRoute(
          path: '/explore',
          name: AppRoute.explore.name,
          // builder: (context, state) => const ExplorePageBody(),
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const ExplorePageBody(),
          ),
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
          // builder: (context, state) => const SettingsPageBody(),
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const SettingsPageBody(),
          ),
        ),
      ],
    ),
  ],
);
