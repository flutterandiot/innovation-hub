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
import 'package:flutter/material.dart';
import 'package:innovation_hub/app/shared/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/project_models.dart';

part 'project_provider.g.dart';

@riverpod
class Projects extends _$Projects {
  @override
  List<Project> build() {
    return [];
  }

  Project? currentProject;

  void setCurrentProject(Project project) {
    debugPrint('Set current project is ${project.id}-${project.name}');
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

//NOTE -  This active project must be set keepAlive = true in order to keep its value
@Riverpod(keepAlive: true)
class ActiveProject extends _$ActiveProject {
  @override
  Project build() => Project(
        id: '',
        name: '',
        description: '',
        createdAt: '',
        createdBy: User.dummyUser,
        team: [],
        type: ProjectType.product.name,
        internalComponents: [],
        externalComponents: [],
      );

  void setProject(Project project) {
    state = project;
  }

  void addComponent(Component component) {
    var prj = state;
    if (component.isInternal) {
      prj.internalComponents.add(component);
      state = state.copyWith(
        internalComponents: prj.internalComponents,
      );
    } else {
      prj.externalComponents.add(component);
      state = state.copyWith(
        externalComponents: prj.externalComponents,
      );
    }
  }

  void updateComponent(Component component) {
    var prj = state;
    bool found = false;
    int i = 0;
    //Check internal
    while (!found) {
      final comp = prj.internalComponents[i];
      if (comp.id == component.id) {
        //Remove old one
        prj.internalComponents.removeAt(i);
        // insert update one
        prj.internalComponents.insert(i, component);
        state = state.copyWith(
          internalComponents: prj.internalComponents,
        );
        found = true;
      }
      i++;
    }
    //Check external if not found in internal

    while (!found) {
      final comp = prj.externalComponents[i];
      if (comp.id == component.id) {
        //Remove old one
        prj.externalComponents.removeAt(i);
        // insert update one
        prj.externalComponents.insert(i, component);
        state = state.copyWith(
          externalComponents: prj.externalComponents,
        );
        found = true;
      }
      i++;
    }
  }

  void deleteComponent(Component component) {
    var prj = state;
    bool found = false;
    found = prj.internalComponents.contains(component);
    if (found) {
      prj.internalComponents.removeWhere((element) => element.id == component.id);
      state = state.copyWith(
        internalComponents: prj.internalComponents,
      );
    } else {
      found = prj.externalComponents.contains(component);
      if (found) {
        prj.externalComponents.removeWhere((element) => element.id == component.id);
        state = state.copyWith(
          externalComponents: prj.externalComponents,
        );
      }
    }
  }

  void disableComponent(Component component) {
    var prj = state;
    bool found = false;
    int i = 0;
    //Check internal
    while (!found) {
      final comp = prj.internalComponents[i];
      if (comp.id == component.id) {
        //Remove old one
        prj.internalComponents[i].enabled = false;
        // insert update one
        state = state.copyWith(
          internalComponents: prj.internalComponents,
        );
        found = true;
      }
      i++;
    }

    //Check external if not found in internal
    while (!found) {
      final comp = prj.externalComponents[i];
      if (comp.id == component.id) {
        //Remove old one
        prj.externalComponents[i].enabled = false;
        // insert update one
        state = state.copyWith(
          externalComponents: prj.externalComponents,
        );
        found = true;
      }
      i++;
    }
  }
}
