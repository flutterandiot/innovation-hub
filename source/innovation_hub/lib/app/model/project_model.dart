// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:innovation_hub/app/model/component_model.dart';
import 'package:innovation_hub/app/model/idea_model.dart';
import 'package:innovation_hub/utils/app_utils.dart';

import '../shared/user.dart';

enum ProjectType {
  product,
  service,
  other,
}

enum InnoMethod {
  sit,
  triz,
}

class Project {
  String id;
  String name;
  String description;
  String createdAt;
  bool favorite;
  User createdBy;
  List<User> team;
  String updatedAt;
  String type;
  List<Component> components;
  List<Idea> ideas;
  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.favorite,
    required this.createdBy,
    required this.team,
    required this.type,
    required this.components,
    required this.ideas,
  });

  Project copyWith({
    String? id,
    String? name,
    String? description,
    String? createdAt,
    bool? favorite,
    User? createdBy,
    List<User>? team,
    String? updatedAt,
    String? type,
    List<Component>? components,
    List<Idea>? ideas,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      favorite: favorite ?? this.favorite,
      createdBy: createdBy ?? this.createdBy,
      team: team ?? this.team,
      updatedAt: updatedAt ?? this.updatedAt,
      type: type ?? this.type,
      components: components ?? this.components,
      ideas: ideas ?? this.ideas,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'createdAt': createdAt,
      'favorite': favorite,
      'createdBy': createdBy.toMap(),
      'team': team.map((x) => x.toMap()).toList(),
      'updatedAt': updatedAt,
      'type': type,
      'components': components.map((x) => x.toMap()).toList(),
      'ideas': ideas.map((x) => x.toMap()).toList(),
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      createdAt: map['createdAt'] as String,
      favorite: map['favorite'] as bool,
      createdBy: User.fromMap(map['createdBy'] as Map<String, dynamic>),
      team: List<User>.from(
        (map['team'] as List<int>).map<User>(
          (x) => User.fromMap(x as Map<String, dynamic>),
        ),
      ),
      updatedAt: map['updatedAt'] as String,
      type: map['type'] as String,
      components: List<Component>.from(
        (map['components'] as List<int>).map<Component>(
          (x) => Component.fromMap(x as Map<String, dynamic>),
        ),
      ),
      ideas: List<Idea>.from(
        (map['ideas'] as List<int>).map<Idea?>(
          (x) => Idea.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) => Project.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Project(id: $id, name: $name, description: $description, createdAt: $createdAt, favorite: $favorite, createdBy: $createdBy, team: $team, updatedAt: $updatedAt, type: $type, components: $components, ideas: $ideas)';
  }

  @override
  bool operator ==(covariant Project other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.favorite == favorite &&
        other.createdBy == createdBy &&
        listEquals(other.team, team) &&
        other.updatedAt == updatedAt &&
        other.type == type &&
        listEquals(other.components, components) &&
        listEquals(other.ideas, ideas);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        createdAt.hashCode ^
        favorite.hashCode ^
        createdBy.hashCode ^
        team.hashCode ^
        updatedAt.hashCode ^
        type.hashCode ^
        components.hashCode ^
        ideas.hashCode;
  }

  static List<Project> sampleProjects = [
    Project(
      id: AppUtilities.getUid(),
      name: 'Sample Project 1',
      description: 'Demo project',
      createdAt: AppUtilities.getTimeStampFromNow(),
      updatedAt: AppUtilities.getTimeStampFromNow(),
      createdBy: User.demoUser1,
      team: [
        User.demoUser1,
        User.demoUser2,
      ],
      type: ProjectType.product.name,
      favorite: true,
      components: [
        Component.demoComp1,
        Component.demoComp2,
        Component.demoComp3,
        Component.demoComp4,
        Component.demoComp5,
      ],
      ideas: [],
    ),
    Project(
      id: AppUtilities.getUid(),
      name: 'Sample Project 2',
      description: 'Demo project',
      createdAt: AppUtilities.getTimeStampFromNow(),
      updatedAt: AppUtilities.getTimeStampFromNow(),
      createdBy: User.demoUser1,
      team: [User.demoUser1],
      type: ProjectType.product.name,
      favorite: false,
      components: [],
      ideas: [],
    ),
    Project(
      id: AppUtilities.getUid(),
      name: 'Sample Project 3',
      description: 'Demo project',
      createdAt: AppUtilities.getTimeStampFromNow(),
      updatedAt: AppUtilities.getTimeStampFromNow(),
      createdBy: User.demoUser1,
      team: [User.demoUser1],
      type: ProjectType.product.name,
      favorite: false,
      components: [],
      ideas: [],
    ),
  ];
}
