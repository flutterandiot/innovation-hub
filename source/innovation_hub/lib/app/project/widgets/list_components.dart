// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:textfield_tags/textfield_tags.dart';

import 'package:innovation_hub/app/project/provider/project_provider.dart';
import 'package:innovation_hub/app/project/provider/step_provider.dart';
import 'package:innovation_hub/utils/space.dart';

import 'tag_view.dart';

class ListComponents extends ConsumerStatefulWidget {
  const ListComponents({super.key});

  @override
  ConsumerState<ListComponents> createState() => _ListComponentsState();
}

class _ListComponentsState extends ConsumerState<ListComponents> {
  final _internalTagController = TextfieldTagsController();
  final _externalTagController = TextfieldTagsController();

  @override
  void dispose() {
    _internalTagController.dispose();
    _externalTagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentProject = ref.watch(projectsProvider.notifier).currentProject!;

    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: constraints.maxWidth * 0.2,
        ),
        child: Column(
          children: [
            InputComponentTextField(
              tagController: _internalTagController,
              components: currentProject.internalComponents ?? [],
            ),
            Text(
              _internalComponentHelperText,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Space.y(32),
            InputComponentTextField(
              tagController: _externalTagController,
              components: currentProject.externalComponents ?? [],
            ),
            Text(
              _externalComponentHelperText,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      );
    });
  }
}

class InputComponentTextField extends ConsumerWidget {
  const InputComponentTextField({
    Key? key,
    required this.tagController,
    required this.components,
  }) : super(key: key);

  final TextfieldTagsController tagController;
  final List<String> components;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<int>(
      currentStepProvider,
      (previous, next) {
        // If the go from list component, then save all component
        if (previous == 1 && tagController.hasTags) {
          //Clear
          components.clear();
          //Then copy all tags
          components.addAll([...?tagController.getTags]);
        }
      },
    );
    return LayoutBuilder(builder: (context, constraints) {
      return TextFieldTags(
        textfieldTagsController: tagController,
        initialTags: components,
        textSeparators: const [','],
        letterCase: LetterCase.normal,
        validator: (String tag) {
          return null;
          // if (tag == 'php') {
          //   return 'No, please just no';
          // } else if (_controller.getTags.contains(tag)) {
          //   return 'you already entered that';
          // }
          // return null;
        },
        inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
          return ((context, src, tags, onTagDelete) {
            return TextField(
              controller: tec,
              focusNode: fn,
              decoration: InputDecoration(
                isDense: true,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 74, 137, 92),
                    width: 3.0,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 74, 137, 92),
                    width: 3.0,
                  ),
                ),
                helperStyle: const TextStyle(
                  color: Color.fromARGB(255, 74, 137, 92),
                ),
                hintText: tagController.hasTags ? '' : "Enter component...",
                errorText: error,
                prefixIconConstraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.5),
                prefixIcon: tags.isNotEmpty
                    ? _TagListView(
                        src: src,
                        tags: tags,
                        onTagDelete: (mTag) {
                          onTagDelete(mTag);
                          components.remove(mTag);
                        },
                      )
                    : null,
              ),
              onChanged: onChanged,
              onSubmitted: onSubmitted,
            );
          });
        },
      );
    });
  }
}

class _TagListView extends StatelessWidget {
  const _TagListView({
    Key? key,
    required this.src,
    required this.tags,
    required this.onTagDelete,
  }) : super(key: key);

  final ScrollController src;
  final List<String> tags;
  final Function(String) onTagDelete;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: src,
      scrollDirection: Axis.horizontal,
      child: Row(
          children: tags.map((String tag) {
        return TagView(
          tag: tag,
          onTagSelect: (mTag) {
            debugPrint('Tag selected: $mTag');
          },
          onTagDelete: onTagDelete,
        );
      }).toList()),
    );
  }
}

const _internalComponentHelperText = 'Make a list of the internal components (generally, the things attached or directly part of the product, process, or service); separate component by a comma';

const _externalComponentHelperText = 'external components (those in the immediate vicinity - within the closed world); separate component by a comma';
