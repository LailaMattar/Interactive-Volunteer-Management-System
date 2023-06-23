import 'package:takatof/management/data/models/badge_model.dart';
import 'package:takatof/management/data/models/event_model.dart';
import 'package:takatof/management/data/models/point_model.dart';
import 'package:takatof/management/domain/entities/event.dart';
import 'package:takatof/management/domain/entities/profile.dart';

class ProfileModel extends Profile {
  const ProfileModel(
      {required super.id,
      required super.pointNumber,
      required super.name,
      required super.hourNumber,
      required super.phoneNumber,
      required super.image,
      required super.events,
      required super.badges,
      required super.points,
      required super.profession});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['volunteer']['id'],
      pointNumber: json['volunteer']['number_point'],
      name: json['volunteer']['first_name'] +
          ' ' +
          json['volunteer']['last_name'],
      hourNumber: json['volunteer']['number_hour'],
      phoneNumber: json['volunteer']['contact_communiction']['phone'],
      profession: json['volunteer']['profession']['name'],
      image: json['volunteer']['image']??'',
      badges: List<BadgeModel>.from(
          (json['badge'] ?? []).map((object) => BadgeModel.fromJson(object))),
      points: List<AppPointModel>.from((json['details_point'] ?? [])
          .map((object) => AppPointModel.fromJson(object))),
      events: [],
    );
  }
}
