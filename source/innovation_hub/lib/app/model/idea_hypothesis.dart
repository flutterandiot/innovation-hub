import 'dart:convert';

class IdeaHypothesis {
  /// This idea is good or bad
  bool isGood;

  /// If it is good, the level of how good it is, 1: lowest, 5: highest
  int level;

  /// Description, comment of the idea hypothesis
  String description;
  IdeaHypothesis({
    this.isGood = true,
    this.level = 1,
    this.description = '',
  });

  IdeaHypothesis copyWith({
    bool? isGood,
    int? level,
    String? description,
  }) {
    return IdeaHypothesis(
      isGood: isGood ?? this.isGood,
      level: level ?? this.level,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isGood': isGood,
      'level': level,
      'description': description,
    };
  }

  factory IdeaHypothesis.fromMap(Map<String, dynamic> map) {
    return IdeaHypothesis(
      isGood: map['isGood'] as bool,
      level: map['level'] as int,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory IdeaHypothesis.fromJson(String source) => IdeaHypothesis.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'IdeaHypothesis(isGood: $isGood, level: $level, description: $description)';

  @override
  bool operator ==(covariant IdeaHypothesis other) {
    if (identical(this, other)) return true;

    return other.isGood == isGood && other.level == level && other.description == description;
  }

  @override
  int get hashCode => isGood.hashCode ^ level.hashCode ^ description.hashCode;
}
