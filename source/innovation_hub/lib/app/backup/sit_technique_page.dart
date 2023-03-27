// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innovation_hub/app/project/provider/step_provider.dart';
import 'package:innovation_hub/app/project/widgets/list_components.dart';
import 'package:innovation_hub/app/project/widgets/task_unification_steps.dart';
import 'package:innovation_hub/app/project/widgets/task_unification_view.dart';
import 'package:innovation_hub/utils/space.dart';

import '../../app_routing.dart';
import '../project/model/project_model.dart';
import '../project/provider/project_provider.dart';
import '../project/widgets/current_situation.dart';

class SitTechniquePage extends ConsumerWidget {
  const SitTechniquePage({
    Key? key,
    required this.project,
  }) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentProject = ref.watch(activeProjectProvider);
    final activeStep = ref.watch(currentStepProvider);
    final maxSteps = stepViews.length;
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
                  AppRoute.projectDashboard.name,
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
                  const TaskUnificationSteps(),
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
                        Tooltip(
                          message: 'Previous step',
                          child: TextButton.icon(
                            onPressed: activeStep == 0
                                ? null
                                : () {
                                    ref.read(currentStepProvider.notifier).descrease();
                                  },
                            icon: const Icon(Icons.arrow_back),
                            label: const Text(''),
                          ),
                        ),
                        Space.x(12),
                        Tooltip(
                          message: 'Next step',
                          child: TextButton.icon(
                            onPressed: activeStep == maxSteps - 1
                                ? null
                                : () {
                                    ref.read(currentStepProvider.notifier).increase();
                                  },
                            icon: const Icon(Icons.arrow_forward),
                            label: const Text(''),
                          ),
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

const stepViews = [
  CurrentSituation(),
  ListComponents(),
  TaskUnificationView(),
  ListComponents(),
  CurrentSituation(),
  ListComponents(),
];
