import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/error/app_error_widget.dart';
import 'package:takatof/core/services/services_locator.dart';
import 'package:takatof/core/ui/app_ui.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/entities/register_request.dart';
import 'package:takatof/management/domain/usecases/accept_register_request_usecase.dart';
import 'package:takatof/management/domain/usecases/get_register_requests_usecase.dart';
import 'package:takatof/management/presentation/component/my_app_bar.dart';
import 'package:takatof/management/presentation/component/profile_image.dart';
import 'package:takatof/management/presentation/controllers/register_requests_controller.dart';
import 'package:takatof/management/presentation/controllers/register_requests_state.dart';

class RegisterRequestsScreen extends StatelessWidget {
  RegisterRequestsScreen({
    Key? key,
  }) : super(key: key);
  late RegisterRequestsController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(RegisterRequestsController(
        getRegisterRequestsUseCase: sl<GetRegisterRequestsUseCase>(),
        context: context,
        acceptRegisterRequestUseCase: sl<AcceptRegisterRequestUseCase>(),
        state: const RegisterRequestsState(
                state: RequestState.loading, sendState: RequestState.wait)
            .obs));
    controller.getRegisterRequests(GetRegisterRequestsParameters(eventId: 1));
    return Scaffold(
      appBar: MyAppBar.titledAppBar(title: 'مراجعة طلبات الانضمام'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Obx(() {
          switch (controller.state.value.state) {
            case RequestState.loading:
              return AppUi.loading();
            case RequestState.error:
              return AppErrorWidget.error(
                  message: controller.state.value.message,
                  onTap: () {
                    controller.getRegisterRequests(
                        GetRegisterRequestsParameters(eventId: 1));
                  });
            case RequestState.wait:
              return Container();
            case RequestState.loaded:
              return ListView.builder(
                  itemCount: controller.state.value.requests.length,
                  itemBuilder: (BuildContext context, int index) {
                    RegisterRequest request =
                        controller.state.value.requests[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: AppUi.containerBoxDecoration(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                // ProfileImage(
                                //   height: 50,
                                //   width: 50,
                                //   hasFrame: false,
                                //   image: request.,
                                // ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    request.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: ColorResources.greenPrimary,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'المهنة: ${request.profession}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: ColorResources.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'اسم الفعالية: ${request.initiativeName}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: ColorResources.black,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    request.date,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: ColorResources.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(() {
                              switch (controller.state.value.sendState) {
                                case RequestState.loading:
                                  return AppUi.spinkitMain;
                                case RequestState.error:
                                  return AppErrorWidget.error(
                                      message: controller.state.value.message,
                                      onTap: () {
                                        controller.acceptRegisterRequest(
                                            AcceptRegisterRequestParameters(
                                                eventId: request.id,
                                                volunteerId:
                                                    request.id));
                                      });
                                case RequestState.wait:
                                  return ElevatedButton(
                                    onPressed: () {
                                      controller.acceptRegisterRequest(
                                          AcceptRegisterRequestParameters(
                                              eventId: request.id,
                                              volunteerId:
                                              request.id));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          ColorResources.greenPrimary,
                                    ),
                                    child: const Text('قبول'),
                                  );
                                case RequestState.loaded:
                                  WidgetsBinding.instance.addPostFrameCallback((_){

                                  });
                                  return Container();
                              }
                            }),
                          ],
                        ),
                      ),
                    );
                  });
          }
        }),
      ),
    );
  }
}