import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../utils/app_utils.dart';
import '../../provider/project_provider.dart';

class ProjectGeneralInfo extends ConsumerWidget {
  const ProjectGeneralInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeProject = ref.watch(activeProjectProvider);
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
                    int.tryParse(activeProject.createdAt),
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
                activeProject.description,
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
                activeProject.createdBy.name,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
