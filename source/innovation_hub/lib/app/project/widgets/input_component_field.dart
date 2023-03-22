import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:innovation_hub/app/project/widgets/tag_view.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../provider/step_provider.dart';

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
        return TagItemView(
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
