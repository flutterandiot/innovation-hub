import 'package:flutter/material.dart';

import '../../../utils/space.dart';
import '../model/project_model.dart';

class ProjectListNaviRail extends StatelessWidget {
  const ProjectListNaviRail({
    super.key,
    required this.projectList,
  });

  final List<Project> projectList;

  @override
  Widget build(BuildContext context) {
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
                  //TODO - add action for project listtile
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
