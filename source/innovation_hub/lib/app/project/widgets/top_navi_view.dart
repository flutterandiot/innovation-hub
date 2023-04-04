import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/app_utils.dart';
import '../../provider/project_provider.dart';

class TopNaviView extends ConsumerWidget {
  const TopNaviView({
    Key? key,
    required this.title,
  }) : super(key: key);

  final Widget title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeProject = ref.watch(activeProjectProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 72,
      child: Row(
        children: [
          title,
          const Spacer(),

          Tooltip(
            message: 'Created at ${AppUtilities.getDateTimeFormatted(
              AppUtilities.getTimeFromEpoch(
                int.tryParse(activeProject.createdAt),
              ),
            )} by ${activeProject.createdBy.name}\nUpdated at ${AppUtilities.getDateTimeFormatted(
              AppUtilities.getTimeFromEpoch(
                int.tryParse(activeProject.updatedAt),
              ),
            )} by ${activeProject.createdBy.name}',
            child: Text(
              'Updated at ${AppUtilities.getDateTimeFormatted(
                AppUtilities.getTimeFromEpoch(
                  int.tryParse(activeProject.updatedAt),
                ),
              )}',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ),
          // NOTE - Write a post a show how to create a team list
          if (activeProject.team.length >= 2)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 32.0 * activeProject.team.length.toDouble(),
                  maxHeight: 100,
                ),
                child: Stack(
                  children: List.generate(
                    activeProject.team.length,
                    (index) => Positioned(
                      right: index * 20,
                      child: Tooltip(
                        message: activeProject.team[index].name,
                        child: CircleAvatar(
                          backgroundColor: index % 2 == 0 ? Colors.amber : Colors.blue,
                          backgroundImage: activeProject.team[index].avatar.isNotEmpty ? NetworkImage(activeProject.team[index].avatar) : null,
                          radius: 16,
                          child: activeProject.team[index].avatar.isEmpty ? const Icon(Icons.person) : null,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
