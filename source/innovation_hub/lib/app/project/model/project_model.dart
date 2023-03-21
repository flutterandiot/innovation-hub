// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

enum InnoMethod {
  sit,
  triz,
}

class Project {
  String id;
  String name;
  String description;
  List<String>? internalComponents;
  List<String>? externalComponents;
  Project({
    this.id = '',
    this.name = '',
    this.description = '',
    this.internalComponents,
    this.externalComponents,
  });

  Project copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? internalComponents,
    List<String>? externalComponents,
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
      'internalComponents': internalComponents,
      'externalComponents': externalComponents,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      internalComponents: map['internalComponents'] as List<String>,
      externalComponents: map['externalComponents'] as List<String>,
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
