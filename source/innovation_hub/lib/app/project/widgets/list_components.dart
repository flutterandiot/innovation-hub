// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:textfield_tags/textfield_tags.dart';

import 'package:innovation_hub/app/project/provider/project_provider.dart';
import 'package:innovation_hub/utils/space.dart';

class ListComponents extends ConsumerStatefulWidget {
  const ListComponents({super.key});

  @override
  ConsumerState<ListComponents> createState() => _ListComponentsState();
}

class _ListComponentsState extends ConsumerState<ListComponents> {
  late TextfieldTagsController _tagController;
  @override
  void initState() {
    _tagController = TextfieldTagsController();
    super.initState();
  }

  @override
  void dispose() {
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentProject = ref.watch(projectsProvider.notifier).currentProject;

    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: constraints.maxWidth * 0.2,
        ),
        child: Column(
          children: [
            TextFieldTags(
              textfieldTagsController: _tagController,
              initialTags: [...currentProject!.internalComponents ?? List.empty()],
              textSeparators: const [' ', ','],
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
                      helperText: 'Enter internal components...',
                      helperStyle: const TextStyle(
                        color: Color.fromARGB(255, 74, 137, 92),
                      ),
                      hintText: _tagController.hasTags ? '' : "Enter component...",
                      errorText: error,
                      prefixIconConstraints: BoxConstraints(maxWidth: width * 0.4),
                      prefixIcon: tags.isNotEmpty
                          ? SingleChildScrollView(
                              controller: src,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: tags.map((String tag) {
                                return TagView(
                                  tag: tag,
                                  onTagSelect: (mTag) {
                                    debugPrint('Tag selected: $mTag');
                                  },
                                  onTagDelete: (mTag) {
                                    onTagDelete(mTag);
                                    currentProject.internalComponents!.remove(mTag);
                                  },
                                );
                              }).toList()),
                            )
                          : null,
                    ),
                    onChanged: onChanged,
                    onSubmitted: (str) {
                      onSubmitted!(str);
                      currentProject.internalComponents!.add(str);
                    },
                  );
                });
              },
            ),
            Text(
              _internalComponentHelperText,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Space.y(32),
            const TextField(
              decoration: InputDecoration(
                labelText: 'List all external components',
              ),
            ),
            const Text(
              'external components (those in the immediate vicinity - within the closed world); separate component by a comma',
              textAlign: TextAlign.start,
            ),
          ],
        ),
      );
    });
  }
}

const _internalComponentHelperText = 'Make a list of the internal components (generally, the things attached or directly part of the product, process, or service); separate component by a comma';

class TagView extends StatelessWidget {
  const TagView({
    Key? key,
    required this.tag,
    required this.onTagSelect,
    required this.onTagDelete,
  }) : super(key: key);

  final String tag;
  final Function(String) onTagSelect;
  final Function(String) onTagDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Material(
        color: const Color.fromARGB(255, 252, 0, 143),
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.all(
        //     Radius.circular(20.0),
        //   ),
        // ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
        child: InkWell(
          onTap: () {
            debugPrint('Selected: #$tag');
            onTagSelect(tag);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '#$tag',
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(width: 4.0),
                InkWell(
                  child: const Icon(
                    Icons.cancel,
                    size: 14.0,
                    color: Color.fromARGB(255, 233, 233, 233),
                  ),
                  onTap: () {
                    onTagDelete(tag);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
