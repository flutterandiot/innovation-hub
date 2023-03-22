import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innovation_hub/utils/space.dart';

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
          title: Text(project.name),
        ),
        body: SingleChildScrollView(
          // controller: controller,
          child: Column(
            children: [
              Space.y(200),
              Text(project.name),
            ],
          ),
        ),
      ),
    );
  }
}
