import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/attribute_model.dart';
import '../../model/component_model.dart';
import 'attribute_dialog.dart';
import 'proj_constants.dart';

class AttributeCard extends HookConsumerWidget {
  const AttributeCard({
    super.key,
    required this.attr,
    required this.component,
  });

  final Attribute attr;
  final Component component;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = useState(MenuItems.edit);

    return Card(
      child: ListTile(
        enableFeedback: true,
        dense: true,
        tileColor: Theme.of(context).canvasColor,
        title: Text(attr.name),
        subtitle: Text(attr.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${attr.importance}',
              style: const TextStyle(color: Colors.red),
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
                    onTap: () async {
                      await _onEditAttribute(context, ref, component, attr);
                    },
                    child: const Text('Edit'),
                  ),
                  PopupMenuItem(
                    value: MenuItems.disable,
                    onTap: () => _onEnableToggle(context, component.id, attr),
                    child: component.enabled ? const Text('Disable') : const Text('Enable'),
                  ),
                  PopupMenuItem(
                    value: MenuItems.delete,
                    onTap: () => _onDelete(context, component.id, attr),
                    child: const Text('Delete'),
                  ),
                ];
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onEditAttribute(BuildContext context, WidgetRef ref, Component component, Attribute attribute) async {
    await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return WillPopScope(
            child: AttributeDialog(
              component: component,
              attribute: attribute,
            ),
            onWillPop: () async => false,
          );
        });
    // ref.read(activeProjectProvider.notifier).updateAttribute(component, attribute);
  }

  void _onEnableToggle(BuildContext context, String componentId, Attribute attribute) {}
  void _onDelete(BuildContext context, String componentId, Attribute attribute) {}
}
