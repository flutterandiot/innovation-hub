import 'package:flutter/material.dart';

import '../widgets/project_app_bar.dart';

class ProjectTechniquesView extends StatelessWidget {
  const ProjectTechniquesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: ProjectPageAppBar(
          title: Text(
            'Project techniques',
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      body: const Center(
        child: Text('Techniques'),
      ),
    );
  }
}
