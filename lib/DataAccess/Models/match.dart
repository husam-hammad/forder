// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flashorder/DataAccess/Models/team.dart';

class Match {
  final int id;
  final Team team1;
  final Team team2;
  final String date;
  final String time;
  final String result;
  final String link;
  final String compLink;
  final int live;
  final int today;
  final int tomorrow;
  Match({
    required this.id,
    required this.team1,
    required this.team2,
    required this.date,
    required this.time,
    required this.result,
    required this.link,
    required this.compLink,
    required this.live,
    required this.today,
    required this.tomorrow,
  });

  factory Match.fromMap(Map<String, dynamic> map) {
    return Match(
        id: map['id'] as int,
        team1: Team.fromMap(map['team1'] as Map<String, dynamic>),
        team2: Team.fromMap(map['team2'] as Map<String, dynamic>),
        date: map['date'] ?? "",
        time: map['time'] ?? "",
        result: map['result'] ?? "",
        link: map['link'] ?? "",
        compLink: map['comp_link'] ?? "",
        live: map['live'] ?? 0,
        today: map['today'] ?? 0,
        tomorrow: map['tomorrow'] ?? 0);
  }

  factory Match.fromJson(String source) =>
      Match.fromMap(json.decode(source) as Map<String, dynamic>);
}
