import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:innovation_hub/app/project/provider/project_provider.dart';

class ProjectComponentsContainer extends ConsumerWidget {
  const ProjectComponentsContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final components = ref.watch(activeProjectProvider.select((value) => value.components));
    final internalComponent = [
      for (final comp in components)
        if (comp.isInternal) comp
    ];
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Column(
        children: [
          Text(
            'Total: ${components.length}',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text('Internal: ${internalComponent.length}'),
          Text('External: ${components.length - internalComponent.length}'),
        ],
      ),
    );
  }
}
