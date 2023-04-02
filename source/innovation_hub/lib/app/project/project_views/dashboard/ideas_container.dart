import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:innovation_hub/app/provider/idea_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';

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
class PlutoGridExamplePage extends StatefulWidget {
  const PlutoGridExamplePage({Key? key}) : super(key: key);

  @override
  State<PlutoGridExamplePage> createState() => _PlutoGridExamplePageState();
}

class _PlutoGridExamplePageState extends State<PlutoGridExamplePage> {
  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      title: 'Id',
      field: 'id',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Name',
      field: 'name',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Age',
      field: 'age',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Role',
      field: 'role',
      type: PlutoColumnType.select(<String>[
        'Programmer',
        'Designer',
        'Owner',
      ]),
    ),
    PlutoColumn(
      title: 'Joined',
      field: 'joined',
      type: PlutoColumnType.date(),
    ),
    PlutoColumn(
      title: 'Working time',
      field: 'working_time',
      type: PlutoColumnType.time(),
    ),
  ];

  final List<PlutoRow> rows = [
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 'user1'),
        'name': PlutoCell(value: 'Mike'),
        'age': PlutoCell(value: 20),
        'role': PlutoCell(value: 'Programmer'),
        'joined': PlutoCell(value: '2021-01-01'),
        'working_time': PlutoCell(value: '09:00'),
      },
    ),
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 'user2'),
        'name': PlutoCell(value: 'Jack'),
        'age': PlutoCell(value: 25),
        'role': PlutoCell(value: 'Designer'),
        'joined': PlutoCell(value: '2021-02-01'),
        'working_time': PlutoCell(value: '10:00'),
      },
    ),
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 'user3'),
        'name': PlutoCell(value: 'Suzi'),
        'age': PlutoCell(value: 40),
        'role': PlutoCell(value: 'Owner'),
        'joined': PlutoCell(value: '2021-03-01'),
        'working_time': PlutoCell(value: '11:00'),
      },
    ),
  ];

  /// columnGroups that can group columns can be omitted.
  final List<PlutoColumnGroup> columnGroups = [
    PlutoColumnGroup(title: 'Id', fields: ['id'], expandedColumn: true),
    PlutoColumnGroup(title: 'User information', fields: ['name', 'age']),
    PlutoColumnGroup(title: 'Status', children: [
      PlutoColumnGroup(title: 'A', fields: ['role'], expandedColumn: true),
      PlutoColumnGroup(title: 'Etc.', fields: ['joined', 'working_time']),
    ]),
  ];

  /// [PlutoGridStateManager] has many methods and properties to dynamically manipulate the grid.
  /// You can manipulate the grid dynamically at runtime by passing this through the [onLoaded] callback.
  late final PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: PlutoGrid(
          columns: columns,
          rows: rows,
          // columnGroups: columnGroups,
          onLoaded: (PlutoGridOnLoadedEvent event) {
            stateManager = event.stateManager;
          },
          onChanged: (PlutoGridOnChangedEvent event) {
            print(event);
          },
          configuration: const PlutoGridConfiguration(),
        ),
      ),
    );
  }
}
