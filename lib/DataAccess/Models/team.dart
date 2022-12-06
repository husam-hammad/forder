// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Team {
  final int id;
  final String name;
  final String flag;
  Team({
    required this.id,
    required this.name,
    required this.flag,
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'flag': flag,
    };
  }

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      id: map['id'] as int,
      name: map['name'] as String,
      flag: map['flag'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Team.fromJson(String source) => Team.fromMap(json.decode(source) as Map<String, dynamic>);

  
}
