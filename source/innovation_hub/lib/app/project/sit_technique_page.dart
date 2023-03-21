// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app_routing.dart';
import 'model/project_model.dart';
import 'provider/project_provider.dart';

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
  late TabController _tabController;
  int activeStep = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final currentProject = ref.watch(projectsProvider.notifier).currentProject!;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
                    steps: const [
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
                    ],
                    onStepReached: (index) {
                      setState(() => activeStep = index);
                      // debugPrint('Step: $index');
                    }),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
/*
      child: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Apply SIT for ${currentProject.name}'),
            leading: IconButton(
              onPressed: () {
                context.goNamed(
                  AppRoute.projectPage.name,
                  params: {'id': widget.project.id},
                  extra: widget.project,
                );
              },
              tooltip: 'Go back to project page',
              icon: const Icon(Icons.arrow_back),
            ),
            bottom: TabBar(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              controller: _tabController,
              // indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 3,
              // indicator: BoxDecoration(
              //   borderRadius: BorderRadius.circular(8),
              //   color: Colors.amberAccent,
              // ),
              tabs: const [
                Tab(
                  text: 'Components',
                  icon: Icon(Icons.compost),
                ),
                Tab(
                  text: 'Select',
                  icon: Icon(Icons.hdr_on_select),
                ),
                Tab(
                  text: 'Idea',
                  icon: Icon(Icons.light),
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: const [
              Center(
                child: Text('List all compoments'),
              ),
              Center(
                child: Text('Select a compoment'),
              ),
              Center(
                child: Text('Ideas'),
              ),
            ],
          ),
        ),
      ),
   */
    );
  }
}
