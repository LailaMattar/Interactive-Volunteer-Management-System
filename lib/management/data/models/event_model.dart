import 'package:takatof/management/domain/entities/event.dart';

class EventModel extends Event {
  const EventModel({
    required super.id,
    required super.image,
    required super.date,
    required super.time,
    required super.place,
    required super.startRegisterDate,
    required super.finishRegisterDate,
    required super.numberVolunteer,
    required super.state,
    required super.noteAdmin,
    required super.name,
    required super.description,
    required super.isRegistered,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
      id: json['id'],
      image: json['image'],
      date: json['date'],
      time: json['time'],
      place: json['place'],
      startRegisterDate: json['start_register'],
      finishRegisterDate: json['end_register'],
      numberVolunteer: json['number_volunteer'],
      state: json['state'],
      noteAdmin: json['note_admin'],
      name: json['name'] ?? '',
      description: json['description'],
      isRegistered: json['is_registered']);

  factory EventModel.fromJsonInitiative(Map<String, dynamic> json) =>
      EventModel(
          id: json['id'],
          image: '',
          date: json['date'],
          time: json['time'],
          place: json['place'],
          startRegisterDate: json['start_register'],
          finishRegisterDate: json['end_register'],
          numberVolunteer: json['number_volunteer'],
          state: json['state'],
          noteAdmin: json['note_admin'],
          name: '',
          description: '',
          isRegistered: json['is_registered']);
}
