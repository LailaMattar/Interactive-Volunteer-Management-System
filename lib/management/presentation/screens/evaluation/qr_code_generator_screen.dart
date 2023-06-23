import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:takatof/core/error/app_error_widget.dart';
import 'package:takatof/core/images/app_images.dart';
import 'package:takatof/core/services/services_locator.dart';
import 'package:takatof/core/ui/app_ui.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/entities/event.dart';
import 'package:takatof/management/domain/usecases/generate_qr_code_usecase.dart';
import 'package:takatof/management/presentation/component/my_app_bar.dart';
import 'package:takatof/management/presentation/controllers/generate_qr_code_controller.dart';
import 'package:takatof/management/presentation/controllers/generate_qr_code_state.dart';

class QRCodeGeneratorScreen extends StatelessWidget {
  QRCodeGeneratorScreen({Key? key,required this.event,}) : super(key: key);
  final Event event;
  late GenerateQRCodeController controller;

  final qrData = "https://www.example.com";

  @override
  Widget build(BuildContext context) {
    controller = Get.put(GenerateQRCodeController(
        generateQRCodeUseCase: sl<GenerateQRCodeUseCase>(),
        state: const GenerateQRCoedState(state: RequestState.loading).obs));
    controller.generateCode(GenerateQRCodeParameters(eventId: event.id));
    return Scaffold(
      appBar: MyAppBar.titledAppBar(title: 'كود تسجيل الحضور'),
      body: Obx(
              () {
                switch(controller.state.value.state){

                  case RequestState.loading:
                    return AppUi.loading();
                  case RequestState.error:
                    return AppErrorWidget.error(message: controller.state.value.message,onTap: (){
                      controller.generateCode(GenerateQRCodeParameters(eventId: event.id));
                    });
                  case RequestState.wait:
                    return Container();
                  case RequestState.loaded:
                    return Center(
                      child: QrImage(
                        data: controller.state.value.response,
                        version: QrVersions.auto,
                        size: 250.0,
                      ),
                    );
                }
        }
      ),
    );
  }
}
