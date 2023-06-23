import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatof/core/error/app_error_widget.dart';
import 'package:takatof/core/services/services_locator.dart';
import 'package:takatof/core/ui/app_ui.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/presentation/component/my_app_bar.dart';
import 'package:takatof/management/presentation/controllers/new_task_controller.dart';
import 'package:takatof/management/presentation/controllers/task_state.dart';
import 'package:takatof/management/presentation/screens/drawer/tasks/tasks_tab.dart';

class NewTaskListScreen extends StatelessWidget {
  NewTaskListScreen({Key? key}) : super(key: key);
  late NewTaskController controller;

  @override
  Widget build(BuildContext context) {
    Get.delete<NewTaskController>();
    controller = Get.put(
        NewTaskController(
            newTaskUseCase: sl(),
            state: const TaskState(
                tasksState: RequestState.loading).obs
        )
    );
    return Scaffold(
      // appBar: MyAppBar.titledAppBar(title: 'المهمات الجديدة'),
      body: Obx(
            () {
          switch (controller.state.value.tasksState) {
            case RequestState.loading:
              return AppUi.loading();
            case RequestState.error:
              return AppErrorWidget.error(
                  message: controller.state.value.tasksMessage,
                  onTap: (){
                    controller.getNewTask();
                  }
              );
            case RequestState.wait:
              return Container();
            case RequestState.loaded:
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TasksTab(tasks: controller.state.value.tasks,),
              );
          }
        },
      ),
    );
  }
}
