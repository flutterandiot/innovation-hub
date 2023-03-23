import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:innovation_hub/app/project/widgets/new_attribute.dart';

import '../model/component_model.dart';

enum MenuItems {
  edit,
  disable,
  delete,
}

class ComponentCard extends HookWidget {
  const ComponentCard({
    Key? key,
    required this.component,
    this.onEdit,
    this.onEnableToggle,
    this.onDelete,
  }) : super(key: key);
  final Component component;
  final VoidCallback? onEdit;
  final VoidCallback? onEnableToggle;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final selected = useState(MenuItems.edit);
    return Card(
      elevation: component.enabled ? 4 : 1,
      color: component.enabled ? Theme.of(context).cardColor : Theme.of(context).disabledColor,
      child: SizedBox(
        height: 300,
        width: 200,
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
                          onTap: onEdit,
                          child: const Text('Edit'),
                        ),
                        PopupMenuItem(
                          value: MenuItems.disable,
                          onTap: onEnableToggle,
                          child: component.enabled ? const Text('Disable') : const Text('Enable'),
                        ),
                        PopupMenuItem(
                          value: MenuItems.delete,
                          onTap: onDelete,
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
              const Spacer(),
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
      ),
    );
  }

  Future<void> _addAttribute(BuildContext context, Component component) async {
    await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return WillPopScope(
            child: NewAttributeDialog(component: component),
            onWillPop: () async => false,
          );
        });
  }
}
