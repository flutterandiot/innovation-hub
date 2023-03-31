import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:innovation_hub/app_routing.dart';

import '../../../provider/project_provider.dart';

class ProjectComponentsContainer extends ConsumerWidget {
  const ProjectComponentsContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final components = ref.watch(activeProjectProvider.select((value) => value.components));

    if (components.isEmpty) {
      return SizedBox(
        height: 400,
        child: Center(
          child: TextButton.icon(
            icon: const Icon(Icons.add),
            onPressed: () {
              final activeProject = ref.read(activeProjectProvider);
              context.goNamed(
                AppRoute.projectComponent.name,
                params: {'id': activeProject.id},
                extra: activeProject,
              );
            },
            label: const Text('Add component'),
          ),
        ),
      );
    }

    final internalComponent = [
      for (final comp in components)
        if (comp.isInternal) comp
    ];
    return Container(
      height: 400,
      margin: const EdgeInsets.only(left: 8, right: 8),
      padding: const EdgeInsets.only(left: 8, right: 8),
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
