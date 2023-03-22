// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class User {
  final String id;
  String name;
  String others;
  User({
    required this.id,
    required this.name,
    required this.others,
  });

  User copyWith({
    String? id,
    String? name,
    String? others,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      others: others ?? this.others,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'others': others,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      others: map['others'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(id: $id, name: $name, others: $others)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.others == others;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ others.hashCode;

  static final dummyUser = User(
    id: UniqueKey().toString().replaceAll('#', '').replaceAll('[', '').replaceAll(']', ''),
    name: 'Admin',
    others: 'other info',
  );
}
