import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:innovation_hub/app/project/provider/project_provider.dart';
import 'package:innovation_hub/utils/app_utils.dart';

class ProjectDashboardView extends StatelessWidget {
  const ProjectDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmall = Breakpoints.small.isActive(context);
    final isMedium = Breakpoints.medium.isActive(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        if (isSmall || isMedium) {
          return ListView(
            padding: const EdgeInsets.only(
              top: 48,
              left: 32,
              right: 32,
            ),
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.3,
                // width: constraints.maxWidth * 0.85,
                child: const _ProjectGeneralInfo(),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.3,
                // width: constraints.maxWidth * 0.85,
                child: Image.asset(
                  'assets/images/chair-indoor-green-lifestyle-wo-bg.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: constraints.maxHeight * 0.3,
                // width: constraints.maxWidth * 0.85,
                child: const Placeholder(
                  child: Text('Project components'),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: constraints.maxHeight * 0.3,
                // width: constraints.maxWidth * 0.85,
                child: const Placeholder(
                  child: Text('component attributes'),
                ),
              ),
            ],
          );
        }
        return GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.only(
            top: 48,
            left: 32,
            right: 32,
          ),
          children: [
            SizedBox(
              height: constraints.maxHeight * 0.3,
              // width: constraints.maxWidth * 0.85,
              child: const _ProjectGeneralInfo(),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.3,
              // width: constraints.maxWidth * 0.85,
              child: Image.asset(
                'assets/images/chair-indoor-green-lifestyle-wo-bg.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.3,
              // width: constraints.maxWidth * 0.85,
              child: const Placeholder(
                child: Text('Project components'),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.3,
              // width: constraints.maxWidth * 0.85,
              child: const Placeholder(
                child: Text('component attributes'),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ProjectGeneralInfo extends ConsumerWidget {
  const _ProjectGeneralInfo();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentProject = ref.watch(projectsProvider.notifier).currentProject!;

    return Wrap(
      runSpacing: 24,
      spacing: 24,
      children: [
        SizedBox(
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Date created',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                AppUtilities.getDateTimeFormatted(
                  AppUtilities.getTimeFromEpoch(
                    int.tryParse(currentProject.createdAt),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Description',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                currentProject.description,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Created by',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                currentProject.createdBy.name,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
