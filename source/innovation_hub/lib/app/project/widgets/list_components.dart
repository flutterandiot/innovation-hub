import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:innovation_hub/app/project/provider/project_provider.dart';
import 'package:innovation_hub/utils/space.dart';

class ListComponents extends HookConsumerWidget {
  const ListComponents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentProject = ref.watch(projectsProvider.notifier).currentProject;
    final textController = useTextEditingController(text: '');
    textController.text = currentProject!.internalComponents!.join(',');
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: constraints.maxWidth * 0.2,
        ),
        child: Column(
          children: [
            TextField(
              controller: textController,
              maxLines: null,
              decoration: const InputDecoration(
                labelText: 'List all internal components',
              ),
              onTapOutside: (event) {
                final inputValue = textController.text;

                final components = inputValue.split(',');

                if (components.isNotEmpty) {
                  for (final component in components) {
                    //remove all  space
                    final mComp = component.replaceAll(' ', '');
                    if (!currentProject.internalComponents!.contains(mComp) && mComp.isNotEmpty) {
                      currentProject.internalComponents!.add(mComp);
                    }
                  }
                }
              },
            ),
            const Text(
              'Make a list of the internal components (generally, the things attached or directly part of the product, process, or service); separate component by a comma',
            ),
            Space.y(32),
            const TextField(
              decoration: InputDecoration(
                labelText: 'List all external components',
              ),
            ),
            const Text(
              'external components (those in the immediate vicinity - within the closed world); separate component by a comma',
              textAlign: TextAlign.start,
            ),
          ],
        ),
      );
    });
  }
}
