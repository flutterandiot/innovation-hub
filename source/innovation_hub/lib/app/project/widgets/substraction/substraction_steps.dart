// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:innovation_hub/app/provider/project_provider.dart';

import '../../../provider/step_provider.dart';

class SubstractionStep extends HookConsumerWidget {
  const SubstractionStep({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final activeStep = useState<int>(0);
    final activeStep = ref.watch(currentStepProvider);

    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          EasyStepper(
            activeStep: activeStep,
            lineLength: 70,
            lineType: LineType.normal,
            stepShape: StepShape.rRectangle,
            stepBorderRadius: 15,
            borderThickness: 2,
            padding: 20,
            stepRadius: 32,
            finishedStepBorderColor: Colors.deepOrange,
            finishedStepTextColor: Colors.black,
            finishedStepBackgroundColor: Colors.deepOrange,
            activeStepIconColor: Colors.green,
            steps: substractionSteps,
            onStepReached: (index) {
              ref.read(currentStepProvider.notifier).update(index);
            },
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth * 0.1,
                vertical: 8,
              ),
              child: _StepView(
                body: (activeStep < _stepViews.length) ? _StepView(body: _stepViews[activeStep]) : const _CompletedView(),
              ),
            ),
          ),
        ],
      );
    });
  }
}

const _stepViews = <Widget>[
  _GeneralView(),
  _OpportunityView(),
  _BenefitsView(),
  _ProductBuildView(),
  _DeliverBenefitsView(),
  _RateIdeaView(),
];

class _StepView extends StatelessWidget {
  const _StepView({
    Key? key,
    required this.body,
  }) : super(key: key);
  final Widget body;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: body,
    );
  }
}

class _GeneralView extends HookConsumerWidget {
  const _GeneralView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final nameTextController = useTextEditingController(text: '');
    final descriptionTextController = useTextEditingController(text: '');
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16.0),
          TextFormField(
            controller: nameTextController,
            decoration: const InputDecoration(
              label: Text('Name'),
            ),
            validator: (value) {
              return value!.isEmpty ? 'Please enter name' : null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: descriptionTextController,
            decoration: const InputDecoration(
              label: Text('Description'),
            ),
            // validator: (value) {
            //   return value!.isEmpty ? 'Please enter description' : null;
            // },
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}

class _OpportunityView extends HookConsumerWidget {
  const _OpportunityView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentTextController = useTextEditingController(text: '');
    final project = ref.watch(activeProjectProvider);
    final productStr = project.type;
    final selectValue = useState(false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Does this $productStr exist?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16.0),
          RadioListTile<bool>(
            title: const Text('Yes'),
            value: true,
            groupValue: selectValue.value,
            onChanged: (value) {
              selectValue.value = value!;
            },
          ),
          RadioListTile<bool>(
            title: const Text('No'),
            value: false,
            groupValue: selectValue.value,
            onChanged: (value) {
              selectValue.value = value!;
            },
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: TextFormField(
              controller: commentTextController,
              maxLines: null,
              decoration: const InputDecoration(
                label: Text('Comment (optional)'),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}

class _BenefitsView extends HookConsumerWidget {
  const _BenefitsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentTextController = useTextEditingController(text: '');
    final project = ref.watch(activeProjectProvider);

    final selectValue = useState(false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Is there a target audience who would benefit?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16.0),
          RadioListTile<bool>(
            title: const Text('Yes'),
            value: true,
            groupValue: selectValue.value,
            onChanged: (value) {
              selectValue.value = value!;
            },
          ),
          RadioListTile<bool>(
            title: const Text('No'),
            value: false,
            groupValue: selectValue.value,
            onChanged: (value) {
              selectValue.value = value!;
            },
          ),
          const SizedBox(height: 16.0),
          if (selectValue.value)
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: commentTextController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        label: Text('Benefits (optional)'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: commentTextController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        label: Text('In situation (optional)'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}

class _ProductBuildView extends HookConsumerWidget {
  const _ProductBuildView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentTextController = useTextEditingController(text: '');
    final project = ref.watch(activeProjectProvider);
    final productStr = project.type;
    final selectValue = useState(false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Can we build this $productStr?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16.0),
          RadioListTile<bool>(
            title: const Text('Yes'),
            value: true,
            groupValue: selectValue.value,
            onChanged: (value) {
              selectValue.value = value!;
            },
          ),
          RadioListTile<bool>(
            title: const Text('No'),
            value: false,
            groupValue: selectValue.value,
            onChanged: (value) {
              selectValue.value = value!;
            },
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: TextFormField(
              controller: commentTextController,
              maxLines: null,
              decoration: const InputDecoration(
                label: Text('Comment (optional)'),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}

class _DeliverBenefitsView extends HookConsumerWidget {
  const _DeliverBenefitsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentTextController = useTextEditingController(text: '');

    final selectValue = useState(false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Do we have the ability to deliver these benefits?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16.0),
          RadioListTile<bool>(
            title: const Text('Yes'),
            value: true,
            groupValue: selectValue.value,
            onChanged: (value) {
              selectValue.value = value!;
            },
          ),
          RadioListTile<bool>(
            title: const Text('No'),
            value: false,
            groupValue: selectValue.value,
            onChanged: (value) {
              selectValue.value = value!;
            },
          ),
          const SizedBox(height: 16.0),
          if (selectValue.value)
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: commentTextController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        label: Text('Benefits (optional)'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: commentTextController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        label: Text('How would it work? (optional)'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}

class _RateIdeaView extends HookConsumerWidget {
  const _RateIdeaView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentTextController = useTextEditingController(text: '');
    final project = ref.watch(activeProjectProvider);
    final productStr = project.type;
    final selectValue = useState(false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'How much you love this $productStr?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16.0),
          RadioListTile<bool>(
            title: const Text('Yes'),
            value: true,
            groupValue: selectValue.value,
            onChanged: (value) {
              selectValue.value = value!;
            },
          ),
          RadioListTile<bool>(
            title: const Text('No'),
            value: false,
            groupValue: selectValue.value,
            onChanged: (value) {
              selectValue.value = value!;
            },
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: TextFormField(
              controller: commentTextController,
              maxLines: null,
              decoration: const InputDecoration(
                label: Text('Comment (optional)'),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}

class _CompletedView extends HookConsumerWidget {
  const _CompletedView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(activeProjectProvider);
    final productStr = project.type;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Wonderful. Your new $productStr concept is awesome',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 24.0),
          Text(
            'Modify and make adaptations of the concept to improve it.',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 24.0),
          Text(
            'With Subtraction, you can consider replacing the subtracted component from any other component in the immediate vicinity (within the closed world). Repeat the sequence of this step.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

const List<EasyStep> substractionSteps = [
  EasyStep(
    icon: Icon(Icons.info),
    title: 'General',
  ),
  EasyStep(
    icon: Icon(Icons.monetization_on),
    title: 'Opportunity',
  ),
  EasyStep(
    icon: Icon(Icons.favorite),
    title: 'Benefits',
  ),
  EasyStep(
    icon: Icon(Icons.new_releases),
    title: 'New product',
  ),
  EasyStep(
    icon: Icon(Icons.bug_report),
    title: 'Issue',
  ),
  EasyStep(
    icon: Icon(Icons.star_rate),
    title: 'Rate',
  ),
];
