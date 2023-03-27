// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:innovation_hub/app/home/widgets/logo.dart';
import 'package:innovation_hub/app/project/provider/project_provider.dart';

import '../../app_routing.dart';
import '../project/model/project_model.dart';

class ProjectWorkspace extends ConsumerStatefulWidget {
  const ProjectWorkspace({
    super.key,
    required this.body,
  });
  final Widget body;
  @override
  ConsumerState<ProjectWorkspace> createState() => _ProjectWorkspaceState();
}

class _ProjectWorkspaceState extends ConsumerState<ProjectWorkspace> {
  late final List<NavigationDestination> destinations;
  Project? activeProject;
  @override
  void initState() {
    super.initState();
    _initDestinations();
  }

  void _initDestinations() {
    // final isLight = Theme.of(context).brightness == Brightness.light;
    // final theme = Theme.of(context);
    const iconColor = Colors.amber;

    destinations = [
      const NavigationDestination(
        icon: Icon(Icons.dashboard_outlined, color: iconColor),
        selectedIcon: Icon(Icons.dashboard),
        label: 'Dashboard',
      ),
      const NavigationDestination(
        icon: Icon(Icons.category, color: iconColor),
        selectedIcon: Icon(Icons.category_rounded),
        label: 'Compoments',
      ),
      const NavigationDestination(
        icon: Icon(
          Icons.settings_outlined,
          color: iconColor,
        ),
        selectedIcon: Icon(Icons.settings),
        label: 'Techniques',
      ),
    ];
  }

  void _selectedNavi(BuildContext context, int index) {
    final activeProject = ref.watch(activeProjectProvider);
    if (index == 0) {
      context.goNamed(
        AppRoute.projectDashboard.name,
        params: {'id': activeProject.id},
        extra: activeProject,
      );
    } else if (index == 1) {
      context.goNamed(
        AppRoute.projectComponent.name,
        params: {'id': activeProject.id},
        extra: activeProject,
      );
    } else if (index == 2) {
      context.goNamed(
        AppRoute.projectTechnique.name,
        params: {'id': activeProject.id},
        extra: activeProject,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdaptiveLayout(
        primaryNavigation: SlotLayout(
          config: {
            Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key('primary-navi-medium'),
              builder: (context) => AdaptiveScaffold.standardNavigationRail(
                extended: true,
                destinations: destinations.map(AdaptiveScaffold.toRailDestination).toList(),
                leading: const PrimaryNaviLeading(),
                onDestinationSelected: (index) {
                  _selectedNavi(context, index);
                },
              ),
            ),
          },
        ),
        body: SlotLayout(
          config: {
            Breakpoints.smallAndUp: SlotLayout.from(
              key: const Key('body-small-n-up'),
              builder: (_) => widget.body,
            ),
          },
        ),
      ),
    );
  }
}

class PrimaryNaviLeading extends StatelessWidget {
  const PrimaryNaviLeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BrandLogo(),
        Consumer(
          builder: (context, ref, child) {
            final projectList = ref.watch(projectsProvider);
            Project activeProject = ref.watch(activeProjectProvider);
            if (activeProject.name.isEmpty) {
              activeProject = projectList.first;
            }
            return DropdownButton<Project>(
              hint: const Text('Select a project'),
              borderRadius: BorderRadius.circular(4),
              value: activeProject,
              items: projectList
                  .map<DropdownMenuItem<Project>>(
                    (project) => DropdownMenuItem(
                      value: project,
                      child: Text(
                        project.name,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (selectProj) {
                if (selectProj != null) {
                  ref.read(activeProjectProvider.notifier).setProject(selectProj);
                  context.goNamed(
                    AppRoute.projectDashboard.name,
                    params: {'id': activeProject.id},
                    extra: activeProject,
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}
