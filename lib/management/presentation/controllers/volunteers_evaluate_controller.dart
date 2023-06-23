import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/usecases/get_volunteers_for_evaluate_usecase.dart';
import 'package:takatof/management/presentation/controllers/volunteers_evaluate_state.dart';

class VolunteersEvaluateController extends GetxController implements Equatable{
  final GetVolunteersForEvaluateUseCase getVolunteersForEvaluateUseCase;
  final Rx<VolunteersEvaluateState> state;
  final VolunteersForEvaluateParameters parameters;

  VolunteersEvaluateController({
    required this.getVolunteersForEvaluateUseCase,
    required this.state,
    required this.parameters,
  });

  getVolunteers()async{
    state.value = state.value.copyWith(state: RequestState.loading);
    final result = await getVolunteersForEvaluateUseCase(parameters);

    result.fold(
            (l) => state.value = state.value.copyWith(
          message: l.message,
          state: RequestState.error,
        ), (r) {
      return state.value = state.value.copyWith(
          message: "success",
          state: RequestState.loaded,
          volunteers: r);
    });
  }

  @override
  List<Object?> get props => [
    getVolunteersForEvaluateUseCase,
    state,
    parameters,
  ];

  @override
  bool? get stringify => throw UnimplementedError();

}