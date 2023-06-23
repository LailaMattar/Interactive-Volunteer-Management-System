import 'package:takatof/management/domain/entities/volunteer.dart';

class VolunteerModel extends Volunteer {
  VolunteerModel({
    required super.name,
    required super.attend,
    required super.checked,
    required super.id,
    required super.isEvaluation,
    required super.image,
  });

  factory VolunteerModel.fromJson(Map<String, dynamic> json) => VolunteerModel(
        name: (json['volunteer']['first_name'] +
            ' ' +
            json['volunteer']['last_name']),
        attend: json['volunteer']['attend'] ?? 0,
        checked: json['volunteer']['checked'] ?? false,
        id: json['volunteer']['id'],
        isEvaluation: json['volunteer']['is_evaluation'],
        image: json['volunteer']['image'],
      );

factory VolunteerModel.fromJsonAttend(Map<String, dynamic> json) => VolunteerModel(
name:
json['first_name']+' '+json['last_name'],
attend: json['attend'] ?? 0,
checked: json['checked'] ?? false,
id: json['id'],
isEvaluation: json['is_evaluation']??0,
image: json['image']??'',
);
}
