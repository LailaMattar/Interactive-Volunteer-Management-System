import 'package:equatable/equatable.dart';
import 'package:takatof/core/utils/enums.dart';

class EvaluationSaveState extends Equatable {
  final RequestState state;
  final RequestState sendState;
  final String message;

  EvaluationSaveState(
      {
      this.state = RequestState.loading,
      this.sendState = RequestState.wait,
      this.message = ''});

  EvaluationSaveState copyWith({
    RequestState? state,
    RequestState? sendState,
    String? message,
  }) {
    return EvaluationSaveState(
        state: state ?? this.state,
        sendState: sendState ?? this.sendState,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [
        state,
        sendState,
        message,
      ];
}
