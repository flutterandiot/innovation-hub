// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:innovation_hub/app/model/project_models.dart';
import 'package:innovation_hub/app/project/widgets/substraction_steps.dart';

import '../../../../constants.dart';
import '../../../provider/project_provider.dart';

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
            _DialogHeader(component, project),
            const SizedBox(height: 12),
            const Expanded(child: SubstractionStep()),
            const SizedBox(height: 10),
            const _DialogFooter(),
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

class _DialogHeader extends ConsumerWidget {
  const _DialogHeader(
    this.component,
    this.project,
  );
  final Component component;
  final Project project;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).disabledColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                substractionIcon,
                fit: BoxFit.contain,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Substraction',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // Idea hint
          Text.rich(
            TextSpan(
              style: DefaultTextStyle.of(context).style.copyWith(
                    fontSize: 20,
                  ),
              text: 'Image the ', // default text style
              children: [
                TextSpan(
                  text: project.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const TextSpan(
                  text: ' without the ',
                ),
                TextSpan(
                    text: component.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      decoration: TextDecoration.underline,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DialogFooter extends ConsumerWidget {
  const _DialogFooter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.cancel),
          label: const Text('Cancel'),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            //TODO - preview step
          },
          child: const Text('< Previous'),
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: () {
            //TODO - Next action
          },
          child: const Text('Next >'),
        ),
        const Spacer(),
        ElevatedButton.icon(
          onPressed: () {
            //TODO - save action
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.check),
          label: const Text('Save'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
        ),
      ],
    );
  }
}
