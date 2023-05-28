import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/usecases/get_my_events_usecase.dart';
import 'package:takatof/management/presentation/controllers/my_events_state.dart';

class MyEventsController extends GetxController implements Equatable {
  final GetMyEventUseCase getMyEventUseCase;
  Rx<MyEventState> myEventState;

  getMyEvents() async {
    myEventState.value =
        myEventState.value.copyWith(myEventsState: RequestState.loading);
    final result = await getMyEventUseCase(const NoParameters());

    result.fold(
      (l) => myEventState.value = myEventState.value.copyWith(
        myEventsMessage: l.message,
        myEventsState: RequestState.error,
      ),
      (r) => myEventState.value = myEventState.value.copyWith(
          myEventsMessage: "success",
          myEventsState: RequestState.loaded,
          myEvents: r),
    );
  }

  MyEventsController(
      {required this.getMyEventUseCase, required this.myEventState});

  @override
  void onInit() {
    super.onInit();
    getMyEvents();
  }

  @override
  List<Object?> get props => [getMyEventUseCase, myEventState];

  @override
  bool? get stringify => throw UnimplementedError();
}
