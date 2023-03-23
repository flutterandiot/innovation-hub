import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
    this.onDisable,
    this.onDelete,
  }) : super(key: key);
  final Component component;
  final VoidCallback? onEdit;
  final VoidCallback? onDisable;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final selected = useState(MenuItems.edit);
    return Card(
      elevation: component.enabled ? 4 : 0,
      surfaceTintColor: component.enabled ? null : Theme.of(context).disabledColor,
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
                          onTap: onDisable,
                          child: const Text('Disable'),
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
                onPressed: () {
                  //TODO - add code to add attribute for component
                },
                child: const Text('Add Attribute'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
