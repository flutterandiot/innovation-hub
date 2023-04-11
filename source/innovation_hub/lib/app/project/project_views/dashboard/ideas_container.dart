// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:innovation_hub/app/provider/project_provider.dart';
import 'package:innovation_hub/app_routing.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:innovation_hub/app/provider/idea_controller.dart';
import 'package:innovation_hub/utils/app_utils.dart';

import '../../../model/idea_model.dart';

class IdeasContainer extends ConsumerWidget {
  const IdeasContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const _IdeaListViewContainer();
  }
}

class _IdeaListViewContainer extends ConsumerWidget {
  const _IdeaListViewContainer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ideas = ref.watch(ideasProvider);
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8),
      // padding: const EdgeInsets.only(left: 8, right: 8),
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: Colors.grey,
        // ),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
            color: Colors.black,
          ),
        ],
      ),
      height: ideas.isNotEmpty ? 400 : 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              // border: Border.all(
              //   color: Colors.grey,
              // ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              color: Colors.amber,
            ),
            child: Text(
              'Ideas generated',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: (ideas.isNotEmpty)
                ? const PlutoGridExamplePage()
                : const SizedBox(
                    child: Center(
                      child: Text("There isn't any idea for this for project."),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

/// PlutoGrid Example
//
/// For more examples, go to the demo web link on the github below.
class PlutoGridExamplePage extends ConsumerStatefulWidget {
  const PlutoGridExamplePage({Key? key}) : super(key: key);

  @override
  ConsumerState<PlutoGridExamplePage> createState() => _PlutoGridExamplePageState();
}

class _PlutoGridExamplePageState extends ConsumerState<PlutoGridExamplePage> {
  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      readOnly: true,
      enableContextMenu: false,
      title: 'Action',
      field: 'details',
      type: PlutoColumnType.text(),
      titleTextAlign: PlutoColumnTextAlign.center,
      minWidth: 180,
      renderer: (rendererContext) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {},
              style: IconButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {},
              style: IconButton.styleFrom(
                backgroundColor: Colors.pink[300],
                foregroundColor: Colors.white,
              ),
            ),
            _EditButton(rendererContext: rendererContext),
          ],
        );
      },
    ),
    PlutoColumn(
      readOnly: true,
      enableContextMenu: false,
      title: 'Rating',
      field: 'rating',
      type: PlutoColumnType.number(),
      // minWidth: 80,
      titleTextAlign: PlutoColumnTextAlign.center,
    ),
    PlutoColumn(
      readOnly: true,
      enableContextMenu: false,
      title: 'Idea',
      field: 'idea',

      type: PlutoColumnType.text(),
      // minWidth: 80,
      titleTextAlign: PlutoColumnTextAlign.center,
      minWidth: 300,
    ),
    PlutoColumn(
      readOnly: true,
      enableContextMenu: false,
      title: 'Name',
      field: 'name',
      type: PlutoColumnType.text(),
      titleTextAlign: PlutoColumnTextAlign.center,
    ),
    PlutoColumn(
      readOnly: true,
      enableContextMenu: false,
      title: 'Component',
      field: 'component',
      type: PlutoColumnType.text(),
      titleTextAlign: PlutoColumnTextAlign.center,
    ),
    PlutoColumn(
      readOnly: true,
      enableContextMenu: false,
      title: 'Method',
      field: 'method',
      type: PlutoColumnType.text(),
      titleTextAlign: PlutoColumnTextAlign.center,
    ),
    PlutoColumn(
      readOnly: true,
      enableContextMenu: false,
      title: 'Feasibility',
      field: 'feasibility',
      type: PlutoColumnType.number(),
      titleTextAlign: PlutoColumnTextAlign.center,
    ),
    PlutoColumn(
      readOnly: true,
      enableContextMenu: false,
      title: 'Updated',
      field: 'updated_at',
      type: PlutoColumnType.date(format: 'dd-MM-yy'),
      titleTextAlign: PlutoColumnTextAlign.center,
    ),
  ];

  /// columnGroups that can group columns can be omitted.
  // final List<PlutoColumnGroup> columnGroups = [
  //   PlutoColumnGroup(title: 'rating', fields: ['rating'], expandedColumn: true),
  //   PlutoColumnGroup(title: 'User information', fields: ['name', 'component']),
  //   PlutoColumnGroup(title: 'Status', children: [
  //     PlutoColumnGroup(title: 'A', fields: ['method'], expandedColumn: true),
  //     PlutoColumnGroup(title: 'Etc.', fields: ['feasibility', 'updated_at']),
  //   ]),
  // ];

  /// [PlutoGridStateManager] has many methods and properties to dynamically manipulate the grid.
  /// You can manipulate the grid dynamically at runtime by passing this through the [onLoaded] callback.
  late final PlutoGridStateManager stateManager;

  List<PlutoRow> _createIdeaRows(
    BuildContext context,
    List<Idea> ideaList,
  ) {
    debugPrint('rebuild idea rows');

    final rows = ideaList.map(
      (mIdea) {
        debugPrint('✅ Update idea: ${mIdea.name}');
        return PlutoRow(
          cells: {
            'rating': PlutoCell(value: mIdea.rating),
            'idea': PlutoCell(value: mIdea.concept.replaceAll('Imagine you have a new', '')),
            'name': PlutoCell(value: mIdea.name),
            'component': PlutoCell(value: mIdea.componentId),
            'method': PlutoCell(value: mIdea.method.name.characters.first.toUpperCase()),
            'feasibility': PlutoCell(value: mIdea.rating),
            'updated_at': PlutoCell(
              value: AppUtilities.getTimeFromEpoch(
                int.tryParse(mIdea.createdAt) ?? DateTime.now().millisecondsSinceEpoch ~/ 1000,
              ),
            ),
            'details': PlutoCell(value: 'Edit'),
          },
        );
      },
    ).toList();

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    final ideaList = ref.watch(ideasProvider);
    debugPrint('Rebuid idea table');

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: PlutoGrid(
          columns: columns,
          rows: _createIdeaRows(context, ideaList),

          // columnGroups: columnGroups,
          onLoaded: (PlutoGridOnLoadedEvent event) {
            stateManager = event.stateManager;
          },
          onChanged: (PlutoGridOnChangedEvent event) {
            debugPrint(event.toString());
          },

          configuration: const PlutoGridConfiguration(
            columnSize: PlutoGridColumnSizeConfig(
              autoSizeMode: PlutoAutoSizeMode.scale,
              resizeMode: PlutoResizeMode.normal,
            ),
          ),
        ),
      ),
    );
  }
}

class _EditButton extends ConsumerWidget {
  const _EditButton({
    Key? key,
    required this.rendererContext,
  }) : super(key: key);
  final PlutoColumnRendererContext rendererContext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(activeProjectProvider);
    final ideaList = ref.watch(ideasProvider);
    final idea = ideaList[rendererContext.rowIdx];
    return IconButton(
      onPressed: () {
        _onEditRow(rendererContext, context);
        ref.read(ideaManageProvider.notifier).setIdea(idea);
        final currentLocation = GoRouter.of(context).location;

        context.goNamed(
          AppRoute.ideaPage.name,
          params: {
            'id': project.id,
            'ideaId': idea.id,
          },
          extra: currentLocation,
        );
      },
      icon: const Icon(Icons.edit),
      style: IconButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
    );
  }

  static void _onEditRow(
    PlutoColumnRendererContext rendererContext,
    BuildContext context,
  ) {
    final rowIdx = rendererContext.rowIdx;

    debugPrint('Edit row: $rowIdx');
  }
}
