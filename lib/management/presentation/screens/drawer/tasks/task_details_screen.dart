import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/error/app_error_widget.dart';
import 'package:takatof/core/services/services_locator.dart';
import 'package:takatof/core/strings/app_strings.dart';
import 'package:takatof/core/ui/app_buttons.dart';
import 'package:takatof/core/ui/app_ui.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/entities/task.dart';
import 'package:takatof/management/domain/usecases/accept_task_usecase.dart';
import 'package:takatof/management/domain/usecases/reject_task_usecase.dart';
import 'package:takatof/management/presentation/component/my_app_bar.dart';
import 'package:takatof/management/presentation/controllers/task_processing_controller.dart';
import 'package:takatof/management/presentation/controllers/task_processing_state.dart';
import 'package:takatof/management/presentation/screens/homescreens/bottom_nav_bar.dart';

class TaskDetailsScreen extends StatelessWidget {
  TaskDetailsScreen({Key? key, required this.task, required this.state})
      : super(key: key);
  final MyTask task;
  final String state;
  late TaskProcessingController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(TaskProcessingController(
        acceptTaskUseCase: sl<RegisterToTaskUseCase>(),
        rejectTaskUseCase: sl<RejectTaskUseCase>(),
        taskProcessingState:
            const TaskProcessingState(
                taskProcessingState: RequestState.wait
            ).obs,
        taskId: task));

    return Scaffold(
      appBar: MyAppBar.titledAppBar(title: AppStrings.taskDetails),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // height: 100,
                  padding: const EdgeInsets.all(8),
                  decoration: AppUi.containerBoxDecoration(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              task.name,
                              style: const TextStyle(
                                color: ColorResources.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${task.numberHour} ساعات',
                              style: const TextStyle(
                                  color: ColorResources.black, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              'موعد التسليم: ${task.dateDelivery}',
                              style: const TextStyle(
                                color: ColorResources.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${task.numberPoint} نقطة',
                              style:const TextStyle(
                                  color: ColorResources.black, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        state,
                        style: const TextStyle(
                            color: ColorResources.greenPrimary, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              const Text(
                AppStrings.details,
                style: TextStyle(
                  fontSize: 18,
                  color: ColorResources.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  task.description,
                  style: const TextStyle(
                    fontSize: 15,
                    color: ColorResources.grey2,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: task.state == '1',
                child: SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: AppButtons.mainButton(
                          title: task.isRegistered == 0?'تقديم':'تم التقديم',
                          color: task.isRegistered == 0 ?ColorResources.greenPrimary:ColorResources.grey,
                          onTap: () {
                            if(task.isRegistered == 0) {
                              controller.acceptTask();
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: task.state == '2',
                child: SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: AppButtons.mainButton(
                          title: task.isFinish == 0?'طلب انهاء':'تم تقديم الطلب',
                          color: task.isFinish == 0 ?ColorResources.greenPrimary:ColorResources.grey,
                          onTap: () {
                            if(task.isFinish == 0) {
                              controller.rejectTask();
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                  (){
                    switch(controller.taskProcessingState.value.taskProcessingState){

                      case RequestState.loading:
                        return AppUi.spinkitMain;
                      case RequestState.error:
                        return AppErrorWidget.error(message: controller.taskProcessingState.value.taskProcessingMessage);
                      case RequestState.wait:
                        return Container();
                      case RequestState.loaded:
                        WidgetsBinding.instance.addPostFrameCallback((_){
                          // AppUi.showToast(message: controller.taskProcessingState.value.taskProcessingResponse);
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.success,
                            text: controller.taskProcessingState.value.taskProcessingResponse,
                            confirmBtnColor: ColorResources.greenPrimary,
                            onConfirmBtnTap: (){
                              Navigator.of(context, rootNavigator: true).pop();
                              Get.offAll(()=> BottomNavBar());
                            },
                            barrierDismissible: false,
                            confirmBtnText: 'حسناً',
                          );
                        });
                        return Container();
                    }
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
