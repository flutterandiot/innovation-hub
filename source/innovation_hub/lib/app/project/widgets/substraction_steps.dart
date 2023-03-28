// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider/step_provider.dart';

class SubstractionStep extends ConsumerWidget {
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
            steps: steps,
            onStepReached: (index) {
              ref.read(currentStepProvider.notifier).update(index);
            },
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.1, vertical: 8),
              child: const _StepView(
                body: _GeneralView(),
              ),
            ),
          ),
        ],
      );
    });
  }
}

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

const List<EasyStep> steps = [
  EasyStep(
    icon: Icon(Icons.info),
    title: 'General',
  ),
  EasyStep(
    icon: Icon(Icons.monetization_on),
    title: 'Opportunity',
  ),
  EasyStep(
    icon: Icon(Icons.new_releases),
    title: 'New product',
  ),
  EasyStep(
    icon: Icon(Icons.favorite),
    title: 'Benefits',
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
