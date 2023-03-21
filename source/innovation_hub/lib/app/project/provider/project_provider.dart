/*
* Autogenerated header by File Header Comment extension - Donna Iwan
* File:       project_provider.dart
* Created on: Fri Mar 17 2023
* Author:     Tong Vu Than Dan
*
* Copyright (c) 2023 Tong Vu Than Dan
* Website:     dantopia.vn
*
* Description: This file is ....
 */
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/project_model.dart';

part 'project_provider.g.dart';

@riverpod
class Projects extends _$Projects {
  @override
  List<Project> build() {
    return [];
  }

  Project? currentProject;

  void setCurrentProject(Project project) {
    currentProject = project;
  }

  void addProject(Project project) {
    // Since our state is immutable, we are not allowed to do `state.add(project)`.
    // Instead, we should create a new list of todos which contains the previous
    // items and the new one.
    // Using Dart's spread operator here is helpful!
    state = [...state, project];
    // No need to call "notifyListeners" or anything similar. Calling "state ="
    // will automatically rebuild the UI when necessary.
  }

  void removeProject(String projectId) {
    // Again, our state is immutable. So we're making a new list instead of
    // changing the existing list.

    state = [
      for (final prj in state)
        if (prj.id != projectId) prj
    ];
  }
}
