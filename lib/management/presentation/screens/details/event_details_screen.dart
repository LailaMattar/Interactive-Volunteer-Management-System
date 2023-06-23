import 'package:custom_pointed_popup/custom_pointed_popup.dart';
import 'package:custom_pointed_popup/utils/triangle_painter.dart';
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
import 'package:takatof/management/domain/usecases/add_admin_note_usecase.dart';
import 'package:takatof/management/domain/usecases/get_event_details_usecase.dart';
import 'package:takatof/management/presentation/component/event_status.dart';
import 'package:takatof/management/presentation/component/my_app_bar.dart';
import 'package:takatof/management/presentation/controllers/event_details_state.dart';
import 'package:takatof/management/presentation/controllers/event_processing_controller.dart';
import 'package:takatof/management/presentation/controllers/event_processing_state.dart';
import 'package:takatof/management/presentation/screens/details/volunteers_screen.dart';
import 'package:takatof/management/presentation/screens/drawer/registerrequests/register_requests_screen.dart';
import 'package:takatof/management/presentation/screens/evaluation/attendance_list_screen.dart';
import 'package:takatof/management/presentation/screens/evaluation/volunteers_list_screen.dart';
import 'package:takatof/management/presentation/screens/homescreens/bottom_nav_bar.dart';

class EventDetailsScreen extends StatelessWidget {
  EventDetailsScreen(
      {Key? key,
      required this.index,
      required this.event,
      this.initiative,
      required this.isMyState,
      required this.isAdminState})
      : super(key: key);
  final int index;
  final Event event;
  late EventProcessingController controller;
  Initiative? initiative;
  final bool isMyState;
  final bool isAdminState;

  TextEditingController commentController = TextEditingController();

  final GlobalKey widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    print('eventttt ${event.isRegistered}');
    controller = Get.put(EventProcessingController(
      eventProcessingState:
          const EventProcessingState(eventProcessingState: RequestState.wait)
              .obs,
      registerInEventUseCase: sl(),
      endEventUseCase: sl(),
      addAdminNoteUseCase: sl<AddAdminNoteUseCase>(),
      event: event,
      getEventDetailsUseCase: sl<GetEventDetailsUseCase>(),
      detailsState: const EventDetailsState(state: RequestState.loading).obs,
    ));
    controller.getEventDetails(GetEventDetailsParameters(eventId: event.id));

