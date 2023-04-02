import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:innovation_hub/app/project/widgets/dialogs/attribute_dialog.dart';

import '../../model/component_model.dart';
import '../../provider/project_provider.dart';
import 'attribute_card.dart';
import 'dialogs/component_dialog.dart';
import 'delete_comp_confirm_dialog.dart';
import 'proj_constants.dart';

class ComponentCard extends HookConsumerWidget {
  const ComponentCard({
    Key? key,
    required this.component,
  }) : super(key: key);
  final Component component;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = useState(MenuItems.edit);

    final attributesList = component.attributes;
    return Card(
      elevation: component.enabled ? 4 : 1,
      color: component.enabled ? Theme.of(context).cardColor : Theme.of(context).disabledColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    component.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                //!Popup menu
                PopupMenuButton<MenuItems>(
                  initialValue: selected.value,
                  onSelected: (value) {
                    selected.value = value;
                  },
                  itemBuilder: (context) {
                    return <PopupMenuEntry<MenuItems>>[
                      PopupMenuItem(
                        value: MenuItems.edit,
                        onTap: () async {
                          await _showEditComponent(context, component);
                        },
                        child: const Text('Edit'),
                      ),
                      PopupMenuItem(
                        value: MenuItems.disable,
                        onTap: () {
                          _enableToggle(ref, component);
                        },
                        child: component.enabled ? const Text('Disable') : const Text('Enable'),
                      ),
                      PopupMenuItem(
                        value: MenuItems.delete,
                        onTap: () async {
                          await _showDeleteComponentConfirmDialog(context, ref, component);
                        },
                        child: const Text('Delete'),
                      ),
                    ];
                  },
                ),
              ],
            ),
            if (!component.enabled) const Text('Disable'),
            Row(
              children: [
                if (component.isInternal)
                  const Text(
                    'Internal',
                    style: TextStyle(color: Colors.blue),
                  ),
                if (!component.isInternal)
                  const Text(
                    'External',
                    style: TextStyle(color: Colors.orange),
                  ),
                const Spacer(),
                CircleAvatar(
                  child: Text('${component.importance}'),
                ),
              ],
            ),
            const Divider(),
            //NOTE - show Atttribute list
            if (attributesList.isNotEmpty)
              Expanded(
                child: ListView.separated(
                  clipBehavior: Clip.antiAlias,
                  itemCount: attributesList.length,
                  itemBuilder: (context, index) {
                    final attr = attributesList[index];
                    return AttributeCard(
                      attr: attr,
                      component: component,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                ),
              ),
            if (attributesList.isEmpty) const Spacer(),
            ElevatedButton(
              onPressed: component.enabled
                  ? () async {
                      await _addAttribute(context, component);
                    }
                  : null,
              child: const Text('Add Attribute'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showEditComponent(BuildContext context, Component component) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: ComponentDialog(
              component: component,
            ),
          );
        });
  }

  Future<void> _showDeleteComponentConfirmDialog(BuildContext context, WidgetRef ref, Component component) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: DeleteComponentCofirmDialog(
            onDelete: () {
              ref.read(activeProjectProvider.notifier).deleteComponentFromProject(component);
            },
          ),
        );
      },
    );
  }

  void _enableToggle(WidgetRef ref, Component component) {
    ref.read(activeProjectProvider.notifier).componentEnableToggle(component);
  }

  Future<void> _addAttribute(BuildContext context, Component component) async {
    await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return WillPopScope(
            child: AttributeDialog(component: component),
            onWillPop: () async => false,
          );
        });
  }
}
