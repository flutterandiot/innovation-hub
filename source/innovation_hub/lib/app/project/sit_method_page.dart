// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innovation_hub/app_routing.dart';

import 'project_model.dart';

class SITMethodPage extends StatelessWidget {
  const SITMethodPage({
    Key? key,
    required this.project,
  }) : super(key: key);

  final Project project;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Apply SIT for ${project.name}'),
          leading: IconButton(
            onPressed: () {
              debugPrint('Go back to prject page');
              context.goNamed(
                AppRoute.addProject.name,
                params: {'id': project.id},
                extra: project,
              );
            },
            tooltip: 'Go back to project page',
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const [Text('Select tool')],
          ),
        ),
      ),
    );
  }
}
