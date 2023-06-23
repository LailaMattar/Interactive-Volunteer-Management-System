import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/error/app_error_widget.dart';
import 'package:takatof/core/strings/app_strings.dart';
import 'package:takatof/core/ui/app_ui.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/data/datasource/task_remote_datasource.dart';
import 'package:takatof/management/data/repositories/task_repository.dart';
import 'package:takatof/management/domain/repositories/base_task_repository.dart';
import 'package:takatof/management/domain/usecases/get_my_tasks_uecase.dart';
import 'package:takatof/management/presentation/component/my_app_bar.dart';
import 'package:takatof/management/presentation/controllers/task_controller.dart';
import 'package:takatof/management/presentation/controllers/task_state.dart';
import 'package:takatof/management/presentation/screens/drawer/tasks/tasks_tab.dart';

class TasksListScreen extends StatelessWidget {
  TasksListScreen({Key? key}) : super(key: key);
  late TaskController controller;

  @override
  Widget build(BuildContext context) {
    Get.delete<TaskController>();
    BaseTaskRemoteDataSource baseTaskRemoteDataSource = TaskRemoteDataSource();
    BaseTaskRepository baseTaskRepository =
        TaskRepository(baseTaskRemoteDataSource);
    GetMyTasksUseCase getMyTasksUseCase = GetMyTasksUseCase(baseTaskRepository);
    controller = Get.put(TaskController(
        getMyTasksUseCase: getMyTasksUseCase,
        state: const TaskState(tasksState: RequestState.loading).obs));
    return Scaffold(
      appBar: MyAppBar.titledAppBar(title: AppStrings.tasksList),
      body: DefaultTabController(
        length: 2,
        child: Obx(
          () {
            switch (controller.state.value.tasksState) {
              case RequestState.loading:
                return AppUi.loading();
              case RequestState.error:
                return AppErrorWidget.error(
                    message: controller.state.value.tasksMessage,
                  onTap: (){
                      controller.getMyTasks();
                  }
                );
              case RequestState.wait:
                return Container();
              case RequestState.loaded:
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: ColorResources.grey3,
                            borderRadius: BorderRadius.circular(25.0)),
                        child: TabBar(
                          indicator: BoxDecoration(
                              color: ColorResources.greenPrimary,
                              borderRadius: BorderRadius.circular(25.0)),
                          labelColor: ColorResources.white,
                          unselectedLabelColor: ColorResources.black,
                          tabs: const [
                            Tab(
                              text: 'قيد التنفيذ',
                            ),
                            Tab(
                              text: 'المنتهية',
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: TabBarView(
                        children: [
                          TasksTab(
                            tasks: controller.state.value.inProgressTasks,
                          ),
                          TasksTab(
                            tasks: controller.state.value.finishedTasks,
                          ),
                        ],
                      ))
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
