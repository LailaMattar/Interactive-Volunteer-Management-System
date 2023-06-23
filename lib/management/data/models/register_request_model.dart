import 'package:takatof/management/domain/entities/register_request.dart';

class RegisterRequestModel extends RegisterRequest {
  const RegisterRequestModel({
    required super.id,
    required super.eventId,
    required super.volunteerId,
    required super.state,
    required super.initiativeName,
    required super.profession,
    required super.name,
    required super.date,
  });

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    return RegisterRequestModel(
        id: json['id'],
        eventId: json['id_activity'],
        volunteerId: json['id_volunteer'],
        state: json['state'],
        initiativeName: json['name_initiative'],
        profession: json['profession '] ?? 'pros',
        name: json['first_name'] + ' ' + json['last_name'],
        date: json['date']);
  }
}
