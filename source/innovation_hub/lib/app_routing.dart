import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innovation_hub/app/home/startup_page.dart';
import 'package:innovation_hub/app/project/project_views/prj_component_view.dart';
import 'package:innovation_hub/app/project/project_views/prj_dashboard_view.dart';

import 'package:innovation_hub/app/project/model/project_model.dart';
import 'package:innovation_hub/app/project/sit_technique_page.dart';

import 'app/project/new_project_page.dart';
import 'app/project/project_views/prj_techniques_view.dart';
import 'app/project/project_workspace.dart';

// GoRouter configuration
// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  home,
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
  initialLocation: '/',
  //NOTE - Show debug info of routing
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const StartUpPage(),
    ),

    //!Use NoTransitionPage
    //NOTE - We use a NoTransitionPage inside the main (/dashboard, /explore,/settings) routes to prevent unintended animations when switching between destination (this is the default behavior on popular iOS apps).
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(
          child: ProjectWorkspace(body: child),
          key: state.pageKey,
        );
      },
      routes: [
        GoRoute(
          path: '/add-project',
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
          path: '/:id/dashboard',
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
        ),
        GoRoute(
          path: '/:id/component',
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

        GoRoute(
          // Go to a SIT technique with 2 params
          // [id]: project Id
          // [technique]: technique name
          path: '/:id/techniques',
          name: AppRoute.projectTechnique.name,
          pageBuilder: (context, state) {
            final project = state.extra as Project;
            return CustomTransitionPage(
              child: const ProjectTechniquesView(),
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
  ],
);
