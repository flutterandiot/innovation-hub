// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

import 'package:innovation_hub/app/project/model/project_model.dart';

import '../../../app_routing.dart';
import '../provider/project_provider.dart';

class ProjectsContainer extends ConsumerWidget {
  const ProjectsContainer({
    Key? key,
    this.width,
    this.height,
    required this.gridView,
    required this.isFavarite,
  }) : super(key: key);
  final double? width;
  final double? height;
  final bool gridView;
  final bool isFavarite;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectList = ref.watch(projectsProvider);
    List<Project> projects = [];
    if (isFavarite) {
      projects = projectList.where((element) => element.favorite == true).toList();
    } else {
      projects = [...projectList];
    }
    if (projects.isEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: width ?? 240,
            height: height ?? 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Lottie.asset(
                'assets/animations/118991-idea-innovation.json',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      );
    }
    if (gridView) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          childAspectRatio: 12 / 9,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          // mainAxisExtent: 250,
        ),
        // itemExtent: 200,
        // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        // scrollDirection: Axis.horizontal,
        itemCount: projects.length,
        itemBuilder: (BuildContext context, int index) {
          return ProjectCard(
            project: projects[index],
          );
        },
      );
    }

    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 250,
          child: ProjectCard(
            project: projects[index],
          ),
        );
      },
    );
  }
}

class ProjectCard extends ConsumerWidget {
  const ProjectCard({
    super.key,
    required this.project,
  });

  final Project project;

  void _onSelectProject(BuildContext context, WidgetRef ref) {
    ref.read(activeProjectProvider.notifier).setProject(project);

    context.goNamed(
      AppRoute.projectDashboard.name,
      params: {'id': project.id},
      extra: project,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onTap: () {
          _onSelectProject(context, ref);
        },
        child: Card(
          elevation: 4,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/creative-idea-concept.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.2,
                child: Center(
                  child: Text(
                    project.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              const Text('1h ago'),
            ],
          ),
        ),
      );
    });
  }
}
