// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:innovation_hub/app/project/model/component_model.dart';

import '../../shared/user.dart';

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
  User createdBy;
  List<User> team;

  String type;
  List<Component> components;
  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.createdBy,
    required this.team,
    required this.type,
    required this.components,
  });

  Project copyWith({
    String? id,
    String? name,
    String? description,
    String? createdAt,
    User? createdBy,
    List<User>? team,
    String? type,
    List<Component>? components,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      team: team ?? this.team,
      type: type ?? this.type,
      components: components ?? this.components,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'createdAt': createdAt,
      'createdBy': createdBy.toMap(),
      'team': team.map((x) => x.toMap()).toList(),
      'type': type,
      'components': components.map((x) => x.toMap()).toList(),
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      createdAt: map['createdAt'] as String,
      createdBy: User.fromMap(map['createdBy'] as Map<String, dynamic>),
      team: List<User>.from(
        (map['team'] as List<int>).map<User>(
          (x) => User.fromMap(x as Map<String, dynamic>),
        ),
      ),
      type: map['type'] as String,
      components: List<Component>.from(
        (map['components'] as List<int>).map<Component>(
          (x) => Component.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) => Project.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Project(id: $id, name: $name, description: $description, createdAt: $createdAt, createdBy: $createdBy, team: $team, type: $type, components: $components)';
  }

  @override
  bool operator ==(covariant Project other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.createdBy == createdBy &&
        listEquals(other.team, team) &&
        other.type == type &&
        listEquals(other.components, components);
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ description.hashCode ^ createdAt.hashCode ^ createdBy.hashCode ^ team.hashCode ^ type.hashCode ^ components.hashCode;
  }
}
