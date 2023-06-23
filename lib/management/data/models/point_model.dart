import 'package:takatof/management/domain/entities/point.dart';

class AppPointModel extends AppPoint {
  const AppPointModel(
      {required super.id,
      required super.amount,
      required super.evaluationName,
      required super.evaluationDescription,
      required super.eventName,
      required super.eventDate});

  factory AppPointModel.fromJson(Map<String, dynamic> json) {
print('point from json');
    return AppPointModel(
        id: json['id'],
        amount: json['number'],
        evaluationName: json['measurement']['name'],
        evaluationDescription: json['measurement']['description'],
        eventName: '',
        eventDate: json['activity']['date']);
  }
}
