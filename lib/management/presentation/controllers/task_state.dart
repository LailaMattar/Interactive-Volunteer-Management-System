import 'package:equatable/equatable.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/entities/task.dart';

class TaskState extends Equatable {
  final List<MyTask> tasks;
  final List<MyTask> inProgressTasks;
  final List<MyTask> finishedTasks;
  final RequestState tasksState;
  final String tasksMessage;

  const TaskState(
      {this.tasks = const [],
      this.inProgressTasks = const [],
      this.finishedTasks = const [],
      this.tasksState = RequestState.loading,
      this.tasksMessage = ''});

  TaskState copyWith({
    List<MyTask>? tasks,
    List<MyTask>? inProgressTasks,
    List<MyTask>? finishedTasks,
    RequestState? tasksState,
    String? tasksMessage,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      inProgressTasks: inProgressTasks ?? this.inProgressTasks,
      finishedTasks: finishedTasks ?? this.finishedTasks,
      tasksState: tasksState ?? this.tasksState,
      tasksMessage: tasksMessage ?? this.tasksMessage,
    );
  }

  @override
  List<Object?> get props => [
        tasks,
        inProgressTasks,
        finishedTasks,
        tasksState,
        tasksMessage,
      ];
}
