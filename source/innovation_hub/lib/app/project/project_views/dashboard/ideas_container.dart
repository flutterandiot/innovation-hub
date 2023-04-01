import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:innovation_hub/app/provider/idea_controller.dart';
import 'package:innovation_hub/app/provider/project_provider.dart';

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
                      return _IdeaListTile(ideas[index]);
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

class _IdeaListTile extends ConsumerStatefulWidget {
  const _IdeaListTile(
    this.idea,
  );
  final Idea idea;
  @override
  ConsumerState<_IdeaListTile> createState() => _IdeaListTileState();
}

class _IdeaListTileState extends ConsumerState<_IdeaListTile> {
  @override
  Widget build(BuildContext context) {
    debugPrint('Idea  rebuilt: ${widget.idea.id}');
    return Card(
      child: ListTile(
        // tileColor: Theme.of(context).primaryColor,
        // leading: Checkbox(
        //   value: checked.value,
        //   onChanged: (value) {
        //     checked.value = value!;
        //   },
        // ),
        selected: widget.idea.id == ref.read(ideaManageProvider)!.id,
        // selectedColor: Colors.amberAccent,
        title: Text(widget.idea.concept),
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
                onPressed: () {
                  // _likeTheIdea(context, ref, idea);
                  // idea.rating++;
                },
                label: Text(
                  '${widget.idea.rating}',
                  style: const TextStyle(color: Colors.red),
                ),
                icon: const Icon(
                  Icons.thumb_up,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          ref.read(ideaManageProvider.notifier).setIdea(widget.idea);
          setState(() {});
        },
      ),
    );
  }
}
