import 'package:equatable/equatable.dart';
import 'package:takatof/management/domain/entities/measurement.dart';
import 'package:takatof/management/domain/entities/volunteer.dart';

class EventDetails extends Equatable {
  final int id;
  final String date;
  final String time;
  final String place;
  final String startRegister;
  final String endRegister;
  final int numberVolunteer;
  final String state;
  final String noteAdmin;
  final List<Measurement> measurements;
  final List<Volunteer> review;
  final List<Volunteer> attend;

  const EventDetails(
      {required this.id,
      required this.date,
      required this.time,
      required this.place,
      required this.startRegister,
      required this.endRegister,
      required this.numberVolunteer,
      required this.state,
      required this.noteAdmin,
      required this.measurements,
      required this.review,
      required this.attend});

  @override
  List<Object?> get props => [
        id,
        date,
        time,
        place,
        startRegister,
        endRegister,
        numberVolunteer,
        state,
        noteAdmin,
        measurements,
        review,
        attend
      ];
}
