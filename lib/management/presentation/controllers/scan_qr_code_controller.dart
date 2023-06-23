import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/usecases/scan_qr_code_usecase.dart';
import 'package:takatof/management/presentation/controllers/scan_qr_code_state.dart';

class ScanQRCodeController extends GetxController implements Equatable{
  final ScanQRCodeUseCase scanQRCodeUseCase;
  Rx<ScanQRCodeState> state;

  ScanQRCodeController({required this.scanQRCodeUseCase,required this.state});

  scanCode(ScanQRCodeParameters parameters)async{
    state.value = state.value.copyWith(state: RequestState.loading);
    final result = await scanQRCodeUseCase(parameters);

    result.fold(
            (l) => state.value = state.value.copyWith(
          message: l.message,
          state: RequestState.error,
        ), (r) {
      return state.value = state.value.copyWith(
          message: "success", state: RequestState.loaded, response: r);
    });
  }

  @override
  List<Object?> get props => [
    scanQRCodeUseCase,
    state,
  ];

  @override
  bool? get stringify => throw UnimplementedError();

}