// ignore_for_file: use_build_context_synchronously

/*
* Autogenerated header by File Header Comment extension - Donna Iwan
* File:       empty_project_body.dart
* Created on: Mon Mar 13 2023
* Author:     Tong Vu Than Dan
*
* Copyright (c) 2023 Dantopia
* Website:     dantopia.vn
*
* Description: This file is the home page of the app, show all projects
 */
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innovation_hub/app/project/provider/project_provider.dart';
import 'package:innovation_hub/app/project/widgets/new_project_dialog.dart';
import 'package:innovation_hub/utils/padding.dart';
import 'package:lottie/lottie.dart';

import '../../app_routing.dart';

class ProjectsHomePageBody extends ConsumerWidget {
  const ProjectsHomePageBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isSmallActivie = Breakpoints.small.isActive(context);
    final projects = ref.watch(projectsProvider);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.only(left: 4 * defaultPadding, right: 2 * defaultPadding, top: 4 * defaultPadding),
          color: Theme.of(context).scaffoldBackgroundColor,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 48,
                ),
                Text(
                  'Welcome back innovator,',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  'time to innovate!',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 32,
                    bottom: 24,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'My projects',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        onPressed: () {
                          _showNewProjectDialog(context);
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('New project'),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  indent: 24,
                  endIndent: 24,
                ),
                if (projects.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: ListView.builder(
                      itemExtent: 200,
                      padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding),
                      scrollDirection: Axis.horizontal,
                      itemCount: projects.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
                          // width: 250,
                          height: 180,
                          child: Material(
                            color: Colors.amberAccent,
                            borderRadius: BorderRadius.circular(defaultPadding),
                            child: InkWell(
                              onTap: () {
                                context.goNamed(
                                  AppRoute.projectPage.name,
                                  params: {'id': projects[index].id},
                                  extra: projects[index],
                                );
                              },
                              child: Center(
                                child: Text(projects[index].name),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                if (projects.isEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * 0.3,
                        height: constraints.maxHeight * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Lottie.asset(
                            'assets/animations/118991-idea-innovation.json',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

/*
  Future<String?> _showNewProjectDialog(BuildContext context, WidgetRef ref) async {
    final results = await showTextInputDialog(
      context: context,
      title: 'New project',
      message: 'Please enter project name and description to continue',
      textFields: [
        DialogTextField(
          initialText: 'ProjectA',
          hintText: 'Input your project name',
          validator: (value) => value!.isEmpty ? 'Input more than one character' : null,
        ),
        DialogTextField(
          initialText: 'This project is',
          hintText: 'Input description of your new project',
          validator: (value) => value!.isEmpty ? 'Input more than one character' : null,
        ),
      ],
      okLabel: 'Create a New Project',
      cancelLabel: 'Cancel',
    );
    if (results != null && results.isNotEmpty) {
      debugPrint('Results: ${results[0]}');
      //NOTE - Create project if the project name is not empty
      final project = Project();
      project.name = results.first;
      project.description = results.last;
      project.id = UniqueKey().toString().replaceAll('#', '').replaceAll('[', '').replaceAll(']', '');
      project.internalComponents = [];
      project.externalComponents = [];
      //Save project to project list
      ref.read(projectsProvider).add(project);
      //NOTE: Save this new created project as a current ont
      ref.read(projectsProvider.notifier).setCurrentProject(project);

      context.goNamed(
        AppRoute.addProject.name,
        extra: project,
      );
      return results.first;
    } else {
      return null;
    }
  }
*/
  void _showNewProjectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: const NewProjectDialog(),
        );
      },
    );
  }
}
