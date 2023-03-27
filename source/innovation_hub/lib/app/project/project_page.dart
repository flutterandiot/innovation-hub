import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:innovation_hub/app/project/provider/project_provider.dart';
import 'package:innovation_hub/app/project/project_views/prj_component_view.dart';
import 'package:innovation_hub/app/project/project_views/prj_dashboard_view.dart';
import 'package:innovation_hub/app/project/project_views/prj_techniques_view.dart';

import '../../app_routing.dart';
import 'model/project_model.dart';

class ProjectPage extends ConsumerStatefulWidget {
  const ProjectPage({
    Key? key,
    required this.project,
  }) : super(key: key);
  final Project project;
  @override
  ConsumerState<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends ConsumerState<ProjectPage> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = 0;
    debugPrint('@Init: Tab selected = ${_tabController.index}');
  }

  @override
  Widget build(BuildContext context) {
    final activeProject = ref.watch(activeProjectProvider);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.goNamed(AppRoute.projects.name);
            },
            tooltip: 'Go back to project dashboard',
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(activeProject.name),
          bottom: TabBar(
            controller: _tabController,
            onTap: (index) {},
            tabs: const [
              Tab(
                text: 'Dashboard',
                icon: Icon(Icons.dashboard),
              ),
              Tab(
                text: 'Components',
                icon: Icon(Icons.category),
              ),
              Tab(
                text: 'Techniques',
                icon: Icon(Icons.settings),
              )
            ],
          ),
        ),
        body: Container(
          color: Theme.of(context).canvasColor,
          child: TabBarView(
            controller: _tabController,
            children: const [
              ProjectDashboardView(),
              ProjectComponentView(),
              ProjectTechniquesView(),
            ],
          ),
        ),
      ),
    );
  }
}
