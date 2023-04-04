import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innovation_hub/app/home/startup_page.dart';
import 'package:innovation_hub/app/model/idea_model.dart';
import 'package:innovation_hub/app/project/project_views/idea_details_page.dart';
import 'package:innovation_hub/app/project/project_views/prj_component_view.dart';
import 'package:innovation_hub/app/project/project_views/prj_dashboard_view.dart';
import 'package:innovation_hub/app/project/project_views/techniques/technique_page.dart';

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
  ideaPage,
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
          path: '/:id/ideas/:ideaId',
          name: AppRoute.ideaPage.name,
          pageBuilder: (context, state) {
            // final idea = state.extra as Idea;
            return CustomTransitionPage(
              child: const IdeaDetailsPage(),
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
          path: '/:id/techniques/:technique',
          name: AppRoute.projectTechnique.name,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: TechniquePage(
                technique: SITTechniques.values.byName(
                  state.params['technique']!,
                ),
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
  ],
);
