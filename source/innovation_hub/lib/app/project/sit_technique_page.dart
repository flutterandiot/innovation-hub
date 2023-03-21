// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innovation_hub/app/project/widgets/list_components.dart';
import 'package:innovation_hub/utils/space.dart';

import '../../app_routing.dart';
import 'model/project_model.dart';
import 'provider/project_provider.dart';
import 'widgets/current_situation.dart';

class SitTechniquePage extends ConsumerStatefulWidget {
  const SitTechniquePage({
    Key? key,
    required this.project,
  }) : super(key: key);

  final Project project;
  @override
  ConsumerState<SitTechniquePage> createState() => _SITMethodPageState();
}

class _SITMethodPageState extends ConsumerState<SitTechniquePage> with TickerProviderStateMixin {
  int activeStep = 0;
  late List<Widget> stepViews;
  late List<EasyStep> steps;
  @override
  void initState() {
    super.initState();
    steps = [
      const EasyStep(
        icon: Icon(Icons.start),
        title: 'Current situation',
      ),
      const EasyStep(
        icon: Icon(Icons.category_rounded),
        title: 'List Components',
      ),
      const EasyStep(
        icon: Icon(Icons.add_task),
        title: 'Assign a job',
      ),
      const EasyStep(
        icon: Icon(Icons.filter_frames),
        title: 'Visualize a product',
      ),
      const EasyStep(
        icon: Icon(Icons.question_mark),
        title: 'Ask',
      ),
      const EasyStep(
        icon: Icon(Icons.done_all),
        title: 'Save',
      ),
    ];
    stepViews = [
      const CurrentSituation(),
      const ListComponents(),
      const CurrentSituation(),
      const ListComponents(),
      const CurrentSituation(),
      const ListComponents(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final currentProject = ref.watch(projectsProvider.notifier).currentProject!;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: LayoutBuilder(builder: (context, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;
        return Scaffold(
          appBar: AppBar(
            title: Text('Apply SIT for ${currentProject.name}'),
            leading: IconButton(
              onPressed: () {
                context.goNamed(
                  AppRoute.projectPage.name,
                  params: {'id': currentProject.id},
                  extra: currentProject,
                );
              },
              tooltip: 'Go back to project page',
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
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
                      // loadingAnimation: 'assets/loading_circle.json',
                      steps: steps,
                      onStepReached: (index) {
                        setState(() => activeStep = index);
                        // debugPrint('Step: $index');
                      }),
                  const SizedBox(height: 50),
                  const Divider(
                    indent: 40,
                    endIndent: 40,
                  ),
                  SizedBox(
                    height: height * 0.5,
                    width: width,
                    child: stepViews[activeStep],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    child: Row(
                      children: [
                        const Spacer(),
                        TextButton.icon(
                          onPressed: activeStep == 0
                              ? null
                              : () {
                                  setState(() {
                                    if (activeStep > 0) {
                                      activeStep -= 1;
                                    }
                                  });
                                },
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('Previous'),
                        ),
                        Space.x(12),
                        TextButton.icon(
                          onPressed: activeStep == steps.length - 1
                              ? null
                              : () {
                                  setState(() {
                                    if (activeStep < steps.length - 1) {
                                      activeStep += 1;
                                    }
                                  });
                                },
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('Next'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
