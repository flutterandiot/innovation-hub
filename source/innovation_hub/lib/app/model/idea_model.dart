// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../shared/user.dart';

enum SITTechniques {
  taskUnification,
  substraction,
  multiplication,
  division,
  attributeDependency,
}

class Idea {
  String id;
  String concept;
  String name;
  int rating;
  int benefit;
  SITTechniques method;
  String componentId;
  List<String> attributeIds;
  String createdAt;
  User createdBy;
  Idea({
    required this.id,
    required this.concept,
    required this.name,
    required this.rating,
    required this.benefit,
    required this.method,
    required this.componentId,
    required this.attributeIds,
    required this.createdAt,
    required this.createdBy,
  });

  Idea copyWith({
    String? id,
    String? concept,
    String? name,
    int? rating,
    int? benefit,
    SITTechniques? method,
    String? componentId,
    List<String>? attributeIds,
    String? createdAt,
    User? createdBy,
  }) {
    return Idea(
      id: id ?? this.id,
      concept: concept ?? this.concept,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      benefit: benefit ?? this.benefit,
      method: method ?? this.method,
      componentId: componentId ?? this.componentId,
      attributeIds: attributeIds ?? this.attributeIds,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'concept': concept,
      'name': name,
      'rating': rating,
      'benefit': benefit,
      'method': method.name,
      'componentId': componentId,
      'attributeIds': attributeIds,
      'createdAt': createdAt,
      'createdBy': createdBy.toMap(),
    };
  }

  // factory Idea.fromMap(Map<String, dynamic> map) {
  //   return Idea(
  //     id: map['id'] as String,
  //     name: map['name'] as String,
  //     rating: map['rating'] as int,
  //     benefit: map['benefit'] as int,
  //     method: SITTechniques.values.byName(map['method']),
  //     componentId: map['componentId'] as String,
  //     attributeIds: List<String>.from((map['attributeIds'] as List<String>)),
  //     createdAt: map['createdAt'],
  //     createdBy: User.fromMap(map['createdBy']),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory Idea.fromJson(String source) => Idea.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() {
  //   return 'Idea(id: $id, name: $name, rating: $rating, benefit: $benefit, method: $method, componentId: $componentId, attributeIds: $attributeIds, createdAt: $createdAt, createdBy: $createdBy)';
  // }

  @override
  bool operator ==(covariant Idea other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.concept == concept &&
        other.name == name &&
        other.rating == rating &&
        other.benefit == benefit &&
        other.method == method &&
        other.componentId == componentId &&
        listEquals(other.attributeIds, attributeIds) &&
        other.createdAt == createdAt &&
        other.createdBy == createdBy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        concept.hashCode ^
        name.hashCode ^
        rating.hashCode ^
        benefit.hashCode ^
        method.hashCode ^
        componentId.hashCode ^
        attributeIds.hashCode ^
        createdAt.hashCode ^
        createdBy.hashCode;
  }

  factory Idea.fromMap(Map<String, dynamic> map) {
    return Idea(
      id: map['id'] as String,
      concept: map['concept'] as String,
      name: map['name'] as String,
      rating: map['rating'] as int,
      benefit: map['benefit'] as int,
      method: SITTechniques.values.byName(map['method']), // Updated manually
      componentId: map['componentId'] as String,
      attributeIds: List<String>.from(
        (map['attributeIds'] as List<String>),
      ),
      createdAt: map['createdAt'], // Updated manually
      createdBy: User.fromMap(map['createdBy']), // Updated manually
    );
  }

  String toJson() => json.encode(toMap());

  factory Idea.fromJson(String source) => Idea.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Idea(id: $id, concept: $concept, name: $name, rating: $rating, benefit: $benefit, method: $method, componentId: $componentId, attributeIds: $attributeIds, createdAt: $createdAt, createdBy: $createdBy)';
  }
}
