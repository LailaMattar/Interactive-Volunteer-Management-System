import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/usecases/generate_qr_code_usecase.dart';
import 'package:takatof/management/presentation/controllers/generate_qr_code_state.dart';

class GenerateQRCodeController extends GetxController implements Equatable {
  final GenerateQRCodeUseCase generateQRCodeUseCase;
  Rx<GenerateQRCoedState> state;

  GenerateQRCodeController(
      {required this.generateQRCodeUseCase, required this.state});

  generateCode(GenerateQRCodeParameters parameters) async {
    state.value = state.value.copyWith(state: RequestState.loading);
    final result = await generateQRCodeUseCase(parameters);

    result.fold(
        (l) => state.value = state.value.copyWith(
              message: l.message,
              state: RequestState.error,
            ), (r) {
          print('ressss ${r}');
      return state.value = state.value.copyWith(
          message: "success", state: RequestState.loaded, response: r);
    });
  }

  @override
  List<Object?> get props => [
        generateQRCodeUseCase,
        state,
      ];

  @override
  bool? get stringify => throw UnimplementedError();
}
