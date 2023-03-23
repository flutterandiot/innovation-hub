import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:innovation_hub/app/project/model/project_models.dart';
import 'package:innovation_hub/app/project/provider/project_provider.dart';
import 'package:innovation_hub/utils/app_utils.dart';

class NewComponentDialog extends HookConsumerWidget {
  const NewComponentDialog({super.key});

  dialogContent(BuildContext context, WidgetRef ref) {
    final importanceLevel = useState<int>(1);
    final isInternal = useState(true);
    final nameTextController = useTextEditingController(text: 'Component');
    final descriptionTextController = useTextEditingController(text: 'This component...');

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
                    Navigator.of(context).pop();
                    final component = Component(
                      id: AppUtilities.getUid(),
                      name: nameTextController.text,
                      importance: importanceLevel.value,
                      isInternal: isInternal.value,
                      description: descriptionTextController.text,
                      attributes: [],
                    );
                    _saveComponent(context, ref, component);
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
    activeProject.addComponentList(component);
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
