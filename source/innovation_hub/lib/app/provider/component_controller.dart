import 'package:innovation_hub/app/model/component_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/project_model.dart';

part 'component_controller.g.dart';

/// Keep alive to keep the component works on many screen
@Riverpod(keepAlive: true)
class ComponentController extends _$ComponentController {
  @override
  Component? build() => null;

  void set(Component comp) => state = comp;

  void addComponentToProject(Project toProject, Component comp) {
    toProject.components.add(comp);
  }
}
