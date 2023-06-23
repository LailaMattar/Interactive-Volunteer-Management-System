import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/usecases/get_evaluation_usecase.dart';
import 'package:takatof/management/domain/usecases/save_evaluation_usecase.dart';
import 'package:takatof/management/presentation/controllers/evaluation_save_state.dart';
import 'package:takatof/management/presentation/controllers/evaluation_state.dart';

class EvaluationController extends GetxController implements Equatable {
  final GetEvaluationUseCase getEvaluationUseCase;
  final SaveEvaluateUseCase saveEvaluateUseCase;
  final EvaluationParameters parameters;
  Rx<EvaluationState> state;
  Rx<EvaluationSaveState> sendState;

  EvaluationController({
    required this.getEvaluationUseCase,
    required this.saveEvaluateUseCase,
    required this.state,
    required this.sendState,
    required this.parameters,
  });

  getEvaluation() async {
    state.value = state.value.copyWith(state: RequestState.loading);
    final result = await getEvaluationUseCase(parameters);

    result.fold(
        (l) => state.value = state.value.copyWith(
              message: l.message,
              state: RequestState.error,
            ), (r) {
      return state.value = state.value.copyWith(
          message: "success", state: RequestState.loaded, evaluation: r);
    });
  }

  saveEvaluation(SaveEvaluationParameters parameters) async {
    sendState.value = sendState.value.copyWith(sendState: RequestState.loading);
    final result = await saveEvaluateUseCase(parameters);

    result.fold(
        (l) => sendState.value = sendState.value.copyWith(
              message: l.message,
              sendState: RequestState.error,
            ), (r) {
      return sendState.value =
          sendState.value.copyWith(message: r, sendState: RequestState.loaded);
    });
  }

  @override
  List<Object?> get props => [
        getEvaluationUseCase,
        state,
      ];

  @override
  bool? get stringify => throw UnimplementedError();
}
