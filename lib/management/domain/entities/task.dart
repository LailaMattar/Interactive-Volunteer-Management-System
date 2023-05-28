import 'package:equatable/equatable.dart';

class MyTask extends Equatable {
  final int id;
  final String dateDelivery;
  final String startRegister;
  final String endRegister;
  final int numberVolunteer;
  final String state;
  final String name;
  final String description;
  final int numberHour;

  const MyTask(
      {required this.id,
      required this.dateDelivery,
      required this.startRegister,
      required this.endRegister,
      required this.numberVolunteer,
      required this.state,
      required this.name,
      required this.description,
      required this.numberHour});

  @override
  List<Object?> get props => [
    id,
    dateDelivery,
    startRegister,
    endRegister,
    numberVolunteer,
    state,
    name,
    description,
    numberVolunteer,
  ];
}
