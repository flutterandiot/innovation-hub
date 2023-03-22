// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Attribute {
  String id;
  String name;
  String description;
  String comment;
  int importance;
  Attribute({
    required this.id,
    required this.name,
    required this.description,
    required this.comment,
    required this.importance,
  });

  Attribute copyWith({
    String? id,
    String? name,
    String? description,
    String? comment,
    int? importance,
  }) {
    return Attribute(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      comment: comment ?? this.comment,
      importance: importance ?? this.importance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'comment': comment,
      'importance': importance,
    };
  }

  factory Attribute.fromMap(Map<String, dynamic> map) {
    return Attribute(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      comment: map['comment'] as String,
      importance: map['importance'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Attribute.fromJson(String source) => Attribute.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Attribute(id: $id, name: $name, description: $description, comment: $comment, importance: $importance)';
  }

  @override
  bool operator ==(covariant Attribute other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.description == description && other.comment == comment && other.importance == importance;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ description.hashCode ^ comment.hashCode ^ importance.hashCode;
  }
}
