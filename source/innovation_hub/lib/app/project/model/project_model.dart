// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:innovation_hub/app/project/model/component_model.dart';

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
  ProjectType type;
  List<Component> internalComponents;
  List<Component> externalComponents;
  Project({
    required this.id,
    required this.name,
    this.type = ProjectType.product,
    required this.description,
    required this.internalComponents,
    required this.externalComponents,
  });

  Project copyWith({
    String? id,
    String? name,
    String? description,
    List<Component>? internalComponents,
    List<Component>? externalComponents,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      internalComponents: internalComponents ?? this.internalComponents,
      externalComponents: externalComponents ?? this.externalComponents,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'internalComponents': internalComponents.map((x) => x.toMap()).toList(),
      'externalComponents': externalComponents.map((x) => x.toMap()).toList(),
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      internalComponents: List<Component>.from(
        (map['internalComponents'] as List<int>).map<Component>(
          (x) => Component.fromMap(x as Map<String, dynamic>),
        ),
      ),
      externalComponents: List<Component>.from(
        (map['externalComponents'] as List<int>).map<Component>(
          (x) => Component.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) => Project.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Project(id: $id, name: $name, description: $description, internalComponents: $internalComponents, externalComponents: $externalComponents)';
  }

  @override
  bool operator ==(covariant Project other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        listEquals(other.internalComponents, internalComponents) &&
        listEquals(other.externalComponents, externalComponents);
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ description.hashCode ^ internalComponents.hashCode ^ externalComponents.hashCode;
  }
}
