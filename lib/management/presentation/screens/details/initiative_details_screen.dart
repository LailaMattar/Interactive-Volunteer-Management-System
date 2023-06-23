import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/error/app_error_widget.dart';
import 'package:takatof/core/images/app_images.dart';
import 'package:takatof/core/services/services_locator.dart';
import 'package:takatof/core/strings/app_strings.dart';
import 'package:takatof/core/ui/app_ui.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/entities/Initiative.dart';
import 'package:takatof/management/domain/entities/event.dart';
import 'package:takatof/management/domain/usecases/get_initiative_usecase.dart';
import 'package:takatof/management/presentation/component/event_item.dart';
import 'package:takatof/management/presentation/component/my_app_bar.dart';
import 'package:takatof/management/presentation/controllers/initiative_controller.dart';
import 'package:takatof/management/presentation/controllers/initiative_state.dart';

class InitiativeDetailsScreen extends StatelessWidget {
  InitiativeDetailsScreen({
    Key? key,
    required this.index,
    required this.initiative,
    required this.isMyState
  }) : super(key: key);
  final int index;
  final Initiative initiative;
  final bool isMyState;

  late InitiativeController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(InitiativeController(
        getInitiativeUseCase: sl<GetInitiativeUseCase>(),
        initiativeState:
            const InitiativeState(initiativeState: RequestState.loading).obs));

    controller.getInitiative(initiative.id);
    return Scaffold(
      drawer: AppUi.drawer(),
      appBar: MyAppBar.titledAppBar(title: 'تفاصيل المبادرة'),
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
                    tag: 'initiative$index',
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
                            initiative.image,
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
                            initiative.name,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: false,
                          child: Text(
                            '${initiative.numberVolunteer}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Visibility(
                          visible: false,
                          child: SvgPicture.asset(
                            AppImages.users,
                            height: 17,
                            width: 17,
                          ),
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
                      AppStrings.initiativeDescription,
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
                      initiative.description,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: ColorResources.grey2,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      AppStrings.initiativeEvent,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: ColorResources.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Obx(
                          () {
                            switch(controller.initiativeState.value.initiativeState){

                              case RequestState.loading:
                                return AppUi.spinkitMain;
                              case RequestState.error:
                                return AppErrorWidget.error(
                                    message: controller.initiativeState.value.initiativeMessage,
                                  onTap: (){
                                      controller.getInitiative(initiative.id);
                                  },
                                );
                              case RequestState.wait:
                                return Container();
                              case RequestState.loaded:
                                return ListView.builder(
                                  itemCount: controller.initiativeState.value.initiative.events.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    Event event = controller.initiativeState.value.initiative.events[index];
                                    return EventItem(
                                      index: index,
                                      event: event,
                                      initiative: initiative,
                                      isMyState: isMyState,
                                        isAdminState:false,
                                      isAdmin:false,
                                    );
                                  },
                                );
                            }
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
