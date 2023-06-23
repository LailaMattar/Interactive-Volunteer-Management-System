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
  final int isAdmin;
  final int attend;
  final String adminName;
  final int numberDay;


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
    required this.isRegistered,
    required this.isAdmin,
    required this.attend,
    required this.adminName,
    required this.numberDay,
  });

  const Event.empty({
    this.id = 0,
    this.image = '',
    this.date = '',
    this.time = '',
    this.place = '',
    this.startRegisterDate = '',
    this.finishRegisterDate= '',
    this.numberVolunteer = 0,
    this.state = '',
    this.noteAdmin = '',
    this.name = '',
    this.description = '',
    this.isRegistered = 0,
    this.isAdmin = 0,
    this.attend = 0,
    this.adminName = '',
    this.numberDay = 0,
  });

  @override
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
    isRegistered,
    isAdmin,
    attend,
    adminName,
    numberDay
  ];

}