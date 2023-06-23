import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/error/app_error_widget.dart';
import 'package:takatof/core/services/services_locator.dart';
import 'package:takatof/core/ui/app_buttons.dart';
import 'package:takatof/core/ui/app_ui.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/entities/event.dart';
import 'package:takatof/management/domain/usecases/get_volunteers_for_attend_usecase.dart';
import 'package:takatof/management/domain/usecases/save_attend_usecase.dart';
import 'package:takatof/management/presentation/component/attendance_item.dart';
import 'package:takatof/management/presentation/controllers/volunteers_attend_controller.dart';
import 'package:takatof/management/presentation/controllers/volunteers_attend_state.dart';
import 'package:takatof/management/presentation/screens/evaluation/qr_code_generator_screen.dart';

class AttendanceListScreen extends StatelessWidget {
  AttendanceListScreen({Key? key,required this.event}) : super(key: key);
  late VolunteersAttendController controller;
  final Event event;
  List<int> ids = [];

  @override
  Widget build(BuildContext context) {
    controller = Get.put(VolunteersAttendController(
      getVolunteersForAttendUseCase: sl<GetVolunteersForAttendUseCase>(),
      saveAttendUseCase: sl<SaveAttendUseCase>(),
      state:const VolunteersAttendState(state: RequestState.loading).obs,
      parameters: VolunteersForAttendParameters(eventId: event.id,day: 1),
    ));
    controller.getVolunteers();
    return Scaffold(
      drawer: AppUi.drawer(),
      appBar: AppBar(
        title:const Text(
          'تسجيل الحضور',
          style:TextStyle(
            color: ColorResources.black,
          ),
        ),
        leading:  IconButton(
          icon:const Icon(Icons.arrow_back, color: ColorResources.black),
          onPressed: (){Get.back();},
        ),
        centerTitle: true,
        backgroundColor: ColorResources.white,
        actions: [
          IconButton(
              onPressed: (){
                Get.to(QRCodeGeneratorScreen(event: event,));
              },
              icon: const Icon(
                  Icons.qr_code_scanner,
                color: ColorResources.black,
              )
          ),
        ],
      ),
      body: Obx( () {
        switch(controller.state.value.state){

          case RequestState.loading:
            return AppUi.loading();
          case RequestState.error:
            return AppErrorWidget.error(
                message:
                controller.state.value.message,
                onTap: () {
                  controller.getVolunteers();
                });
          case RequestState.wait:
            return Container();
          case RequestState.loaded:
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: controller.state.value.volunteers.length,
                      itemBuilder: (BuildContext context , int index){
                        return AttendanceItem(volunteer: controller.state.value.volunteers[index],);
                      }),
                ),
                Obx(
                        (){
                          print('state send : ${controller.state.value.sendState}');
                      switch(controller.state.value.sendState){

                        case RequestState.loading:
                          return const Center(child: AppUi.spinkitMain);
                        case RequestState.error:
                          return AppErrorWidget.error(message: controller.state.value.message);
                        case RequestState.wait:
                          return Container();
                        case RequestState.loaded:
                          WidgetsBinding.instance.addPostFrameCallback((_){
                            AppUi.showToast(
                                message: controller.state.value
                                    .message);
                            Get.back();
                          });
                          return Container();
                      }

                    }
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90.0,vertical: 20),
                  child: AppButtons.mainButton(
                    title: 'إرسال',
                    color: ColorResources.greenPrimary,
                    onTap: (){
                      for(int i = 0 ; i < controller.state.value.volunteers.length ; i ++){
                        if(controller.state.value.volunteers[i].checked == true){
                          ids.add(controller.state.value.volunteers[i].id);
                        }
                      }
                      controller.saveAttend(SaveAttendParameters(
                        eventId: event.id,
                        day: event.numberDay,
                        ids: ids,
                      ));
                    },
                  ),
                ),
              ],
            );
        }
        }
      ),
    );
  }
}
