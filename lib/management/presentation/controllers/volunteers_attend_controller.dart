import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/usecases/get_volunteers_for_attend_usecase.dart';
import 'package:takatof/management/domain/usecases/save_attend_usecase.dart';
import 'package:takatof/management/presentation/controllers/volunteers_attend_state.dart';

class VolunteersAttendController extends GetxController implements Equatable {
  final GetVolunteersForAttendUseCase getVolunteersForAttendUseCase;
  final SaveAttendUseCase saveAttendUseCase;
  final VolunteersForAttendParameters parameters;
  Rx<VolunteersAttendState> state;

  VolunteersAttendController({
    required this.getVolunteersForAttendUseCase,
    required this.saveAttendUseCase,
    required this.state,
    required this.parameters
  });

  getVolunteers()async{
    state.value = state.value.copyWith(state: RequestState.loading);
    final result = await getVolunteersForAttendUseCase(parameters);

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

  saveAttend(SaveAttendParameters parameters)async{
    state.value = state.value.copyWith(sendState: RequestState.loading);
    final result = await saveAttendUseCase(parameters);

    result.fold(
            (l) => state.value = state.value.copyWith(
          message: l.message,
              sendState: RequestState.error,
        ), (r) {
      return state.value = state.value.copyWith(
          message: r,
        sendState: RequestState.loaded,
      );
    });
  }

  @override
  List<Object?> get props => [
    getVolunteersForAttendUseCase,
    state,
  ];

  @override
  bool? get stringify => throw UnimplementedError();
}
