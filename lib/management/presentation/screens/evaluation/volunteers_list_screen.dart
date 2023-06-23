import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatof/core/error/app_error_widget.dart';
import 'package:takatof/core/services/services_locator.dart';
import 'package:takatof/core/ui/app_ui.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/entities/event.dart';
import 'package:takatof/management/domain/usecases/get_volunteers_for_evaluate_usecase.dart';
import 'package:takatof/management/presentation/component/my_app_bar.dart';
import 'package:takatof/management/presentation/component/volunteer_item.dart';
import 'package:takatof/management/presentation/controllers/volunteers_evaluate_controller.dart';
import 'package:takatof/management/presentation/controllers/volunteers_evaluate_state.dart';

class VolunteersListScreen extends StatelessWidget {
  VolunteersListScreen({Key? key, required this.event}) : super(key: key);
  late VolunteersEvaluateController controller;
  final Event event;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(VolunteersEvaluateController(
      getVolunteersForEvaluateUseCase: sl<GetVolunteersForEvaluateUseCase>(),
      state: const VolunteersEvaluateState(state: RequestState.loading).obs,
      parameters: VolunteersForEvaluateParameters(
          eventId: event.id, day: 1),
    ));
    controller.getVolunteers();
    return Scaffold(
      appBar: MyAppBar.titledAppBar(title: 'قائمة المشاركين'),
      body: Obx(() {
        switch (controller.state.value.state) {
          case RequestState.loading:
            return AppUi.loading();
          case RequestState.error:
            return AppErrorWidget.error(
                message: controller.state.value.message,
                onTap: () {
                  controller.getVolunteers();
                });
          case RequestState.wait:
            return Container();
          case RequestState.loaded:
            return ListView.builder(
                itemCount: controller.state.value.volunteers.length,
                itemBuilder: (BuildContext context, int index) {
                  return VolunteerItem(
                    volunteer: controller.state.value.volunteers[index],
                    event: event,
                  );
                });
        }
      }),
    );
  }
}
