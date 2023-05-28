import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/error/app_error_widget.dart';
import 'package:takatof/core/images/app_images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takatof/core/strings/app_strings.dart';
import 'package:takatof/core/ui/app_ui.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/data/datasource/management_remote_datasource.dart';
import 'package:takatof/management/data/repositories/management_repository.dart';
import 'package:takatof/management/domain/entities/event.dart';
import 'package:takatof/management/domain/entities/project.dart';
import 'package:takatof/management/domain/repositories/base_management_repository.dart';
import 'package:takatof/management/domain/usecases/get_events_usecase.dart';
import 'package:takatof/management/domain/usecases/get_projects_usecase.dart';
import 'package:takatof/management/presentation/component/event_item.dart';
import 'package:takatof/management/presentation/component/project_item.dart';
import 'package:takatof/management/presentation/component/show_more.dart';
import 'package:takatof/management/presentation/controllers/home_controller.dart';
import 'package:takatof/management/presentation/controllers/home_state.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  late HomeController homeController;
  List<Project> projects = [];

  @override
  Widget build(BuildContext context) {
    print('builddd');
    Get.delete<HomeController>();
    BaseManagementDataSource baseManagementDataSource = ManagementDataSource();
    BaseManagementRepository baseManagementRepository =
        ManagementRepository(baseManagementDataSource);

    GetProjectsUseCase getProjectsUseCase =
        GetProjectsUseCase(baseManagementRepository);
    GetEventsUseCase getEventsUseCase =
        GetEventsUseCase(baseManagementRepository);

    homeController = Get.put(HomeController(
      getProjectsUseCase: getProjectsUseCase,
      getEventsUseCase: getEventsUseCase,
      homeState: const HomeState(projectsState: RequestState.loading).obs,
    ));

    return Scaffold(
      backgroundColor: ColorResources.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            children: [
              ShowMore(onTap: () {}, title: AppStrings.takatofProjects),
              SizedBox(
                height: 125,
                width: double.infinity,
                child: Obx(() {
                  switch (homeController.homeState.value.projectsState) {
                    case RequestState.loading:
                      return const Center(child: AppUi.spinkitMain);
                    case RequestState.loaded:
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          Project project =
                              homeController.homeState.value.projects[index];
                          return ProjectItem(
                            project: project,
                            index: index,
                          );
                        },
                      );
                    case RequestState.error:
                      return AppErrorWidget.error(
                          message:
                              homeController.homeState.value.projectsMessage,
                          onTap: () {
                            homeController.getProjects();
                          });
                    case RequestState.wait:
                      return Container();
                  }
                  // return
                }),
              ),
              const SizedBox(
                height: 10,
              ),
              ShowMore(onTap: () {}, title: AppStrings.takatofEvents),
              Obx(() {
                switch (homeController.homeState.value.eventsState) {
                  case RequestState.loading:
                    return const Center(child: AppUi.spinkitMain);
                  case RequestState.loaded:
                    return ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        Event event = homeController.homeState.value.events[index];
                        return EventItem(
                          index: index,
                          event: event,
                        );
                      },
                    );
                  case RequestState.error:
                    return AppErrorWidget.error(
                        message:
                        homeController.homeState.value.eventsMessage,
                        onTap: () {
                          homeController.getEvents();
                        });
                  case RequestState.wait:
                    return Container();
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
