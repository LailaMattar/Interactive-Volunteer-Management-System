import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/error/app_error_widget.dart';
import 'package:takatof/core/services/services_locator.dart';
import 'package:takatof/core/strings/app_strings.dart';
import 'package:takatof/core/ui/app_ui.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/data/datasource/management_remote_datasource.dart';
import 'package:takatof/management/data/repositories/management_repository.dart';
import 'package:takatof/management/domain/repositories/base_management_repository.dart';
import 'package:takatof/management/domain/usecases/get_my_events_usecase.dart';
import 'package:takatof/management/presentation/component/my_app_bar.dart';
import 'package:takatof/management/presentation/controllers/my_events_controller.dart';
import 'package:takatof/management/presentation/controllers/my_events_state.dart';
import 'package:takatof/management/presentation/screens/drawer/myevents/my_events_tab.dart';

class AdminEventsScreen extends StatelessWidget {
  AdminEventsScreen({Key? key,required}) : super(key: key);
  late MyEventsController controller;

  @override
  Widget build(BuildContext context) {
    BaseManagementDataSource baseManagementDataSource = ManagementDataSource();
    BaseManagementRepository baseManagementRepository = ManagementRepository(baseManagementDataSource);
    GetMyEventUseCase getMyEventUseCase = GetMyEventUseCase(baseManagementRepository);
    controller = Get.put(MyEventsController(
        getMyEventUseCase: getMyEventUseCase,
        getAdminEventUseCase: sl(),
        myEventState: const MyEventState(
            myEventsState: RequestState.loading
        ).obs
    ));
    controller.getAdminEvent();
    return Scaffold(
      appBar: MyAppBar.titledAppBar(title: 'فعاليات المشرف'),
      body: Obx(
              (){
            switch(controller.myEventState.value.myEventsState){

              case RequestState.loading:
                return AppUi.loading();
              case RequestState.error:
                return AppErrorWidget.error(
                    message:
                    controller.myEventState.value.myEventsMessage,
                    onTap: () {
                      controller.getAdminEvent();
                    });
              case RequestState.wait:
                return Container();
              case RequestState.loaded:
                return DefaultTabController(
                  length: 3,
                  child: Padding(
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
                                text: 'جاري التسجيل',
                              ),
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
                                MyEventsTab(events: controller.myEventState.value.myEventsState1,isMyState:true,isAdminState:true),
                                MyEventsTab(events: controller.myEventState.value.myEventsState2,isMyState:true,isAdminState:true),
                                MyEventsTab(events: controller.myEventState.value.myEventsState3,isMyState:true,isAdminState:true),
                              ],
                            ))
                      ],
                    ),
                  ),
                );
            }
          }),
    );
  }
}
