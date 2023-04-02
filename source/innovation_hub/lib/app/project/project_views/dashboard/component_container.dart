import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:innovation_hub/app/project/widgets/chart_indicator.dart';
import 'package:innovation_hub/app_routing.dart';

import '../../../provider/project_provider.dart';

class ProjectComponentsContainer extends ConsumerWidget {
  const ProjectComponentsContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final components = ref.watch(activeProjectProvider.select((value) => value.components));

    if (components.isEmpty) {
      return const _EmptyComponentView();
    }

    return const _ComponentSummaryView();
  }
}

class _ComponentSummaryView extends HookConsumerWidget {
  const _ComponentSummaryView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final components = ref.watch(activeProjectProvider.select((proj) => proj.components));
    final internalComps = components
        .where(
          (element) => element.isInternal == true,
        )
        .toList();
    final externalComps = components
        .where(
          (element) => element.isInternal == false,
        )
        .toList();

    final touchedIndex = useState<int>(-1);
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8),
      padding: const EdgeInsets.only(left: 8, right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
            color: Colors.black,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Components in this project',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(
            height: 200,
            width: 300,
            child: Row(
              children: [
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        '${components.length}',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback: (FlTouchEvent event, pieTouchResponse) {
                              if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                                touchedIndex.value = -1;
                                return;
                              }
                              touchedIndex.value = pieTouchResponse.touchedSection!.touchedSectionIndex;
                            },
                          ),
                          borderData: FlBorderData(
                            show: true,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,
                          sections: [
                            PieChartSectionData(
                              value: internalComps.length.toDouble(),
                              title: '${internalComps.length}',
                              color: Colors.amber,
                              radius: touchedIndex.value == 0 ? 44 : 40,
                            ),
                            PieChartSectionData(
                              value: externalComps.length.toDouble(),
                              title: '${externalComps.length}',
                              color: Colors.blue,
                              radius: touchedIndex.value == 1 ? 44 : 40,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: const [
                    Indicator(color: Colors.amber, text: 'Internal', isSquare: true),
                    Indicator(color: Colors.blue, text: 'External', isSquare: true),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyComponentView extends ConsumerWidget {
  const _EmptyComponentView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 400,
      child: Center(
        child: TextButton.icon(
          icon: const Icon(Icons.add),
          onPressed: () {
            final activeProject = ref.read(activeProjectProvider);
            context.goNamed(
              AppRoute.projectComponent.name,
              params: {'id': activeProject.id},
              extra: activeProject,
            );
          },
          label: const Text('Add component'),
        ),
      ),
    );
  }
}
