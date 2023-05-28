import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/error/app_error_widget.dart';
import 'package:takatof/core/images/app_images.dart';
import 'package:takatof/core/services/services_locator.dart';
import 'package:takatof/core/strings/app_strings.dart';
import 'package:takatof/core/ui/app_buttons.dart';
import 'package:takatof/core/ui/app_ui.dart';
import 'package:takatof/core/utils/app_constance.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/entities/Initiative.dart';
import 'package:takatof/management/domain/entities/event.dart';
import 'package:takatof/management/presentation/component/event_status.dart';
import 'package:takatof/management/presentation/component/my_app_bar.dart';
import 'package:takatof/management/presentation/controllers/event_processing_controller.dart';
import 'package:takatof/management/presentation/controllers/event_processing_state.dart';
import 'package:takatof/management/presentation/screens/evaluation/attendance_list_screen.dart';
import 'package:takatof/management/presentation/screens/evaluation/volunteers_list_screen.dart';
import 'package:takatof/management/presentation/screens/homescreens/bottom_nav_bar.dart';

class EventDetailsScreen extends StatelessWidget {
  EventDetailsScreen(
      {Key? key, required this.index, required this.event, this.initiative})
      : super(key: key);
  final int index;
  final Event event;
  late EventProcessingController controller;
  Initiative? initiative;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(EventProcessingController(
        eventProcessingState:
            const EventProcessingState(
                registerInEventState: RequestState.wait
            ).obs,
        registerInEventUseCase: sl(),
        event: event));

    return Scaffold(
      drawer: AppUi.drawer(),
      appBar: MyAppBar.mine(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorResources.white,
                borderRadius: const BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(30),
                  bottomEnd: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Hero(
                    tag: 'eventImage$index',
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorResources.white,
                        borderRadius: const BorderRadiusDirectional.only(
                          bottomStart: Radius.circular(30),
                          bottomEnd: Radius.circular(30),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            initiative == null
                                ? event.image
                                : initiative!.image,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    decoration: const BoxDecoration(
                      color: ColorResources.white,
                      borderRadius: BorderRadiusDirectional.only(
                        bottomStart: Radius.circular(30),
                        bottomEnd: Radius.circular(30),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            initiative == null ? event.name : initiative!.name,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          '${event.numberVolunteer}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SvgPicture.asset(
                          AppImages.users,
                          height: 17,
                          width: 17,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: Column(
                children: [
                  EventStatus(status: int.parse(event.state), size: 15),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: ColorResources.greenPrimary,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'تاريخ الفعاليّة ${event.date}',
                        style: const TextStyle(
                            fontSize: 15, color: ColorResources.greenPrimary),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.place,
                        color: ColorResources.greenPrimary,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'مكان الفعاليّة ${event.place}',
                        style: const TextStyle(
                            fontSize: 15, color: ColorResources.greenPrimary),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        'وقت الفعاليّة ${event.time}',
                        style: const TextStyle(
                            fontSize: 15, color: ColorResources.black),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'بدء التسجيل ${event.startRegisterDate}',
                        style: const TextStyle(
                            fontSize: 15, color: ColorResources.black),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'انتهاء التسجيل ${event.finishRegisterDate}',
                        style: const TextStyle(
                            fontSize: 15, color: ColorResources.black),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'اسم المشرف : ليلى مطر',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: ColorResources.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      AppStrings.notes,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: ColorResources.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      initiative == null
                          ? event.description
                          : initiative!.description,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: ColorResources.grey2,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: event.isRegistered == 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 90.0),
                      child: AppButtons.mainButton(
                        title: AppStrings.registerInEvent,
                        color: ColorResources.greenPrimary,
                        onTap: () {
                          controller.registerInEvent();
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: event.isRegistered == 0,
                    child: const SizedBox(
                      height: 10,
                    ),
                  ),
                  Visibility(
                    visible: AppConstance.role == 'admin',
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 90.0),
                      child: AppButtons.mainButton(
                          title: 'تقييم المتطوعين',
                          color: ColorResources.greenPrimary,
                          onTap: () {
                            Get.to(() => VolunteersListScreen());
                          }),
                    ),
                  ),
                  Visibility(
                    visible: AppConstance.role == 'admin',
                    child: const SizedBox(
                      height: 10,
                    ),
                  ),
                  Visibility(
                    visible: AppConstance.role == 'admin',
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 90.0),
                      child: AppButtons.mainButton(
                        title: 'تسجيل حضور',
                        color: ColorResources.greenPrimary,
                        onTap: () {
                          Get.to(() => AttendanceListScreen());
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: AppConstance.role == 'admin',
                    child: const SizedBox(
                      height: 10,
                    ),
                  ),
                  Visibility(
                    visible: AppConstance.role == 'admin',
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 90.0),
                      child: AppButtons.mainButton(
                        title: 'انهاء الفعالية',
                        color: ColorResources.redPrimary,
                        onTap: () {},
                      ),
                    ),
                  ),
                  Obx(
                      (){
                        switch (controller.eventProcessingState.value.registerInEventState){
                          case RequestState.loading:
                            return const Center(child: AppUi.spinkitMain);
                          case RequestState.error:
                            return AppErrorWidget.error(
                                message: controller
                                    .eventProcessingState
                                    .value
                                    .registerInEventMessage
                            );
                          case RequestState.wait:
                            return Container();
                          case RequestState.loaded:
                            WidgetsBinding.instance.addPostFrameCallback((_){
                              AppUi.showToast(message: controller
                                  .eventProcessingState
                                  .value
                                  .registerInEventMessage
                              );
                              Get.off(()=> BottomNavBar());
                            });
                            return Container();
                        }
                      }
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
