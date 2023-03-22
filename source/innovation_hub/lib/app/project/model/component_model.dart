// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'attribute_model.dart';

class Component {
  String id;
  String name;
  int importance;
  bool isInternal;
  String description;
  List<Attribute> attributes;

  Component({
    required this.id,
    required this.name,
    required this.importance,
    required this.isInternal,
    required this.description,
    required this.attributes,
  });

  Component copyWith({
    String? id,
    String? name,
    int? importance,
    bool? isInternal,
    String? description,
    List<Attribute>? attributes,
  }) {
    return Component(
      id: id ?? this.id,
      name: name ?? this.name,
      importance: importance ?? this.importance,
      isInternal: isInternal ?? this.isInternal,
      description: description ?? this.description,
      attributes: attributes ?? this.attributes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'importance': importance,
      'isInternal': isInternal,
      'description': description,
      'attributes': attributes.map((x) => x.toMap()).toList(),
    };
  }

  factory Component.fromMap(Map<String, dynamic> map) {
    return Component(
      id: map['id'] as String,
      name: map['name'] as String,
      importance: map['importance'] as int,
      isInternal: map['isInternal'] as bool,
      description: map['description'] as String,
      attributes: List<Attribute>.from(
        (map['attributes'] as List<int>).map<Attribute>(
          (x) => Attribute.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Component.fromJson(String source) => Component.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Component(id: $id, name: $name, importance: $importance, isInternal: $isInternal, description: $description, attributes: $attributes)';
  }

  @override
  bool operator ==(covariant Component other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.importance == importance && other.isInternal == isInternal && other.description == description && listEquals(other.attributes, attributes);
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ importance.hashCode ^ isInternal.hashCode ^ description.hashCode ^ attributes.hashCode;
  }
}
