import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/usecases/get_new_task_usecase.dart';
import 'package:takatof/management/presentation/controllers/task_state.dart';

import '../../../core/usecase/base_usecase.dart';

class NewTaskController extends GetxController implements Equatable{
  final GetNewTaskUseCase newTaskUseCase;
  Rx<TaskState> state;

  NewTaskController({required this.newTaskUseCase,required this.state});

  getNewTask()async {
    state.value = state.value.copyWith(tasksState: RequestState.loading);
    final result = await newTaskUseCase(const NoParameters());

    result.fold(
            (l) => state.value = state.value.copyWith(
          tasksMessage: l.message,
          tasksState: RequestState.error,
        ), (r) {
      return state.value = state.value.copyWith(
          tasksMessage: "success",
          tasksState: RequestState.loaded,
          tasks: r,
          inProgressTasks: [],
          finishedTasks: []);
    });
  }

  @override
  void onInit() {
    super.onInit();
    getNewTask();
  }

  @override
  List<Object?> get props => [
    newTaskUseCase,
    state,
  ];

  @override
  bool? get stringify => throw UnimplementedError();

}