// ignore_for_file: public_member_api_docs, sort_constructors_first
/*
* Autogenerated header by File Header Comment extension - Donna Iwan
* File:       prj_component_view.dart
* Created on: Thu Mar 23 2023
* Author:     Tong Vu Than Dan
*
* Copyright (c) 2023 Tong Vu Than Dan
* Website:     dantopia.vn
*
* Description: This is a component tabview for a project
 */
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:innovation_hub/app/project/model/component_model.dart';
import 'package:innovation_hub/app/project/provider/project_provider.dart';
import 'package:innovation_hub/app/project/widgets/delete_comp_confirm_dialog.dart';
import 'package:innovation_hub/app/project/widgets/edit_component_dialog.dart';
import 'package:innovation_hub/app/project/widgets/new_component_dialog.dart';

import '../widgets/component_card.dart';

class ProjectComponentView extends ConsumerWidget {
  const ProjectComponentView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final activeProject = ref.watch(activeProjectProvider);
    final internalComp = activeProject.internalComponents;
    final externalComp = activeProject.externalComponents;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 12, right: 12),
            child: Column(
              children: [
                //Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Components', style: textTheme.headlineMedium),
                    IconButton(
                      onPressed: () async {
                        await _showAddNewComponent(context);
                      },
                      icon: const Icon(
                        Icons.add_box,
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Search component',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              //TODO - add code for searching components
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ), // Header
                //Show components
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                SizedBox(
                  width: double.infinity, //add this to make the wrap width as much as position
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    spacing: 12,
                    runSpacing: 12,
                    children: internalComp
                        .map(
                          (comp) => ComponentCard(
                            component: comp,
                            onEdit: () async {
                              await _showEditComponent(context, comp);
                            },
                            onDelete: () async {
                              //Deiete
                              await _showDeleteComponentConfirmDialog(context, ref, comp);
                            },
                            onEnableToggle: () {
                              // Disable
                              _disableComponent(ref, comp);
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
                SizedBox(
                  width: double.infinity, // add this to make the wrap width as much as position
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    spacing: 12,
                    runSpacing: 12,
                    children: externalComp
                        .map(
                          (comp) => ComponentCard(
                            component: comp,
                            onEdit: () async {
                              await _showEditComponent(context, comp);
                            },
                            onDelete: () async {
                              //Deiete
                              await _showDeleteComponentConfirmDialog(context, ref, comp);
                            },
                            onEnableToggle: () {
                              // Disable
                              _disableComponent(ref, comp);
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showAddNewComponent(BuildContext context) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: const NewComponentDialog(),
          );
        });
  }

  Future<void> _showEditComponent(BuildContext context, Component component) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: EditComponentDialog(
              component: component,
            ),
          );
        });
  }

  Future<void> _showDeleteComponentConfirmDialog(BuildContext context, WidgetRef ref, Component component) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: DeleteComponentCofirmDialog(
            onDelete: () {
              ref.read(activeProjectProvider.notifier).deleteComponent(component);
            },
          ),
        );
      },
    );
  }

  void _disableComponent(WidgetRef ref, Component component) {
    ref.read(activeProjectProvider.notifier).componentEnableToggle(component);
  }
}
