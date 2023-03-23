// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_stepper/easy_stepper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:innovation_hub/app/project/provider/step_provider.dart';

class TaskUnificationSteps extends ConsumerWidget {
  const TaskUnificationSteps({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final activeStep = useState<int>(0);
    final activeStep = ref.watch(currentStepProvider);
    return EasyStepper(
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
    );
  }
}

const List<EasyStep> steps = [
  EasyStep(
    icon: Icon(Icons.start),
    title: 'Current situation',
  ),
  EasyStep(
    icon: Icon(Icons.category_rounded),
    title: 'List Components',
  ),
  EasyStep(
    icon: Icon(Icons.add_task),
    title: 'Assign a job',
  ),
  EasyStep(
    icon: Icon(Icons.filter_frames),
    title: 'Visualize a product',
  ),
  EasyStep(
    icon: Icon(Icons.question_mark),
    title: 'Ask',
  ),
  EasyStep(
    icon: Icon(Icons.done_all),
    title: 'Save',
  ),
];
