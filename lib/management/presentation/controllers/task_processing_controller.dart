import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/strings/app_strings.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/usecases/accept_task_usecase.dart';
import 'package:takatof/management/domain/usecases/reject_task_usecase.dart';
import 'package:takatof/management/presentation/controllers/task_processing_state.dart';
import 'package:takatof/management/presentation/screens/homescreens/bottom_nav_bar.dart';

class TaskProcessingController extends GetxController implements Equatable {
  final AcceptTaskUseCase acceptTaskUseCase;
  final RejectTaskUseCase rejectTaskUseCase;
  final Rx<TaskProcessingState> taskProcessingState;
  final int taskId;

  TaskProcessingController({
    required this.acceptTaskUseCase,
    required this.rejectTaskUseCase,
    required this.taskProcessingState,
    required this.taskId,
  });

  acceptTask() async {
    taskProcessingState.value = taskProcessingState.value
        .copyWith(taskProcessingState: RequestState.loading);
    final result = await acceptTaskUseCase(taskId);

    result.fold(
        (l) => taskProcessingState.value = taskProcessingState.value.copyWith(
              taskProcessingMessage: l.message,
              taskProcessingState: RequestState.error,
            ), (r) {
      return taskProcessingState.value = taskProcessingState.value.copyWith(
          taskProcessingMessage: "success",
          taskProcessingState: RequestState.loaded,
          taskProcessingResponse: r);
    });
  }

  rejectTask()async{
    taskProcessingState.value = taskProcessingState.value
        .copyWith(taskProcessingState: RequestState.loading);
    final result = await rejectTaskUseCase(taskId);

    result.fold(
            (l) => taskProcessingState.value = taskProcessingState.value.copyWith(
          taskProcessingMessage: l.message,
          taskProcessingState: RequestState.error,
        ), (r) {
      return taskProcessingState.value = taskProcessingState.value.copyWith(
          taskProcessingMessage: "success",
          taskProcessingState: RequestState.loaded,
          taskProcessingResponse: r);
    });
  }

  afterResponse({required String message}) async {
    await Get.defaultDialog(
      title: message,
      middleText: " ",
      textConfirm: AppStrings.ok,
      confirmTextColor: ColorResources.white,
      buttonColor: ColorResources.greenPrimary,
      radius: 30,
      // barrierDismissible: false,
      // textCancel: 'test',
      onConfirm: () {
        Get.back();
        Get.offAll(() => BottomNavBar());
      },
      actions: [
        ElevatedButton(
          onPressed: () {
            Get.back();
            Get.delete(); // Close the dialog
          },
          child: Text("Close"),
        ),
      ],
    );
  }

  @override
  List<Object?> get props => [
        acceptTaskUseCase,
        taskProcessingState,
      ];

  @override
  bool? get stringify => throw UnimplementedError();
}