    print('event name : ${event.name}');
    print('event id : ${event.id}');
    print('event state : ${event.state}');
    return Scaffold(
      drawer: AppUi.drawer(),
      appBar: MyAppBar.titledAppBar(title: 'تفاصيل الفعاليّة'),
      body: Obx(() {
        switch (controller.detailsState.value.state) {
          case RequestState.loading:
            return AppUi.loading();
          case RequestState.error:
            return AppErrorWidget.error(
                message: controller.detailsState.value.message,
                onTap: () {
                  controller.getEventDetails(
                      GetEventDetailsParameters(eventId: event.id));
                });
          case RequestState.wait:
            return Container();
          case RequestState.loaded:
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          offset:
                              const Offset(0, 1), // changes position of shadow
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
                                  initiative == null
                                      ? event.name
                                      : initiative!.name,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  if(event.state == '1') {
                                    Get.to(()=> VolunteersScreen(volunteers: controller.detailsState.value.eventDetails!.review));
                                  }else{
                                    Get.to(()=> VolunteersScreen(volunteers: controller.detailsState.value.eventDetails!.attend));
                                  }
                                },
                                child: Row(
                                  children: [
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15),
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
                                  fontSize: 15,
                                  color: ColorResources.greenPrimary),
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
                                  fontSize: 15,
                                  color: ColorResources.greenPrimary),
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
                            'اسم المشرف : ${event.adminName}',
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
                          visible: isMyState == false,
                          // visible: true,
                          child: Visibility(
                            visible: event.state == '1' && event.isAdmin!=1,
                            // visible: true,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 90.0),
                              child: AppButtons.mainButton(
                                title: isMyState == false &&
                                        (event.isRegistered == 0 &&
                                            event.state == '1')
                                    ? AppStrings.registerInEvent
                                    : 'تم تسجيل طلبك',
                                color: isMyState == false &&
                                        (event.isRegistered == 0 &&
                                            event.state == '1')
                                    ? ColorResources.greenPrimary
                                    : ColorResources.grey,
                                onTap: () {
                                  if (isMyState == false &&
                                      (event.isRegistered == 0 &&
                                          event.state == '1')) {
                                    controller.registerInEvent();
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isMyState == true,
                          child: Visibility(
                            visible: event.state == '1',
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 90.0),
                              child: AppButtons.mainButton(
                                title: isMyState == false &&
                                        (event.isRegistered == 0 &&
                                            event.state == '1')
                                    ? AppStrings.registerInEvent
                                    : 'تم تسجيل طلبك',
                                color: isMyState == false &&
                                        (event.isRegistered == 0 &&
                                            event.state == '1')
                                    ? ColorResources.greenPrimary
                                    : ColorResources.grey,
                                onTap: () {
                                  if (isMyState == false &&
                                      (event.isRegistered == 0 &&
                                          event.state == '1')) {
                                    controller.registerInEvent();
                                  }
                                },
                              ),
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
                          visible: AppConstance.eventCondition(
                              isAdmin: isAdminState, eventState: event.state),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 90.0),
                            child: AppButtons.mainButton(
                              title: 'تسجيل حضور',
                              color: ColorResources.greenPrimary,
                              onTap: () {
                                Get.to(() => AttendanceListScreen(
                                      event: event,
                                    ));
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
                          visible: AppConstance.eventCondition(
                              isAdmin: isAdminState, eventState: event.state),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 90.0),
                            child: AppButtons.mainButton(
                                title: 'تقييم المتطوعين',
                                color: ColorResources.greenPrimary,
                                onTap: () {
                                  Get.to(() => VolunteersListScreen(
                                        event: event,
                                      ));
                                }),
                          ),
                        ),
                        Visibility(
                          visible: AppConstance.eventCondition(
                              isAdmin: isAdminState, eventState: event.state),
                          child: const SizedBox(
                            height: 10,
                          ),
                        ),
                        Visibility(
                          visible: AppConstance.eventCondition(
                              isAdmin: isAdminState, eventState: event.state),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 90.0),
                            child: Form(
                              key: widgetKey,
                              child: AppButtons.mainButton(
                                title: 'انهاء الفعالية',
                                color: ColorResources.redPrimary,
                                onTap: () {
                                  print('انهاء');
                                  // getCustomPointedPopup(context)
                                  //   ..show(
                                  //     widgetKey: widgetKey,
                                  //   );

                                  Get.dialog(
                                    Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: AlertDialog(
                                        title: const Text(
                                          'هل تريد ترك ملاحظة؟',
                                          textAlign: TextAlign.center,
                                        ),
                                        titleTextStyle: const TextStyle(
                                          color: ColorResources.black,
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        content: SizedBox(
                                          height: 180,
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                controller: commentController,
                                                maxLines: 4,
                                                decoration:
                                                    const InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: ColorResources
                                                            .grey),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: ColorResources
                                                            .grey),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: ColorResources
                                                            .grey),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                                child: Obx(() {
                                                  switch (controller
                                                      .eventProcessingState
                                                      .value
                                                      .commentState) {
                                                    case RequestState.loading:
                                                      return const Center(
                                                          child: AppUi
                                                              .spinkitMain);
                                                    case RequestState.error:
                                                      return AppErrorWidget.error(
                                                          message: controller
                                                              .eventProcessingState
                                                              .value
                                                              .eventProcessingMessage);
                                                    case RequestState.wait:
                                                      return Container();
                                                    case RequestState.loaded:
                                                      WidgetsBinding.instance
                                                          .addPostFrameCallback(
                                                              (_) {
                                                        // controller.endEvent();
                                                        // AppUi.showToast(
                                                        //     message: controller.eventProcessingState.value
                                                        //         .eventProcessingMessage);
                                                        // Get.offAll(() => BottomNavBar());
                                                      });
                                                      return Container();
                                                  }
                                                }),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              controller.addAdminComment(
                                                  commentController.text);
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();
                                            },
                                            child: const Text(
                                              'إرسال',
                                              style: TextStyle(
                                                  color: ColorResources
                                                      .greenPrimary),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );

                                  // controller.endEvent();
                                },
                              ),
                            ),
                          ),
                        ),
                        Obx(() {
                          switch (controller.eventProcessingState.value
                              .eventProcessingState) {
                            case RequestState.loading:
                              return const Center(child: AppUi.spinkitMain);
                            case RequestState.error:
                              return AppErrorWidget.error(
                                  message: controller.eventProcessingState.value
                                      .eventProcessingMessage);
                            case RequestState.wait:
                              return Container();
                            case RequestState.loaded:
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                AppUi.showToast(
                                    message: controller.eventProcessingState
                                        .value.eventProcessingMessage);
                                Get.offAll(() => BottomNavBar());
                              });
                              return Container();
                          }
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            );
        }
      }),
    );
  }
}
