import 'package:equatable/equatable.dart';
import 'package:takatof/management/domain/entities/badge.dart';
import 'package:takatof/management/domain/entities/event.dart';
import 'package:takatof/management/domain/entities/point.dart';

class Profile extends Equatable {
  final int id;
  final int pointNumber;
  final String name;
  final int hourNumber;
  final String phoneNumber;
  final String profession;
  final String image;
  final List<Event> events;
  final List<Badge> badges;
  final List<AppPoint> points;

  const Profile(
      {required this.id,
      required this.pointNumber,
      required this.name,
      required this.hourNumber,
      required this.phoneNumber,
      required this.image,
      required this.events,
      required this.badges,
      required this.points,
      required this.profession});

  @override
  List<Object?> get props => [
        id,
        pointNumber,
        name,
        hourNumber,
        phoneNumber,
        image,
        events,
        badges,
        points,
      ];
}
