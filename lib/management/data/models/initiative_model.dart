import 'package:takatof/management/data/models/event_model.dart';
import 'package:takatof/management/domain/entities/Initiative.dart';

class InitiativeModel extends Initiative {
  const InitiativeModel({
    required super.id,
    required super.name,
    required super.image,
    required super.numberVolunteer,
    required super.description,
    required super.events,
  });

  factory InitiativeModel.fromJson(Map<String, dynamic> json) {
    return InitiativeModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      numberVolunteer: json['number_volunteer'],
      description: json['description'],
      events: List<EventModel>.from((json['activities'] ?? [])
          .map((object) => EventModel.fromJsonInitiative(object))),
    );
  }
}
