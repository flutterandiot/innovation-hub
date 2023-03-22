import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:innovation_hub/utils/padding.dart';
import 'package:innovation_hub/utils/space.dart';

import '../provider/project_provider.dart';

class TaskUnificationView extends HookConsumerWidget {
  const TaskUnificationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = useState<int>(0);
    final currentProject = ref.watch(projectsProvider.notifier).currentProject!;
    final internalComponents = currentProject.internalComponents;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Wrap(
                spacing: defaultPadding,
                runSpacing: defaultPadding,
                children: List.generate(
                  internalComponents.length,
                  (index) => ChoiceChip(
                    label: Text(internalComponents[index].name),
                    selected: selected.value == index,
                    onSelected: (value) {
                      if (value) {
                        selected.value = index;
                      }
                    },
                  ),
                ),
              ),
              Space.y(20),
              const TextField(
                maxLines: null,
                decoration: InputDecoration(
                  label: Text('What additional job can be assigned to this component?'),
                  hintText: 'Enter additional job',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
