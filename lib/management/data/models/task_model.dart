import 'package:takatof/management/domain/entities/task.dart';

class MyTaskModel extends MyTask {
  const MyTaskModel({
    required super.id,
    required super.dateDelivery,
    required super.startRegister,
    required super.endRegister,
    required super.numberVolunteer,
    required super.state,
    required super.name,
    required super.description,
    required super.numberHour,
    required super.idRequest,
    required super.isFinish,
    required super.numberPoint,
    required super.isRegistered,
  });

  factory MyTaskModel.fromJson(Map<String, dynamic> json) {
    return MyTaskModel(
      id: json['id'],
      dateDelivery: json['date_delivery']??'',
      startRegister: json['start_register']??'',
      endRegister: json['end_register']??'',
      numberVolunteer: json['number_volunteer'],
      state: json['state'],
      name: json['name'],
      description: json['description'],
      numberHour: json['number_hour'],
      idRequest: json['id_request'] ?? 0,
      isFinish: json['is_finish'] ?? 0,
      numberPoint: json['number_point'] ?? 0,
      isRegistered: json['is_registered'] ?? 0,
    );
  }
}
