import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:innovation_hub/app/provider/project_provider.dart';

import '../../../model/idea_model.dart';

class IdeasContainer extends ConsumerWidget {
  const IdeasContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const _IdeaListViewContainer();
  }
}

class _IdeaListViewContainer extends StatelessWidget {
  const _IdeaListViewContainer();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8),
      padding: const EdgeInsets.only(left: 8, right: 8),
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
      height: 400,
      child: Column(
        children: [
          const Text('Ideas generated'),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final ideas = ref.watch(
                  activeProjectProvider.select((value) => value.ideas),
                );
                if (ideas.isNotEmpty) {
                  return ListView.builder(
                    itemCount: ideas.length,
                    itemBuilder: (context, index) {
                      return _IdeaListTile(ideas[index]);
                      // _IdeaListTile(idea: ideas[index]);
                    },
                    // separatorBuilder: (context, index) {
                    //   return const Divider();
                    // },
                  );
                }

                return const SizedBox(
                  child: Center(
                    child: Text("There isn't any idea for this for project."),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _IdeaListTile extends HookConsumerWidget {
  const _IdeaListTile(
    this.idea,
  );
  final Idea idea;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checked = useState(false);

    debugPrint('Idea  rebuilt: ${idea.id}');
    return Card(
      child: ListTile(
        // tileColor: Theme.of(context).primaryColor,
        leading: Checkbox(
          value: checked.value,
          onChanged: (value) {
            checked.value = value!;
          },
        ),
        title: Text(idea.concept),
        trailing: TextButton.icon(
          onPressed: () {
            // _likeTheIdea(context, ref, idea);
            // idea.rating++;
          },
          label: Text(
            '${idea.rating}',
            style: const TextStyle(color: Colors.red),
          ),
          icon: const Icon(
            Icons.thumb_up,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
