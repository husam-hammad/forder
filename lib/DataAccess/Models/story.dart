import 'dart:convert';

import 'package:flashorder/DataAccess/Models/restaurent.dart';

class Story {
  late int id;
  late String image;
  late String description;
  late Restaurent? restaurent;
  Story({
    required this.id,
    required this.image,
    required this.description,
    required this.restaurent,
  });

  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      id: map['id'] as int,
      image: map['image'] ?? '',
      description: map['description'] ?? '',
      restaurent: Restaurent.fromMap(map['restaurent']),
    );
  }

  factory Story.fromJson(String source) => Story.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Story(id: $id, image: $image, description: $description, restaurent: $restaurent)';
  }
}
