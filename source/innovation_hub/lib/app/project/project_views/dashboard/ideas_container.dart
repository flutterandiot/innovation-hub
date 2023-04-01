import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:innovation_hub/app/provider/idea_controller.dart';
import 'package:innovation_hub/app/provider/project_provider.dart';

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
    final ideas = ref.watch(
      activeProjectProvider.select((value) => value.ideas),
    );
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
                ? ListView.builder(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    itemCount: ideas.length,
                    itemBuilder: (context, index) {
                      return ProviderScope(
                        overrides: [
                          ideaIndexProvider.overrideWithValue(index),
                        ],
                        child: const _IdeaListTile(),
                      );
                      // return _IdeaListTile(ideas[index]);
                      // _IdeaListTile(idea: ideas[index]);
                    },
                    // separatorBuilder: (context, index) {
                    //   return const Divider();
                    // },
                  )
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
              TextButton.icon(
                onPressed: null,
                label: Text(
                  '${idea.rating}',
                  style: const TextStyle(color: Colors.red),
                ),
                icon: Icon(
                  Icons.star,
                  color: isSelected.value ? Colors.white : Colors.amber,
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
