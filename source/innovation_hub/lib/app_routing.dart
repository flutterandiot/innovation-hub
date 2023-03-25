import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innovation_hub/app/home/startup_page.dart';
import 'package:innovation_hub/app/project/tab_views/prj_component_view.dart';
import 'package:innovation_hub/app/project/tab_views/prj_dashboard_view.dart';
import 'package:innovation_hub/app/projects/projects_home_body.dart';
import 'package:innovation_hub/app/explore/explore_body.dart';
import 'package:innovation_hub/app/explore/study_sit_page.dart';
import 'package:innovation_hub/app/home/home_page.dart';
import 'package:innovation_hub/app/project/new_project_page.dart';
import 'package:innovation_hub/app/project/model/project_model.dart';
import 'package:innovation_hub/app/project/sit_technique_page.dart';
import 'package:innovation_hub/app/settings/settings_body.dart';

// GoRouter configuration
// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  projects,
  explore,
  settings,
  addProject,
  learnSIT,
  sitTechnique,
  sitTaskUnification,
  sitSubstraction,
  sitMultiplication,
  sitDivision,
  sitAttributeDependency,
  trizMethod,
  projectPage,
  projectDashboard,
  projectComponent,
  projectTechnique,
}

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
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
          child: const StartUpPage(),
          // child: HomePage(body: child),
          key: state.pageKey,
        );
      },
      routes: [
        // Dashboard
        GoRoute(
          path: '/home',
          name: AppRoute.projects.name,
          //NOTE - this builder will use default animation, which cause unintended animation when switching between destinations, we we don't use this builder
          // builder: (context, state) => const DashboardPageBody(),
          //!Use NoTransitionPage
          //NOTE - We use a NoTransitionPage inside the main (/dashboard, /explore,/settings) routes to prevent unintended animations when switching between destination (this is the default behavior on popular iOS apps).

          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const ProjectsHomePageBody(),
          ),
          routes: [
            GoRoute(
              path: 'add-project',
              name: AppRoute.addProject.name,
              // builder: (context, state) => const NewProjectPage(),
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  child: NewProjectPage(
                    project: state.extra as Project,
                  ),
                  transitionsBuilder: (context, animation, secondAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.ease;
                    final tween = Tween(begin: begin, end: end).chain(
                      CurveTween(curve: curve),
                    );
                    return SlideTransition(
                      position: animation.drive(tween),
                      // child: child,
                      child: FadeTransition(
                        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                        child: child,
                      ),
                    );
                  },
                );
              },
            ),
            //NOTE: Go to project page
            GoRoute(
              path: ':id',
              name: AppRoute.projectDashboard.name,
              pageBuilder: (context, state) {
                // final project = state.extra as Project;
                return CustomTransitionPage(
                  child: const ProjectDashboardView(
                      // project: project,
                      ),
                  transitionsBuilder: (context, animation, secondAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.ease;
                    final tween = Tween(begin: begin, end: end).chain(
                      CurveTween(curve: curve),
                    );
                    return SlideTransition(
                      position: animation.drive(tween),
                      // child: child,
                      child: FadeTransition(
                        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                        child: child,
                      ),
                    );
                  },
                );
              },
              routes: [
                GoRoute(
                  path: 'component',
                  name: AppRoute.projectComponent.name,
                  pageBuilder: (context, state) {
                    // final project = state.extra as Project;
                    return CustomTransitionPage(
                      child: const ProjectComponentView(),
                      transitionsBuilder: (context, animation, secondAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;
                        final tween = Tween(begin: begin, end: end).chain(
                          CurveTween(curve: curve),
                        );
                        return SlideTransition(
                          position: animation.drive(tween),
                          // child: child,
                          child: FadeTransition(
                            opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                            child: child,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              // Go to a SIT technique with 2 params
              // [id]: project Id
              // [technique]: technique name
              path: ':id/:technique',
              name: AppRoute.sitTechnique.name,
              pageBuilder: (context, state) {
                final project = state.extra as Project;
                return CustomTransitionPage(
                  child: SitTechniquePage(
                    project: project,
                  ),
                  transitionsBuilder: (context, animation, secondAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.ease;
                    final tween = Tween(begin: begin, end: end).chain(
                      CurveTween(curve: curve),
                    );
                    return SlideTransition(
                      position: animation.drive(tween),
                      // child: child,
                      child: FadeTransition(
                        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                        child: child,
                      ),
                    );
                  },
                );
              },
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
              builder: (context, state) => const StudySITPage(),
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
