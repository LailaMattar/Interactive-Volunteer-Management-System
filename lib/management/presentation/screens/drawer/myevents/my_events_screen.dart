import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/error/app_error_widget.dart';
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

class MyEventsScreen extends StatelessWidget {
  MyEventsScreen({Key? key}) : super(key: key);
  late MyEventsController controller;

  final List<Widget> screens = [
    MyEventsTab(),
    MyEventsTab(),
    MyEventsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    BaseManagementDataSource baseManagementDataSource = ManagementDataSource();
    BaseManagementRepository baseManagementRepository = ManagementRepository(baseManagementDataSource);
    GetMyEventUseCase getMyEventUseCase = GetMyEventUseCase(baseManagementRepository);
    controller = Get.put(MyEventsController(
        getMyEventUseCase: getMyEventUseCase,
        myEventState: const MyEventState(
            myEventsState: RequestState.loading
        ).obs
    ));
    return Scaffold(
      appBar: MyAppBar.titledAppBar(title: AppStrings.myEvents),
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
                          controller.getMyEvents();
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
                                  children: screens,
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
