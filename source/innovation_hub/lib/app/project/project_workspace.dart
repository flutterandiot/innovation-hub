// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:innovation_hub/app/home/widgets/logo.dart';
import 'package:innovation_hub/app/model/idea_model.dart';

import '../../app_routing.dart';
import '../model/project_model.dart';
import '../provider/project_provider.dart';

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
      // const NavigationDestination(
      //   icon: Icon(
      //     Icons.settings_outlined,
      //     color: iconColor,
      //   ),
      //   selectedIcon: Icon(Icons.settings),
      //   label: 'Techniques',
      // ),
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
    } else {
      context.goNamed(
        AppRoute.projectComponent.name,
        params: {'id': activeProject.id},
        extra: activeProject,
      );
      // } else if (index == 2) {
      //   context.goNamed(
      //     AppRoute.projectTechnique.name,
      //     params: {'id': activeProject.id},
      //     extra: activeProject,
      //   );
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
                leading: const _PrimaryNaviLeading(),
                onDestinationSelected: (index) {
                  _selectedNavi(context, index);
                },
                trailing: const _PrimaryTrailing(),
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

class _PrimaryNaviLeading extends StatelessWidget {
  const _PrimaryNaviLeading();

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

class _PrimaryTrailing extends ConsumerWidget {
  const _PrimaryTrailing();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          Text(
            'Techniques:',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          _ProjectItemListTile(
            title: 'Task Unification',
            onTap: () {
              _gotoTechniqueScreen(
                context,
                ref,
                SITTechniques.taskUnification,
              );
            },
            centerTitle: true,
          ),
          _ProjectItemListTile(
            title: 'Substraction',
            onTap: () {
              _gotoTechniqueScreen(
                context,
                ref,
                SITTechniques.substraction,
              );
            },
            centerTitle: true,
          ),
          _ProjectItemListTile(
            title: 'Multiplication',
            onTap: () {
              _gotoTechniqueScreen(
                context,
                ref,
                SITTechniques.multiplication,
              );
            },
            centerTitle: true,
          ),
          _ProjectItemListTile(
            title: 'Division',
            onTap: () {
              _gotoTechniqueScreen(
                context,
                ref,
                SITTechniques.division,
              );
            },
            centerTitle: true,
          ),
          _ProjectItemListTile(
            title: 'Attribute Dependency',
            onTap: () {
              _gotoTechniqueScreen(
                context,
                ref,
                SITTechniques.attributeDependency,
              );
            },
            centerTitle: true,
          ),
        ],
      ),
    );
  }

  void _gotoTechniqueScreen(BuildContext context, WidgetRef ref, SITTechniques technique) {
    final activeProject = ref.watch(activeProjectProvider);
    context.goNamed(
      AppRoute.projectTechnique.name,
      params: {
        'id': activeProject.id,
        'technique': technique.name,
      },
    );
  }
}

class _ProjectItemListTile extends StatelessWidget {
  const _ProjectItemListTile({
    Key? key,
    required this.title,
    required this.onTap,
    this.centerTitle,
  }) : super(key: key);

  final String title;
  final VoidCallback? onTap;
  final bool? centerTitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      leading: centerTitle == null
          ? null
          : const SizedBox(
              child: Text('-'),
            ),
      minLeadingWidth: 2,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      hoverColor: Colors.amberAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onTap: onTap,
    );
  }
}
