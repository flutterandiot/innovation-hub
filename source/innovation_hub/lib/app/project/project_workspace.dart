// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:innovation_hub/app/home/widgets/logo.dart';
import 'package:innovation_hub/app/model/idea_model.dart';
import 'package:innovation_hub/app/project/project_views/idea_details_page.dart';
import 'package:innovation_hub/app/project/widgets/top_navi_view.dart';
import 'package:innovation_hub/app/provider/idea_controller.dart';
import 'package:innovation_hub/constants.dart';

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
  bool isDashboardShow = true;
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

  void _selectedNavi(BuildContext context, int index, Project project) {
    if (index == 0) {
      context.goNamed(
        AppRoute.projectDashboard.name,
        params: {'id': project.id},
        extra: project,
      );
    } else {
      context.goNamed(
        AppRoute.projectComponent.name,
        params: {'id': project.id},
        extra: project,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeProject = ref.watch(activeProjectProvider);
    final activeIdea = ref.watch(ideaManageProvider);
    final currentRoute = GoRouter.of(context).location;
    if (currentRoute.contains('dashboard')) {
      isDashboardShow = true;
    } else {
      isDashboardShow = false;
    }
    debugPrint('Rebuild the project workspace');
    return Scaffold(
      body: AdaptiveLayout(
        bodyRatio: 0.5,
        primaryNavigation: SlotLayout(
          config: {
            Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key('primary-navi-medium'),
              builder: (context) => AdaptiveScaffold.standardNavigationRail(
                extended: true,
                destinations: destinations.map(AdaptiveScaffold.toRailDestination).toList(),
                leading: const _PrimaryNaviLeading(),
                onDestinationSelected: (index) {
                  _selectedNavi(context, index, activeProject);
                },
                trailing: activeProject.components.isNotEmpty ? const _PrimaryTrailing() : null,
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
        secondaryBody: (activeIdea == null || !isDashboardShow)
            ? null
            : SlotLayout(config: {
                Breakpoints.large: SlotLayout.from(
                  key: const Key('second-body-medium-n-up'),
                  // This overrides the default behavior of the secondaryBody
                  // disappearing as it is animating out.
                  outAnimation: AdaptiveScaffold.stayOnScreen,
                  builder: (context) {
                    return const IdeaDetailsPage();
                  },
                ),
              }),
        bottomNavigation: SlotLayout(
          config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.small: SlotLayout.from(
              key: const Key('Bottom Navi Small'),
              builder: (_) => BottomNavigationBarTheme(
                data: const BottomNavigationBarThemeData(backgroundColor: Colors.amber, type: BottomNavigationBarType.fixed),
                child: AdaptiveScaffold.standardBottomNavigationBar(
                  destinations: destinations,
                ),
              ),
            ),
          },
        ),
        topNavigation: SlotLayout(
          config: {
            Breakpoints.smallAndUp: SlotLayout.from(
              key: const Key('top-navi'),
              builder: (context) {
                return TopNaviView(
                  title: Text(
                    '',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                );
              },
            ),
          },
        ),
      ),
    );
  }
}

class _PrimaryNaviLeading extends ConsumerWidget {
  const _PrimaryNaviLeading();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectList = ref.watch(projectsProvider);
    Project activeProject = ref.watch(activeProjectProvider);
    if (activeProject.name.isEmpty) {
      activeProject = projectList.first;
    }
    return Column(
      children: [
        const BrandLogo(),
        DropdownButton<String>(
          hint: const Text('Select a project'),
          borderRadius: BorderRadius.circular(4),
          value: activeProject.id,
          items: projectList
              .map<DropdownMenuItem<String>>(
                (project) => DropdownMenuItem(
                  value: project.id,
                  child: Text(
                    project.name,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              )
              .toList(),
          onChanged: (selectProj) {
            if (selectProj != null) {
              final project = projectList.firstWhere((element) => element.id == selectProj);
              ref.read(activeProjectProvider.notifier).setProject(project);
              context.goNamed(
                AppRoute.projectDashboard.name,
                params: {'id': activeProject.id},
                extra: activeProject,
              );
            }
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
            image: taskUnificationIcon,
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
            image: substractionIcon,
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
            image: multiplicationIcon,
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
            image: divisionIcon,
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
            image: attributeDependencyIcon,
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
    required this.image,
  }) : super(key: key);

  final String title;
  final VoidCallback? onTap;
  final bool? centerTitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      leading: centerTitle == null
          ? null
          : Image.asset(
              image,
              fit: BoxFit.contain,
              width: 24,
              height: 24,
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
