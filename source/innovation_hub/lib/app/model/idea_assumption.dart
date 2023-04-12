// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum HypothesisType {
  feasible,
  desirable,
  viable,
}

class IdeaAssumption {
  /// id of the assumption
  String id;

  /// This idea is good or bad
  bool isGood;

  /// If it is good, the level of how good it is, 1: lowest, 5: highest
  int level;

  /// Description, comment of the idea hypothesis
  String description;

  /// Type of hypothesis from [HypothesisType] enum
  HypothesisType type;
  IdeaAssumption({
    this.id = '',
    this.isGood = true,
    this.level = 1,
    this.description = '',
    required this.type,
  });

  IdeaAssumption copyWith({
    String? id,
    bool? isGood,
    int? level,
    String? description,
    HypothesisType? type,
  }) {
    return IdeaAssumption(
      id: id ?? this.id,
      isGood: isGood ?? this.isGood,
      level: level ?? this.level,
      description: description ?? this.description,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'isGood': isGood,
      'level': level,
      'description': description,
      'type': type.name,
    };
  }

  factory IdeaAssumption.fromMap(Map<String, dynamic> map) {
    return IdeaAssumption(
      id: map['id'] as String,
      isGood: map['isGood'] as bool,
      level: map['level'] as int,
      description: map['description'] as String,
      type: HypothesisType.values.byName(map['type']),
    );
  }

  String toJson() => json.encode(toMap());

  factory IdeaAssumption.fromJson(String source) => IdeaAssumption.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'IdeaAssumption(id: $id, isGood: $isGood, level: $level, description: $description, type: $type)';
  }

  @override
  bool operator ==(covariant IdeaAssumption other) {
    if (identical(this, other)) return true;

    return other.id == id && other.isGood == isGood && other.level == level && other.description == description && other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^ isGood.hashCode ^ level.hashCode ^ description.hashCode ^ type.hashCode;
  }
}
