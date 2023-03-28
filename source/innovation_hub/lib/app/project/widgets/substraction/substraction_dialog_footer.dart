import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:innovation_hub/app/project/widgets/substraction/substraction_steps.dart';
import 'package:innovation_hub/app/provider/step_provider.dart';

class DialogFooter extends ConsumerWidget {
  const DialogFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(currentStepProvider);
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
          onPressed: currentStep <= 0
              ? null
              : () {
                  _gotoPreviousStep(context, ref);
                },
          child: const Text('< Previous'),
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: currentStep >= substractionSteps.length
              ? null
              : () {
                  _gotoNextStep(context, ref);
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

  void _gotoPreviousStep(BuildContext context, WidgetRef ref) {
    ref.read(currentStepProvider.notifier).descrease();
  }

  void _gotoNextStep(BuildContext context, WidgetRef ref) {
    ref.read(currentStepProvider.notifier).increase();
  }

  void _saveIdea(BuildContext context, WidgetRef ref) {}
}
