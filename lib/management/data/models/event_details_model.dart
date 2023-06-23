import 'package:takatof/management/data/models/measurement_model.dart';
import 'package:takatof/management/data/models/volunteer_model.dart';
import 'package:takatof/management/domain/entities/event_details.dart';

class EventDetailsModel extends EventDetails {
  const EventDetailsModel(
      {required super.id,
      required super.date,
      required super.time,
      required super.place,
      required super.startRegister,
      required super.endRegister,
      required super.numberVolunteer,
      required super.state,
      required super.noteAdmin,
      required super.measurements,
      required super.review,
      required super.attend});

  factory EventDetailsModel.fromJson(Map<String, dynamic> json) {
    return EventDetailsModel(
        id: json['Activity']['id'],
        date: json['Activity']['date'],
        time: json['Activity']['time'],
        place: json['Activity']['place'],
        startRegister: json['Activity']['start_register'],
        endRegister: json['Activity']['end_register'],
        numberVolunteer: json['Activity']['number_volunteer'],
        state: json['Activity']['state'],
        noteAdmin: json['Activity']['note_admin'],
        measurements: [],
        review: List<VolunteerModel>.from((json['review'] ?? [])
            .map((object) => VolunteerModel.fromJson(object))),
        attend: List<VolunteerModel>.from((json['attend'] ?? [])
            .map((object) => VolunteerModel.fromJson(object))));
  }
}
