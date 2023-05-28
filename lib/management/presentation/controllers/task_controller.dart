import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/entities/task.dart';
import 'package:takatof/management/domain/usecases/get_my_tasks_uecase.dart';
import 'package:takatof/management/presentation/controllers/task_state.dart';

class TaskController extends GetxController implements Equatable {
  final GetMyTasksUseCase getMyTasksUseCase;
  Rx<TaskState> state;

  TaskController({required this.getMyTasksUseCase, required this.state});

  getMyTasks() async {
    state.value = state.value.copyWith(tasksState: RequestState.loading);
    final result = await getMyTasksUseCase(const NoParameters());

    result.fold(
        (l) => state.value = state.value.copyWith(
              tasksMessage: l.message,
              tasksState: RequestState.error,
            ), (r) {
      List<MyTask> tasks = [];
      List<MyTask> inProgressTasks = [];
      List<MyTask> finishedTasks = [];

      for (int i = 0; i < r.length; i++) {
        if (r[i].state == '1') {
          tasks.add(r[i]);
        } else if (r[i].state == '2') {
          inProgressTasks.add(r[i]);
        } else {
          finishedTasks.add(r[i]);
        }
      }
      return state.value = state.value.copyWith(
          tasksMessage: "success",
          tasksState: RequestState.loaded,
          tasks: tasks,
          inProgressTasks: inProgressTasks,
          finishedTasks: finishedTasks);
    });
  }

  @override
  void onInit() {
    super.onInit();
    getMyTasks();
  }

  @override
  List<Object?> get props => [
        getMyTasksUseCase,
        state,
      ];

  @override
  bool? get stringify => throw UnimplementedError();
}
