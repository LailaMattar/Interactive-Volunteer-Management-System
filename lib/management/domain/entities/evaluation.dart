import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:takatof/management/domain/entities/event.dart';
import 'package:takatof/management/domain/entities/measurement.dart';
import 'package:takatof/management/domain/entities/volunteer.dart';

class MyEvaluation extends Equatable {
  final Volunteer volunteer;
  final Event event;
  final List<Measurement> bools;
  final List<Measurement> ints;

  const MyEvaluation(
      {required this.volunteer,
      required this.event,
      required this.bools,
      required this.ints});

  @override
  List<Object?> get props => [
        volunteer,
        event,
        bools,
        ints,
      ];
}
