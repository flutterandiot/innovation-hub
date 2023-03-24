// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:innovation_hub/app_routing.dart';

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
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        const Divider(thickness: 1.5),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: <Widget>[
            const SizedBox(width: 22),
            Text('Projects', style: TextStyle(fontSize: 13, color: Colors.grey[700])),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: projectList.length,
            itemBuilder: (context, index) {
              return ExpansionTile(
                // backgroundColor: Colors.amber,
                tilePadding: const EdgeInsets.only(right: 4),
                expandedCrossAxisAlignment: CrossAxisAlignment.end,
                leading: Text('${index + 1}. '),
                title: Text(projectList[index].name),
                onExpansionChanged: (_) {
                  ref.read(activeProjectProvider.notifier).setProject(projectList[index]);
                  context.goNamed(
                    AppRoute.projectDashboard.name,
                    params: {'id': projectList[index].id},
                    extra: projectList[index],
                  );
                },
                children: [
                  ProjectItemListTile(
                    title: 'Dashboard',
                    onTap: () {
                      ref.read(showSecondaryBodyProvider.notifier).enableShowSecondaryBody(true);

                      context.goNamed(
                        AppRoute.projectDashboard.name,
                        params: {'id': projectList[index].id},
                      );
                    },
                  ),
                  ProjectItemListTile(
                    title: 'Components',
                    onTap: () {
                      ref.read(showSecondaryBodyProvider.notifier).enableShowSecondaryBody(true);

                      context.goNamed(
                        AppRoute.projectComponent.name,
                        params: {'id': projectList[index].id},
                        extra: projectList[index],
                      );
                    },
                  ),
                  ProjectItemListTile(
                    title: 'Task Unification',
                    onTap: () {},
                    isTitleCenter: true,
                  ),
                  ProjectItemListTile(
                    title: 'Substraction',
                    onTap: () {},
                    isTitleCenter: true,
                  ),
                  ProjectItemListTile(
                    title: 'Multiplication',
                    onTap: () {},
                    isTitleCenter: true,
                  ),
                  ProjectItemListTile(
                    title: 'Division',
                    onTap: () {},
                    isTitleCenter: true,
                  ),
                  ProjectItemListTile(
                    title: 'Attribute Dependency',
                    onTap: () {},
                    isTitleCenter: true,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class ProjectItemListTile extends StatelessWidget {
  const ProjectItemListTile({
    Key? key,
    required this.title,
    required this.onTap,
    this.isTitleCenter,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;
  final bool? isTitleCenter;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        dense: true,
        visualDensity: VisualDensity.compact,
        leading: isTitleCenter == null
            ? null
            : const SizedBox(
                child: Text('-'),
              ),
        minLeadingWidth: 2,
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        hoverColor: Colors.amberAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onTap: onTap);
  }
}
