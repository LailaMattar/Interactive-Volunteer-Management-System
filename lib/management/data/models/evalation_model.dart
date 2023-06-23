import 'package:takatof/management/data/models/event_model.dart';
import 'package:takatof/management/data/models/measurement_model.dart';
import 'package:takatof/management/data/models/volunteer_model.dart';
import 'package:takatof/management/domain/entities/evaluation.dart';

class MyEvaluationModel extends MyEvaluation {
  const MyEvaluationModel(
      {required super.volunteer,
      required super.event,
      required super.bools,
      required super.ints});

  factory MyEvaluationModel.fromJson(Map<String, dynamic> json) {
    return MyEvaluationModel(
        volunteer: VolunteerModel.fromJsonAttend(json['user']),
        event: EventModel.fromJsonEvaluation(json['activity']),
        bools: List<MeasurementModel>.from((json['measurements']['bool'] ?? [])
            .map((object) => MeasurementModel.fromJson(object))),
        ints: List<MeasurementModel>.from((json['measurements']['int'] ?? [])
            .map((object) => MeasurementModel.fromJson(object))));
  }
}
