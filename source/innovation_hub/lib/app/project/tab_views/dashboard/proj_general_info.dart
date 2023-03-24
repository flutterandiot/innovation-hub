import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../utils/app_utils.dart';
import '../../provider/project_provider.dart';

class ProjectGeneralInfo extends ConsumerWidget {
  const ProjectGeneralInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeProject = ref.watch(activeProjectProvider);
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      childAspectRatio: 16 / 6,
      children: [
        SizedBox(
          child: ListTile(
            title: const Text(
              'Date created',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            subtitle: Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  size: 20,
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    AppUtilities.getDateTimeFormatted(
                      AppUtilities.getTimeFromEpoch(
                        int.tryParse(activeProject.createdAt),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          title: const Text(
            'Description',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          subtitle: Text(
            activeProject.description,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        ListTile(
          title: const Text(
            'Created by',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          subtitle: Text(
            activeProject.createdBy.name,
          ),
        ),
        ListTile(
          title: const Text(
            'Team',
            style: TextStyle(color: Colors.grey),
          ),
          subtitle: Row(
            children: [
              const Icon(Icons.people),
              Text('${activeProject.team.length}'),
            ],
          ),
        ),
      ],
    );
  }
}
