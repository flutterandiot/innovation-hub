// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/widgets.dart';

enum InnoMethod {
  sit,
  triz,
}

class Project {
  String id;
  String name;
  String description;
  Project({
    this.id = '',
    this.name = '',
    this.description = '',
  });

  Project copyWith({
    String? id,
    String? name,
    String? description,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) => Project.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Project(id: $id, name: $name, description: $description)';

  @override
  bool operator ==(covariant Project other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode;
}
