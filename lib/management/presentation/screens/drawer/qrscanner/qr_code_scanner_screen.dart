import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:takatof/core/error/app_error_widget.dart';
import 'package:takatof/core/services/services_locator.dart';
import 'package:takatof/core/ui/app_ui.dart';
import 'package:takatof/core/utils/app_constance.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/usecases/scan_qr_code_usecase.dart';
import 'package:takatof/management/presentation/controllers/scan_qr_code_controller.dart';
import 'package:takatof/management/presentation/controllers/scan_qr_code_state.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  bool first = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late String re = '';

  late ScanQRCodeController apiController = Get.put(ScanQRCodeController(
      scanQRCodeUseCase: sl<ScanQRCodeUseCase>(),
      state: ScanQRCodeState(
        state: RequestState.wait,
      ).obs));

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Obx(
                    () {
                      if (result != null) {
                        if (!first) {
                          print('popopo');
                          List<String> list = result!.code!.split(',');
                          apiController.scanCode(ScanQRCodeParameters(
                              qrString: list[1],
                              eventId: int.parse(list[0]),
                              volunteerId: AppConstance.id));
                          first = true;
                        }
                      }
                      switch (apiController.state.value.state) {
                        case RequestState.loading:
                          return AppUi.spinkitMain;
                        case RequestState.error:
                          return AppErrorWidget.error(
                              message: apiController.state.value.message);
                        case RequestState.wait:
                          return Container();
                        case RequestState.loaded:
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            print('loaded scan');
                            AppUi.showToast(
                                message: apiController.state.value.message);
                            Get.back();
                          });
                          return Container();
                      }
                    },
                  ),
                  if (result != null)
                    Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  else
                    const Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text('Flash: ${snapshot.data}');
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  print(
                                      'dataaaaaa ${describeEnum(snapshot.data!)}');
                                  // if(describeEnum(snapshot.data!) != 'back'){
                                  //   List<String> list =
                                  //   snapshot.data.toString().split(',');
                                  //   apiController.scanCode(ScanQRCodeParameters(
                                  //       qrString: list[1],
                                  //       eventId: int.parse(list[0]),
                                  //       volunteerId: 6));
                                  //   print('changeeee ${snapshot.data!}');
                                  // }

                                  return Text(
                                      'Camera facing ${describeEnum(snapshot.data!)}');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: const Text('pause',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: const Text('resume',
                              style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    String str = '';
    if (result != null) {
      str = result!.code!;
      print('jjhhjhjhjhj');
      print(str);
    }
    // List<String> list = str.split(',');
    // apiController.scanCode(ScanQRCodeParameters(qrString: list[1], eventId: int.parse(list[0]), volunteerId: AppConstance.id));
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
