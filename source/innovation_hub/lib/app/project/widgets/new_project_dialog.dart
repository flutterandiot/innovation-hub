import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:innovation_hub/app/project/provider/project_provider.dart';
import 'package:innovation_hub/app/shared/user.dart';

import '../../../utils/app_utils.dart';
import '../model/project_model.dart';

class NewProjectDialog extends HookConsumerWidget {
  const NewProjectDialog({super.key});

  dialogContent(BuildContext context, WidgetRef ref) {
    final selected = useState<ProjectType>(ProjectType.product);
    final nameTextController = useTextEditingController(text: 'Project');
    final descriptionTextController = useTextEditingController(text: 'This project ...');
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        width: constraints.maxWidth / 2,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // To make the card compact
          children: <Widget>[
            Row(
              children: [
                Text(
                  'New Project',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: nameTextController,
              decoration: const InputDecoration(
                label: Text('Name'),
              ),
              validator: (value) {
                value!.isEmpty ? 'Please enter name' : null;
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: descriptionTextController,
              decoration: const InputDecoration(
                label: Text('Description'),
              ),
              validator: (value) {
                value!.isEmpty ? 'Please enter description' : null;
                return null;
              },
            ),
            const SizedBox(height: 24.0),
            const Text('Project type:'),
            RadioListTile(
              groupValue: selected.value,
              title: const Text('Product'),
              value: ProjectType.product,
              onChanged: (value) {
                selected.value = value!;
              },
            ),
            RadioListTile(
              groupValue: selected.value,
              title: const Text('Service'),
              value: ProjectType.service,
              onChanged: (value) {
                selected.value = value!;
              },
            ),
            RadioListTile(
              groupValue: selected.value,
              title: const Text('Other'),
              value: ProjectType.other,
              onChanged: (value) {
                selected.value = value!;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.cancel),
                  label: const Text('Cancel'),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    final _ = _saveNewProject(
                      ref,
                      nameTextController.text,
                      descriptionTextController.text,
                      selected.value,
                    );
                    Navigator.of(context).pop();
                    // context.goNamed(
                    //   AppRoute.addProject.name,
                    //   extra: project,
                    // );
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Create a New Project'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Project _saveNewProject(WidgetRef ref, String name, String description, ProjectType type) {
    //NOTE - Create new project
    final project = Project(
      id: AppUtilities.getUid(),
      name: name,
      description: description,
      type: type.name,
      externalComponents: [],
      internalComponents: [],
      createdAt: AppUtilities.getTimeStampFromNow(),
      createdBy: User.dummyUser,
      team: [
        User.dummyUser,
      ],
    );

    //Save project to project list
    ref.read(projectsProvider.notifier).addProject(project);
    //NOTE: Save this new created project as a current ont
    ref.read(projectsProvider.notifier).setCurrentProject(project);
    debugPrint(project.toString());

    return project;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context, ref),
    );
  }
}
