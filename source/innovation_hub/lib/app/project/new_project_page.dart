// ignore_for_file: public_member_api_docs, sort_constructors_first
/*
* Autogenerated header by File Header Comment extension - Donna Iwan
* File:       new_project_page.dart
* Created on: Mon Mar 13 2023
* Author:     Tong Vu Than Dan
*
* Copyright (c) 2023 ${Dantopia}
* Website:     dantopia.vn
*
* Description: show new project page
 */
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:innovation_hub/app/project/method_card.dart';
import 'package:innovation_hub/app/project/model/project_model.dart';
import 'package:innovation_hub/app/project/widgets/tool_button.dart';
import 'package:innovation_hub/app_routing.dart';
import 'package:innovation_hub/constants.dart';
import 'package:innovation_hub/utils/padding.dart';
import 'package:innovation_hub/utils/space.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewProjectPage extends HookConsumerWidget {
  const NewProjectPage({
    Key? key,
    required this.project,
  }) : super(key: key);
  final Project project;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Method selection, 0 = SIT, 1 = SIT,
    final methodSelected = useState<int>(0);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(project.name),
          leading: IconButton(
            onPressed: () {
              context.goNamed(AppRoute.dashboard.name);
            },
            tooltip: 'Go back to project dashboard',
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          // controller: controller,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3 * defaultPadding),
            child: Column(
              children: [
                Space.y(40),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Project description',
                    hintText: 'Describe current situation, problem,...',
                  ),
                ),
                Space.y(20),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 2 * defaultPadding, bottom: defaultPadding),
                  child: Text(
                    'Choose a method',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Wrap(
                  runSpacing: 2 * defaultPadding,
                  children: [
                    MethodCard(
                      title: 'SIT',
                      subtitle: 'Systematic Inventive Thinking',
                      useCase: 'Best for generate inventive ideas',
                      backgroundColor: methodSelected.value == sitMethodIndex ? Colors.amber : Theme.of(context).unselectedWidgetColor,
                      tooltip: sitTooltip,
                      elevation: methodSelected.value == sitMethodIndex ? defaultPadding : 0.0,
                      onTap: () {
                        methodSelected.value = sitMethodIndex;
                      },
                    ),
                    Space.x(defaultPadding),
                    MethodCard(
                      title: 'TRIZ',
                      subtitle: 'Theory of Inventive Problem Solving',
                      useCase: 'Best for problem solving',
                      backgroundColor: methodSelected.value == trizMethodIndex ? Colors.blue : Theme.of(context).unselectedWidgetColor,
                      tooltip: trizTooltip,
                      elevation: methodSelected.value == trizMethodIndex ? defaultPadding : 0.0,
                      onTap: () {
                        methodSelected.value = trizMethodIndex;
                      },
                    ),
                  ],
                ),
                //SIT Tools
                if (methodSelected.value == sitMethodIndex)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                if (methodSelected.value == sitMethodIndex)
                  Wrap(
                    spacing: defaultPadding,
                    runSpacing: defaultPadding,
                    children: [
                      SitToolButton(
                        backgroundColor: Colors.amber,
                        icon: const FaIcon(FontAwesomeIcons.plus),
                        title: 'Task Unification',
                        onTap: () {
                          final technique = AppRoute.sitTaskUnification.name.replaceAll('sit', '');
                          _goToTechnique(context, ref, technique);
                        },
                      ),
                      SitToolButton(
                        backgroundColor: Colors.orange,
                        icon: const FaIcon(FontAwesomeIcons.minus),
                        title: 'Substraction',
                        onTap: () {
                          final technique = AppRoute.sitSubstraction.name.replaceAll('sit', '');
                          _goToTechnique(context, ref, technique);
                        },
                      ),
                      SitToolButton(
                        backgroundColor: Colors.blue,
                        icon: const FaIcon(FontAwesomeIcons.xmark),
                        title: 'Multiplication',
                        onTap: () {
                          final technique = AppRoute.sitMultiplication.name.replaceAll('sit', '');
                          _goToTechnique(context, ref, technique);
                        },
                      ),
                      SitToolButton(
                        backgroundColor: Colors.teal,
                        icon: const FaIcon(FontAwesomeIcons.divide),
                        title: 'Division',
                        onTap: () {
                          final technique = AppRoute.sitDivision.name.replaceAll('sit', '');
                          _goToTechnique(context, ref, technique);
                        },
                      ),
                      SitToolButton(
                        backgroundColor: Colors.green,
                        icon: const FaIcon(FontAwesomeIcons.link),
                        title: 'Attribute Dependency',
                        onTap: () {
                          final technique = AppRoute.sitAttributeDependency.name.replaceAll('sit', '');
                          _goToTechnique(context, ref, technique);
                        },
                      ),
                    ],
                  ),

                if (methodSelected.value == trizMethodIndex)
                  SizedBox(
                    height: 200,
                    child: Center(
                      child: Text(
                        'TRIZ method will be updated in next version',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _goToTechnique(BuildContext context, WidgetRef ref, String technique) {
    context.goNamed(
      AppRoute.sitTechnique.name,
      params: {
        'id': project.id,
        'technique': technique,
      },
      extra: project,
    );
  }
}
