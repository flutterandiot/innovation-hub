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

import '../model/attribute_model.dart';
import '../model/component_model.dart';
import '../model/project_model.dart';

part 'project_provider.g.dart';

@riverpod
class Projects extends _$Projects {
  @override
  List<Project> build() {
    return Project.sampleProjects;
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
        updatedAt: '',
        createdBy: User.demoUser1,
        team: [],
        type: ProjectType.product.name,
        components: [],
        favorite: false,
      );

  void setProject(Project project) {
    state = project;
  }

  void updateProject(Project withProject) {
    state = state.copyWith(
      id: withProject.id,
      name: withProject.name,
      description: withProject.description,
      createdAt: withProject.createdAt,
      favorite: withProject.favorite,
      createdBy: withProject.createdBy,
      team: withProject.team,
      updatedAt: withProject.updatedAt,
      type: withProject.type,
      components: withProject.components,
      ideas: withProject.ideas,
    );
  }

  void addComponentToProject(Component component) {
    var prj = state;
    prj.components.add(component);
    state = state.copyWith(
      components: prj.components,
    );
  }

  void updateComponentToProject(Component component) {
    var prj = state;
    bool found = false;
    int i = 0;
    final len = prj.components.length;
    //Check internal
    while (!found && i < len) {
      final comp = prj.components[i];
      if (comp.id == component.id) {
        //Remove old one
        prj.components.removeAt(i);
        // insert update one
        prj.components.insert(i, component);
        state = state.copyWith(
          components: prj.components,
        );
        found = true;
      }
      i++;
    }
  }

  void deleteComponentFromProject(Component component) {
    var prj = state;
    bool found = false;
    found = prj.components.contains(component);
    if (found) {
      prj.components.removeWhere((element) => element.id == component.id);
      state = state.copyWith(
        components: prj.components,
      );
    }
  }

  void componentEnableToggle(Component component) {
    var prj = state;
    bool found = false;
    int i = 0;
    final len = prj.components.length;
    while (!found && i < len) {
      final comp = prj.components[i];
      if (comp.id == component.id) {
        //Remove old one
        prj.components[i].enabled = !prj.components[i].enabled;
        // insert update one
        state = state.copyWith(
          components: prj.components,
        );
        found = true;
      }
      i++;
    }
  }

  void addAttribute(Component component, Attribute attribute) {
    var prj = state;
    bool found = false;
    int i = 0;
    final len = prj.components.length;
    while (!found && i < len) {
      final comp = prj.components[i];
      if (comp.id == component.id) {
        //Remove old one
        prj.components[i].attributes.add(attribute);
        // insert update one
        state = state.copyWith(
          components: prj.components,
        );
        found = true;
      }
      i++;
    }
  }

  void updateAttribute(Component component, Attribute attribute) {
    bool found = false;
    int i = 0;
    final attributeList = component.attributes;
    final len = attributeList.length;
    debugPrint('update attribute for total: $len');
    // Find attribute to update
    while (!found && i < len) {
      final attr = attributeList[i];
      debugPrint('Check attr ${attr.toString()}');
      debugPrint('Attr to update: ${attribute.toString()}');
      if (attr.id == attribute.id) {
        // Remove
        attributeList.removeAt(i);
        //Insert
        attributeList.insert(i, attribute);

        found = true; // set to true to stop the loop
        debugPrint('update attribute at $i');
      }
      i++;
    }
    //Update component
    updateComponentToProject(component);
  }
}

// @Riverpod(keepAlive: true)

// /// A provider to manage show/hide secondbody  view
// class ShowSecondaryBody extends _$ShowSecondaryBody {
//   @override
//   bool build() {
//     return false;
//   }

//   /// Set new value by [isShow]
//   void enableShowSecondaryBody(bool isShow) {
//     state = isShow;
//   }
// }
