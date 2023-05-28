import 'package:equatable/equatable.dart';
import 'package:takatof/core/utils/enums.dart';

class TaskProcessingState extends Equatable {
  final String taskProcessingResponse;
  final RequestState taskProcessingState;
  final String taskProcessingMessage;

  const TaskProcessingState({
    this.taskProcessingResponse = '',
    this.taskProcessingState = RequestState.wait,
    this.taskProcessingMessage = '',
  });

  TaskProcessingState copyWith({
    String? taskProcessingResponse,
    RequestState? taskProcessingState,
    String? taskProcessingMessage,
  }) =>
      TaskProcessingState(
        taskProcessingResponse:
            taskProcessingResponse ?? this.taskProcessingResponse,
        taskProcessingState: taskProcessingState ?? this.taskProcessingState,
        taskProcessingMessage:
            taskProcessingMessage ?? this.taskProcessingMessage,
      );

  @override
  List<Object?> get props => [
        taskProcessingResponse,
        taskProcessingState,
        taskProcessingMessage,
      ];
}
