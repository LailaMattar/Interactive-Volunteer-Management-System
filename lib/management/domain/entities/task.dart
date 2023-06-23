import 'package:equatable/equatable.dart';

class MyTask extends Equatable {
  final int id;
  final int idRequest;
  final String dateDelivery;
  final String startRegister;
  final String endRegister;
  final int numberVolunteer;
  final String state;
  final String name;
  final String description;
  final int numberHour;
  final int isFinish;
  final int numberPoint;
  final int isRegistered;

  const MyTask({
    required this.id,
    required this.dateDelivery,
    required this.startRegister,
    required this.endRegister,
    required this.numberVolunteer,
    required this.state,
    required this.name,
    required this.description,
    required this.numberHour,
    required this.idRequest,
    required this.isFinish,
    required this.numberPoint,
    required this.isRegistered,
  });

  @override
  List<Object?> get props => [
        id,
        idRequest,
        dateDelivery,
        startRegister,
        endRegister,
        numberVolunteer,
        state,
        name,
        description,
        numberVolunteer,
        isFinish,
        numberPoint,
        isRegistered,
      ];
}
