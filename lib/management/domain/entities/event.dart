import 'package:equatable/equatable.dart';

class Event extends Equatable{
  final int id;
  final String image;
  final String date;
  final String time;
  final String place;
  final String startRegisterDate;
  final String finishRegisterDate;
  final int numberVolunteer;
  final String state;
  final String noteAdmin;
  final String name;
  final String description;
  final int isRegistered;


  const Event({
    required this.id,
    required this.image,
    required this.date,
    required this.time,
    required this.place,
    required this.startRegisterDate,
    required this.finishRegisterDate,
    required this.numberVolunteer,
    required this.state,
    required this.noteAdmin,
    required this.name,
    required this.description,
    required this.isRegistered
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    image,
    date,
    time,
    place,
    startRegisterDate,
    finishRegisterDate,
    numberVolunteer,
    state,
  ];

}