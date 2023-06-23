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
    required super.isAdmin,
    required super.attend,
    required super.adminName,
    required super.numberDay,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      image: json['initiative']['image'] ,
      date: json['date'],
      time: json['time'],
      place: json['place'],
      startRegisterDate: json['start_register'],
      finishRegisterDate: json['end_register'],
      numberVolunteer: json['number_volunteer'],
      state: json['state'],
      noteAdmin: json['note_admin'],
      name: json['initiative']['name'] ?? '',
      description: json['initiative']['description'],
      isRegistered: json['is_register'] ?? 0,
      isAdmin: json['is_admin'] ?? 0,
      attend: json['attend'] ?? 0,
      adminName: json['name_admin'] ??
// (json['admin']['first_name'] + json['last_name']) ??
          '',
      numberDay: json['number_day'] ?? 0,
    );
  }

  factory EventModel.fromJsonInitiative(Map<String, dynamic> json) =>
      EventModel(
        id: json['id'],
        image: '',
        date: json['date']??'',
        time: json['time']??'',
        place: json['place']??'',
        startRegisterDate: json['start_register']??'',
        finishRegisterDate: json['end_register']??'',
        numberVolunteer: json['number_volunteer']??'',
        state: json['state']??'1',
        noteAdmin: json['note_admin']??'',
        name: '',
        description: '',
        isRegistered: json['is_registered']??2,
        isAdmin: json['is_admin']??2,
        attend: json['attend'] ?? 0,
        adminName:
            ('ليلى مطر') ,
        numberDay: json['number_day'] ?? 0,
      );

  factory EventModel.fromJsonEvaluation(Map<String, dynamic> json) {
    return EventModel(
        id: json['id'],
        image: 'image',
        date: json['date'],
        time: json['time'],
        place: 'place',
        startRegisterDate: 'startRegisterDate',
        finishRegisterDate: 'finishRegisterDate',
        numberVolunteer: 0,
        state: 'state',
        noteAdmin: 'noteAdmin',
        name: json['name'],
        description: 'description',
        isRegistered: 0,
        isAdmin: 0,
        attend: 0,
        adminName: 'adminName',
        numberDay: 0);
  }
}
