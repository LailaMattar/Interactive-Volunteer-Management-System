import 'package:takatof/management/domain/entities/badge.dart';

class BadgeModel extends Badge {
  const BadgeModel(
      {required super.id,
      required super.name,
      required super.description,
      required super.image});

  factory BadgeModel.fromJson(Map<String, dynamic> json) {
    print('badge from json');
    return BadgeModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        image: json['image']);
  }
}
