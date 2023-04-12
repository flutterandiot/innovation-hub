import 'package:flutter/material.dart';
import 'package:innovation_hub/app/model/component_model.dart';
import 'package:innovation_hub/app/provider/project_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'component_controller.g.dart';

/// Keep alive to keep the component works on many screen
@Riverpod(
  keepAlive: true,
  dependencies: [ActiveProject],
)
class ComponentController extends _$ComponentController {
  @override
  Component? build() => null;

  /// Add [comp] to [componentsProvider]
  void _addToList(Component comp) {
    ref.read(componentsProvider.notifier).add(comp);
  }

  void set(Component comp) => state = comp;

  /// Create a component for project,
  /// Add [comp] to  [componentsProvider]
  void create(Component comp) {
    _addToList(comp);
  }

  /// Update [comp] to the list, in [componentsProvider]
  void update(Component comp) {
    ref.read(componentsProvider.notifier).update(comp);
  }

  void enableToggle(Component comp) {
    comp.enabled = !comp.enabled;
    update(comp);
  }

  void delete(Component comp) {
    ref.read(componentsProvider.notifier).remove(comp);
  }
}

@Riverpod(
  keepAlive: true,
  dependencies: [ActiveProject],
)
class Components extends _$Components {
  @override
  List<Component> build() => ref.watch(activeProjectProvider).components;

  /// Add [comp] to component list provider and update it to project [activeProjectProvider]

  void add(Component comp) {
    state = [...state, comp];
    // Update to current project
    _updateToProject();
  }

  void update(Component comp) {
    // Find the component with the same id, if found, return the [comp] else return its members
    state = [
      for (final mComp in state)
        // If found, return a copy,

        if (mComp.id == comp.id)
          //we can use mComp.copyWith()
          // mComp.copyWith(
          //   id: comp.id,
          //   name: comp.name,
          //   importance: comp.importance,
          //   isInternal: comp.isInternal,
          //   description: comp.description,
          //   attributes: comp.attributes,
          //   enabled: comp.enabled,
          // )
          //Or less code, use fromMap
          comp
        // Not found, return its member
        else
          mComp
    ];
    _updateToProject();
  }

  void remove(Component comp) {
    state = state.where((mComp) => mComp.id == comp.id).toList();
    _updateToProject();
  }

  void _updateToProject() {
    ref.read(activeProjectProvider).components = state;
  }

  Component? findWithId(String compId) {
    try {
      return state.firstWhere((mComp) => mComp.id == compId);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}

@riverpod
int componentIndex(ComponentIndexRef ref) {
  return throw UnimplementedError();
}
