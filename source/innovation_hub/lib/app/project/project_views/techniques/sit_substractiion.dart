// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:innovation_hub/app/model/idea_model.dart';
import 'package:innovation_hub/app/project/project_views/dashboard/ideas_container.dart';
import 'package:innovation_hub/app/project/widgets/substraction/substract_idea_dialog.dart';
import 'package:innovation_hub/app/provider/idea_controller.dart';
import 'package:innovation_hub/app/provider/project_provider.dart';

import '../../../model/component_model.dart';

class SITSubstraction extends ConsumerWidget {
  const SITSubstraction({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeProject = ref.watch(activeProjectProvider);
    final components = activeProject.components;
    final isMedium = Breakpoints.medium.isActive(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 12),
          Text(
            'Select a component to generate new idea concept',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Divider(),
          //NOTE - show when in large screen
          if (!isMedium)
            LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  padding: const EdgeInsets.only(bottom: 16, top: 20),
                  height: 500,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        // width: 300,
                        width: constraints.maxWidth * 0.48,
                        child: _ComponentListContainer(
                          internal: true,
                          components: components.where((element) => element.isInternal == true).toList(),
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.48,
                        child: _ComponentListContainer(
                          internal: false,
                          components: components.where((element) => element.isInternal == false).toList(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          //NOTE - Show as a column in medium and small view
          if (isMedium)
            SizedBox(
              height: 400,
              child: _ComponentListContainer(
                internal: true,
                components: components.where((element) => element.isInternal == true).toList(),
              ),
            ),
          if (isMedium)
            SizedBox(
              height: 400,
              child: _ComponentListContainer(
                internal: false,
                components: components.where((element) => element.isInternal == false).toList(),
              ),
            ),
          //NOTE - Idea container
          const IdeasContainer(),
        ],
      ),
    );
  }
}

class _ComponentListContainer extends StatelessWidget {
  const _ComponentListContainer({
    Key? key,
    required this.components,
    required this.internal,
  }) : super(key: key);
  final List<Component> components;
  final bool internal;

  @override
  Widget build(BuildContext context) {
    final len = components.length;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      margin: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
            color: Colors.black,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ComponentListHeader(
            isInternal: internal,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: len,
              itemBuilder: (context, index) {
                final comp = components[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  child: _ComponentListTile(comp: comp),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ComponentListHeader extends StatelessWidget {
  const _ComponentListHeader({
    Key? key,
    required this.isInternal,
  }) : super(key: key);
  final bool isInternal;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceAround,
      spacing: 12,
      runSpacing: 12,
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (isInternal)
          Text(
            'Internal',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        if (!isInternal)
          Text(
            'External',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        Consumer(
          builder: (context, ref, child) {
            // final activeProject = ref.watch(activeProjectProvider);
            // List<Component> components = [];
            // if (isInternal) {
            //   components = activeProject.components.where((comp) => comp.isInternal == true).toList();
            // } else {
            //   components = activeProject.components.where((comp) => comp.isInternal == false).toList();
            // }
            return ElevatedButton.icon(
              icon: const Icon(Icons.tips_and_updates),
              label: const Text('Generate ideas'),
              onPressed: () {
                ref.read(ideaManageProvider.notifier).generateIdeasUsingSIT(SITTechniques.substraction, isInternal);
                // for (final component in components) {
                //   final idea = ref.read(ideaManageProvider.notifier).create(
                //         activeProject,
                //         component,
                //         SITTechniques.substraction,
                //       );
                //   if (idea != null) {
                //     debugPrint('🌟 Idea generared: ${idea.concept}\n');
                //   }
                // }
              },
            );
          },
        ),
      ],
    );
  }
}

class _ComponentListTile extends ConsumerWidget {
  const _ComponentListTile({
    required this.comp,
  });

  final Component comp;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ideas = ref.watch(
      activeProjectProvider.select((proj) => proj.ideas),
    );
    return Card(
      child: ExpansionTile(
        backgroundColor: Colors.amber,
        title: Text(comp.name),
        subtitle: Text(comp.description),
        trailing: SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 16,
                child: Text(
                  comp.importance.toString(),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              IconButton(
                onPressed: () async {
                  //TODO - Show Popup todos
                },
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
        ),
        // dense: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        children: [
          // Show list of ideas
          SizedBox.shrink(
            child: ListView.builder(
              itemCount: ideas.length,
              itemBuilder: (context, index) {
                final idea = ideas[index];
                return ListTile(
                  title: Text(idea.name),
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 10),
            child: ElevatedButton.icon(
              onPressed: () {
                _showAddIdea(context, comp);
              },
              icon: const Icon(
                Icons.tips_and_updates,
                color: Colors.amber,
              ),
              label: const Text('Add new idea'),
            ),
          ),
        ],
        // tileColor: comp.isInternal ? Colors.blue : Colors.amber,
      ),
    );
  }

  Future<void> _showAddIdea(BuildContext context, Component component) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: SubstractionIdeaDialog(
              component: component,
            ),
          );
        });
  }
}
