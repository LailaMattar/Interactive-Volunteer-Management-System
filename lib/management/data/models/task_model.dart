import 'package:takatof/management/domain/entities/task.dart';

class MyTaskModel extends MyTask {
  const MyTaskModel(
      {required super.id,
      required super.dateDelivery,
      required super.startRegister,
      required super.endRegister,
      required super.numberVolunteer,
      required super.state,
      required super.name,
      required super.description,
      required super.numberHour});

  factory MyTaskModel.fromJson(Map<String, dynamic> json) => MyTaskModel(
      id: json['id'],
      dateDelivery: json['date_delivery'],
      startRegister: json['start_register'],
      endRegister: json['end_register'],
      numberVolunteer: json['number_volunteer'],
      state: json['state'],
      name: json['name'],
      description: json['description'],
      numberHour: json['number_hour']);
}
