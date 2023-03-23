// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:innovation_hub/app/project/model/project_models.dart';
import 'package:innovation_hub/app/project/provider/project_provider.dart';

class EditComponentDialog extends HookConsumerWidget {
  const EditComponentDialog({
    super.key,
    required this.component,
  });
  final Component component;

  dialogContent(BuildContext context, WidgetRef ref) {
    final importanceLevel = useState<int>(component.importance);
    final isInternal = useState(component.isInternal);
    final nameTextController = useTextEditingController(text: component.name);
    final descriptionTextController = useTextEditingController(text: component.description);

    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        width: constraints.maxWidth / 2,
        decoration: BoxDecoration(
          color: Colors.white,
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
                  'New Component',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Importance: ${importanceLevel.value}'),
                Slider(
                  min: 1.0,
                  max: 5.0,
                  value: importanceLevel.value.toDouble(),
                  onChanged: (value) {
                    importanceLevel.value = value.toInt();
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('External'),
                Switch.adaptive(
                  value: isInternal.value,
                  onChanged: (value) {
                    isInternal.value = value;
                  },
                ),
                const Text('Internal'),
              ],
            ),
            const SizedBox(height: 10),
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
                    final mComp = component.copyWith(
                      name: nameTextController.text,
                      importance: importanceLevel.value,
                      isInternal: isInternal.value,
                      description: descriptionTextController.text,
                    );
                    _saveComponent(context, ref, mComp);
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Save'),
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

  void _saveComponent(BuildContext context, WidgetRef ref, Component component) {
    final activeProject = ref.watch(activeProjectProvider.notifier);
    activeProject.updateComponent(component);
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
