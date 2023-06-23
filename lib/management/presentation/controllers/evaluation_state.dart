import 'package:equatable/equatable.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/entities/evaluation.dart';
import 'package:takatof/management/domain/entities/event.dart';
import 'package:takatof/management/domain/entities/volunteer.dart';

class EvaluationState extends Equatable {
  MyEvaluation? evaluation;
  final RequestState state;
  final RequestState sendState;
  final String message;

   EvaluationState(
      {this.evaluation ,
      this.state = RequestState.loading,
      this.sendState = RequestState.wait,
      this.message = ''});

  EvaluationState copyWith({
    MyEvaluation? evaluation,
    RequestState? state,
    RequestState? sendState,
    String? message,
  }) {
    return EvaluationState(
        evaluation: evaluation ,
        state: state ?? this.state,
        sendState: sendState ?? this.sendState,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [
        evaluation,
        state,
        sendState,
        message,
      ];
}
