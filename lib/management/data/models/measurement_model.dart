import 'package:takatof/management/domain/entities/measurement.dart';

class MeasurementModel extends Measurement {
   MeasurementModel(
      {required super.id,
      required super.name,
      required super.description,
      required super.type,
      required super.value});

  factory MeasurementModel.fromJson(Map<String, dynamic> json) {
    return MeasurementModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        type: json['type'],
        value: json['value']);
  }
}
