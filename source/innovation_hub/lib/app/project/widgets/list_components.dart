// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:innovation_hub/app/project/widgets/component_dialog.dart';
import 'package:textfield_tags/textfield_tags.dart';

import 'package:innovation_hub/app/project/provider/project_provider.dart';
import 'package:innovation_hub/utils/space.dart';

import 'input_component_field.dart';

const _internalComponentHelperText = 'Make a list of the internal components (generally, the things attached or directly part of the product, process, or service); separate component by a comma';

const _externalComponentHelperText = 'external components (those in the immediate vicinity - within the closed world); separate component by a comma';

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
            SizedBox(
              height: 100,
              child: Row(
                children: [
                  const Text('Components'),
                  Space.x(12),
                  IconButton(
                    onPressed: () {
                      _showAddNewComponentDialog(context);
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            InputComponentTextField(
              tagController: _internalTagController,
              components: const [],
            ),
            Text(
              _internalComponentHelperText,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Space.y(32),
            InputComponentTextField(
              tagController: _externalTagController,
              components: const [],
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

  void _showAddNewComponentDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: const ComponentDialog(),
        );
      },
    );
  }
}
