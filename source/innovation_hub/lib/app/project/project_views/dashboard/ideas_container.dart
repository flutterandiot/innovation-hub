// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:innovation_hub/app/provider/project_provider.dart';
import 'package:innovation_hub/app_routing.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:innovation_hub/app/provider/idea_controller.dart';
import 'package:innovation_hub/utils/app_utils.dart';

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
                // ? ListView.builder(
                //     padding: const EdgeInsets.only(left: 8, right: 8),
                //     itemCount: ideas.length,
                //     itemBuilder: (context, index) {
                //       return ProviderScope(
                //         overrides: [
                //           ideaIndexProvider.overrideWithValue(index),
                //         ],
                //         child: const _IdeaListTile(),
                //       );
                //       // return _IdeaListTile(ideas[index]);
                //       // _IdeaListTile(idea: ideas[index]);
                //     },
                //     // separatorBuilder: (context, index) {
                //     //   return const Divider();
                //     // },
                //   )
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

class _IdeaListTile extends HookConsumerWidget {
  const _IdeaListTile(
      // this.idea,
      );
  // final Idea idea;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIdea = ref.watch(ideaManageProvider);
    final ideaIndex = ref.watch(ideaIndexProvider);
    final ideaList = ref.watch(ideasProvider);
    final idea = ideaList[ideaIndex];
    final isSelected = useState(false);
    isSelected.value = idea.id == selectedIdea?.id;

    debugPrint('Idea  rebuilt: ${idea.id}');

