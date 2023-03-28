// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:innovation_hub/app/model/project_models.dart';
import 'package:innovation_hub/app/project/widgets/substraction/substraction_steps.dart';

import '../../../provider/project_provider.dart';
import 'substraction_dialog_footer.dart';
import 'substraction_dialog_header.dart';

class SubstractionIdeaDialog extends HookConsumerWidget {
  const SubstractionIdeaDialog({
    super.key,
    required this.component,
  });
  final Component component;

  dialogContent(BuildContext context, WidgetRef ref) {
    final project = ref.watch(activeProjectProvider);

    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        width: constraints.maxWidth,
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
          mainAxisSize: MainAxisSize.min, // To make  compact view
          children: <Widget>[
            DialogHeader(component: component, project: project),
            const SizedBox(height: 12),
            const Expanded(child: SubstractionStep()),
            const SizedBox(height: 10),
            const DialogFooter(),
          ],
        ),
      );
    });
  }

  void _saveComponent(
    BuildContext context,
    WidgetRef ref,
    Component component,
    bool isEdit,
  ) {
    // if (isEdit) {
    //   ref.read(activeProjectProvider.notifier).updateComponent(component);
    // } else {
    //   ref.read(activeProjectProvider.notifier).addComponent(component);
    // }
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
