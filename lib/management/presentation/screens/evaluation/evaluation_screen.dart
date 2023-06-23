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
import 'package:takatof/management/domain/entities/event.dart';
import 'package:takatof/management/domain/entities/measurement.dart';
import 'package:takatof/management/domain/entities/volunteer.dart';
import 'package:takatof/management/domain/usecases/get_evaluation_usecase.dart';
import 'package:takatof/management/domain/usecases/save_evaluation_usecase.dart';
import 'package:takatof/management/presentation/component/evaluate_bool.dart';
import 'package:takatof/management/presentation/component/evaluate_int.dart';
import 'package:takatof/management/presentation/component/my_app_bar.dart';
import 'package:takatof/management/presentation/controllers/evaluation_controller.dart';
import 'package:takatof/management/presentation/controllers/evaluation_save_state.dart';
import 'package:takatof/management/presentation/controllers/evaluation_state.dart';

class EvaluationScreen extends StatelessWidget {
  EvaluationScreen({Key? key, required this.event, required this.volunteer})
      : super(key: key);
  final Event event;
  final Volunteer volunteer;
  late EvaluationController controller;

  Widget text({required String title, required String value}) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Text(
            '$title: ',
            textAlign: TextAlign.start,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorResources.greenPrimary),
          ),
          Text(
            value,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 18, color: ColorResources.black),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller = Get.put(EvaluationController(
        getEvaluationUseCase: sl<GetEvaluationUseCase>(),
        saveEvaluateUseCase: sl<SaveEvaluateUseCase>(),
        parameters: EvaluationParameters(
            eventId: event.id, day: 1, volunteerId: volunteer.id),
        state: EvaluationState(
                state: RequestState.loading, )
            .obs,
    sendState: EvaluationSaveState(sendState: RequestState.wait).obs),);
    controller.getEvaluation();

    return Scaffold(
      drawer: AppUi.drawer(),
      appBar: MyAppBar.titledAppBar(title: 'تقييم المتطوع'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: AppUi.containerBoxDecoration(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    text(
                      title: AppStrings.volunteerName,
                      value: volunteer.name,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    text(
                      title: AppStrings.eventName,
                      value: event.name,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    text(
                      title: AppStrings.eventDate,
                      value: event.date,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() {
                switch (controller.state.value.state) {
                  case RequestState.loading:
                    return const Center(
                      child: AppUi.spinkitMain,
                    );
                  case RequestState.error:
                    return AppErrorWidget.error(
                        message: controller.state.value.message,
                        onTap: () {
                          controller.getEvaluation();
                        });
                  case RequestState.wait:
                    return Container();
                  case RequestState.loaded:
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'نعم أو لا',
                          style: TextStyle(
                            color: ColorResources.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: AppUi.containerBoxDecoration(),
                          child: ListView.builder(
                            itemCount:
                                controller.state.value.evaluation!.bools.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return EvaluateBool(
                                measurement: controller
                                    .state.value.evaluation!.bools[index],
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'قيمة عددية',
                          style: TextStyle(
                            color: ColorResources.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: AppUi.containerBoxDecoration(),
                          child: ListView.builder(
                            itemCount:
                                controller.state.value.evaluation!.ints.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return EvaluateInt(
                                measurement: controller
                                    .state.value.evaluation!.ints[index],
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'ملاحظات',
                          style: TextStyle(
                            color: ColorResources.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 150,
                          child: TextFormField(
                            maxLines: 5,
                            cursorColor: ColorResources.greenPrimary,
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: ColorResources.grey2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: ColorResources.greenPrimary),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Obx(
                                (){
                              print('state send : ${controller.sendState.value.sendState}');
                              switch(controller.sendState.value.sendState){

                                case RequestState.loading:
                                  return const Center(child: AppUi.spinkitMain);
                                case RequestState.error:
                                  return AppErrorWidget.error(message: controller.state.value.message);
                                case RequestState.wait:
                                  return Container();
                                case RequestState.loaded:
                                  WidgetsBinding.instance.addPostFrameCallback((_){
                                    CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.success,
                                      text: controller.sendState.value.message,
                                      confirmBtnColor: ColorResources.greenPrimary,
                                      onConfirmBtnTap: (){
                                        Navigator.of(context, rootNavigator: true).pop();
                                        // Get.offAll(()=> BottomNavBar());
                                        Get.back();
                                      },
                                      barrierDismissible: false,
                                      confirmBtnText: 'حسناً',
                                    );
                                  });
                                  return Container();
                              }

                            }
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 90.0),
                          child: AppButtons.mainButton(
                            title: AppStrings.send,
                            color: ColorResources.greenPrimary,
                            onTap: () {
                              List<Measurement> list = [];
                              if(controller.state.value.evaluation!.ints.isNotEmpty) {
                                list.addAll(
                                    controller.state.value.evaluation!.ints);
                              }
                              if(controller.state.value.evaluation!.bools.isNotEmpty) {
                                list.addAll(
                                    controller.state.value.evaluation!.bools);
                              }
                              controller.saveEvaluation(
                                  SaveEvaluationParameters(
                                    eventId: event.id,
                                    volunteerId: volunteer.id,
                                    day: 1,
                                    measurement: list,
                                  ));
                            },
                          ),
                        ),
                      ],
                    );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
