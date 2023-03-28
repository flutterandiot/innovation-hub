import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider/project_provider.dart';

class ProjectPageHeader extends ConsumerWidget {
  const ProjectPageHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeProject = ref.watch(activeProjectProvider);
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/chair-indoor-green-lifestyle-wo-bg.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Text(
              activeProject.name,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Text(activeProject.description),
          ),
        ],
      ),
    );
  }
}