    return Card(
      child: ListTile(
        selected: isSelected.value,
        selectedTileColor: Colors.amberAccent,
        title: Text(idea.concept),
        trailing: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 300,
            minWidth: 100,
          ),
          child: Row(
            children: [
              Tooltip(
                message: 'Feasible',
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    side: const BorderSide(),
                  ),
                  child: const Text('F'),
                ),
              ),
              Tooltip(
                message: 'Desirable',
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    side: const BorderSide(),
                  ),
                  child: const Text('D'),
                ),
              ),
              SizedBox(
                width: 64,
                height: 64,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: isSelected.value ? Colors.white : Colors.amber,
                      size: 48,
                    ),
                    Text(
                      '${idea.rating}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          ref.read(ideaManageProvider.notifier).setIdea(idea);
        },
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
  late BuildContext myContext;
  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      title: 'Action',
      field: 'details',
      type: PlutoColumnType.text(),
      titleTextAlign: PlutoColumnTextAlign.center,
      minWidth: 300,
      renderer: (rendererContext) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _onDeleteRow(rendererContext);
              },
              label: const Text('Delete'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // _onFavoriteRow();
              },
              child: const Text('Favorite'),
            ),
            _EditButton(rendererContext: rendererContext),
          ],
        );
      },
    ),
    PlutoColumn(
      title: 'Rating',
      field: 'rating',
      type: PlutoColumnType.number(),
      // minWidth: 80,
      titleTextAlign: PlutoColumnTextAlign.center,
      enableContextMenu: false,
    ),
    PlutoColumn(
      title: 'Name',
      field: 'name',
      type: PlutoColumnType.text(),
      titleTextAlign: PlutoColumnTextAlign.center,
    ),
    PlutoColumn(
      title: 'Component',
      field: 'component',
      type: PlutoColumnType.text(),
      titleTextAlign: PlutoColumnTextAlign.center,
    ),
    PlutoColumn(
      readOnly: true,
      title: 'Method',
      field: 'method',
      type: PlutoColumnType.text(),
      titleTextAlign: PlutoColumnTextAlign.center,
    ),
    PlutoColumn(
      title: 'Feasibility',
      field: 'feasibility',
      type: PlutoColumnType.number(),
      titleTextAlign: PlutoColumnTextAlign.center,
    ),
    PlutoColumn(
      title: 'Updated',
      field: 'updated_at',
      type: PlutoColumnType.date(format: 'dd-MM-yy'),
      titleTextAlign: PlutoColumnTextAlign.center,
    ),
  ];

  final List<PlutoRow> rows = [
    PlutoRow(
      cells: {
        'rating': PlutoCell(value: 'user1'),
        'name': PlutoCell(value: 'Mike'),
        'component': PlutoCell(value: 20),
        'method': PlutoCell(value: 'Programmer'),
        'feasibility': PlutoCell(value: '2021-01-01'),
        'updated_at': PlutoCell(value: '09:00'),
      },
    ),
    PlutoRow(
      cells: {
        'rating': PlutoCell(value: 'user2'),
        'name': PlutoCell(value: 'Jack'),
        'component': PlutoCell(value: 25),
        'method': PlutoCell(value: 'Designer'),
        'feasibility': PlutoCell(value: '2021-02-01'),
        'updated_at': PlutoCell(value: '10:00'),
      },
    ),
    PlutoRow(
      cells: {
        'rating': PlutoCell(value: 'user3'),
        'name': PlutoCell(value: 'Suzi'),
        'component': PlutoCell(value: 40),
        'method': PlutoCell(value: 'Owner'),
        'feasibility': PlutoCell(value: '2021-03-01'),
        'updated_at': PlutoCell(value: '11:00'),
      },
    ),
  ];

  /// columnGroups that can group columns can be omitted.
  final List<PlutoColumnGroup> columnGroups = [
    PlutoColumnGroup(title: 'rating', fields: ['rating'], expandedColumn: true),
    PlutoColumnGroup(title: 'User information', fields: ['name', 'component']),
    PlutoColumnGroup(title: 'Status', children: [
      PlutoColumnGroup(title: 'A', fields: ['method'], expandedColumn: true),
      PlutoColumnGroup(title: 'Etc.', fields: ['feasibility', 'updated_at']),
    ]),
  ];

  /// [PlutoGridStateManager] has many methods and properties to dynamically manipulate the grid.
  /// You can manipulate the grid dynamically at runtime by passing this through the [onLoaded] callback.
  late final PlutoGridStateManager stateManager;

  List<PlutoRow> _createIdeaRows(BuildContext context) {
    final ideaList = ref.watch(ideasProvider);
    return ideaList
        .map(
          (mIdea) => PlutoRow(
            cells: {
              'rating': PlutoCell(value: mIdea.rating),
              'name': PlutoCell(value: mIdea.name),
              'component': PlutoCell(value: mIdea.componentId),
              'method': PlutoCell(value: mIdea.method.name),
              'feasibility': PlutoCell(value: mIdea.rating),
              'updated_at': PlutoCell(
                value: AppUtilities.getTimeFromEpoch(
                  int.tryParse(mIdea.createdAt) ?? DateTime.now().millisecondsSinceEpoch ~/ 1000,
                ),
              ),
              'details': PlutoCell(value: 'Edit'),
            },
          ),
        )
        .toList();
  }

  static void _onDeleteRow(PlutoColumnRendererContext rendererContext) {
    final rowIdx = rendererContext.rowIdx;
    debugPrint('Delete row: $rowIdx');
  }

  static void _onFavoriteRow(PlutoColumnRendererContext rendererContext) {
    final rowIdx = rendererContext.rowIdx;
    debugPrint('Favorite row: $rowIdx');
  }

  static void _onEditRow(
    PlutoColumnRendererContext rendererContext,
  ) {
    final rowIdx = rendererContext.rowIdx;

    debugPrint('Edit row: $rowIdx');
  }

  @override
  Widget build(BuildContext context) {
    myContext = context;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: PlutoGrid(
          columns: columns,
          rows: _createIdeaRows(context),
          // columnGroups: columnGroups,
          onLoaded: (PlutoGridOnLoadedEvent event) {
            stateManager = event.stateManager;
          },
          onChanged: (PlutoGridOnChangedEvent event) {
            debugPrint(event.toString());
          },
          onRowDoubleTap: (event) {
            debugPrint('Row selected: ${event.rowIdx}');
          },
          onRowChecked: (event) {
            debugPrint('Row selected: ${event.rowIdx}');
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
    return ElevatedButton(
      onPressed: () {
        _onEditRow(rendererContext, context);
        ref.read(ideaManageProvider.notifier).setIdea(idea);
        context.pushNamed(
          AppRoute.ideaPage.name,
          params: {
            'id': project.id,
            'ideaId': idea.id,
          },
        );
      },
      child: const Text('Edit'),
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
