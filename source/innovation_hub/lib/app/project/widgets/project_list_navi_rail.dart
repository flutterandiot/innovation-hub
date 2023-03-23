import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:innovation_hub/app_routing.dart';

import '../../../utils/space.dart';
import '../model/project_model.dart';
import '../provider/project_provider.dart';

class ProjectListNaviRail extends ConsumerWidget {
  const ProjectListNaviRail({
    super.key,
    required this.projectList,
  });

  final List<Project> projectList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const Divider(thickness: 1.5),
        Space.y(20),
        Row(
          children: <Widget>[
            const SizedBox(width: 22),
            Text('Projects', style: TextStyle(fontSize: 13, color: Colors.grey[700])),
          ],
        ),
        Space.y(20),
        Expanded(
          child: ListView.builder(
            itemCount: projectList.length,
            itemBuilder: (context, index) {
              return ListTile(
                dense: true,
                leading: Text('${index + 1}. '),
                title: Text(projectList[index].name),
                onTap: () {
                  ref.read(activeProjectProvider.notifier).setProject(projectList[index]);
                  context.goNamed(
                    AppRoute.projectPage.name,
                    params: {'id': projectList[index].id},
                    extra: projectList[index],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
