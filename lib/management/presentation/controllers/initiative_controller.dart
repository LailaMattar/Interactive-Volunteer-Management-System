import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/usecases/get_initiative_usecase.dart';
import 'package:takatof/management/presentation/controllers/initiative_state.dart';

class InitiativeController extends GetxController implements Equatable{
  final GetInitiativeUseCase getInitiativeUseCase;
  final Rx<InitiativeState> initiativeState;

  InitiativeController({required this.getInitiativeUseCase, required this.initiativeState});

  getInitiative(int parameters)async{
    initiativeState.value = initiativeState.value.copyWith(initiativeState: RequestState.loading);
    final result = await getInitiativeUseCase(parameters);

    result.fold(
          (l) => initiativeState.value = initiativeState.value.copyWith(
        initiativeMessage: l.message,
        initiativeState: RequestState.error,
      ),
          (r) => initiativeState.value = initiativeState.value.copyWith(
              initiativeMessage: "success",
              initiativeState: RequestState.loaded,
          initiative: r),
    );
  }

  @override
  List<Object?> get props => [
    getInitiativeUseCase,
    initiativeState,
  ];

  @override
  bool? get stringify => throw UnimplementedError();

}