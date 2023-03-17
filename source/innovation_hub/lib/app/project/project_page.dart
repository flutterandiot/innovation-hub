// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:innovation_hub/utils/space.dart';

import 'model/project_model.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({
    Key? key,
    required this.project,
  }) : super(key: key);
  final Project project;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
    );
  }
}
