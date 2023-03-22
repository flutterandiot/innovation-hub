import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app_routing.dart';
import 'model/project_model.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({
    Key? key,
    required this.project,
  }) : super(key: key);
  final Project project;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: WillPopScope(
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
            title: Text(project.name),
            bottom: const TabBar(
              tabs: [
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
          body: const TabBarView(
            children: [
              Center(
                child: Text('Dashboard'),
              ),
              Center(
                child: Text('Components'),
              ),
              Center(
                child: Text('Techniques'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
