// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:innovation_hub/utils/app_utils.dart';

class User {
  final String id;
  String name;
  String others;
  String avatar;
  User({
    required this.id,
    required this.name,
    required this.others,
    required this.avatar,
  });

  User copyWith({
    String? id,
    String? name,
    String? others,
    String? avatar,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      others: others ?? this.others,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'others': others,
      'avatar': avatar,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      others: map['others'] as String,
      avatar: map['avatar'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, others: $others, avatar: $avatar)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.others == others && other.avatar == avatar;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ others.hashCode ^ avatar.hashCode;
  }

  static final demoUser1 = User(
    id: AppUtilities.getUid(),
    name: 'Demo',
    others: 'other info',
    avatar: 'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2080&q=80',
  );
  static final demoUser2 = User(
    id: AppUtilities.getUid(),
    name: 'Anna',
    others: 'other info',
    avatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=4140&q=80',
  );
}
