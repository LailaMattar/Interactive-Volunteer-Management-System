import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/entities/event.dart';
import 'package:takatof/management/domain/usecases/get_admin_event_usecase.dart';
import 'package:takatof/management/domain/usecases/get_my_events_usecase.dart';
import 'package:takatof/management/presentation/controllers/my_events_state.dart';

class MyEventsController extends GetxController implements Equatable {
  final GetMyEventUseCase getMyEventUseCase;
  final GetAdminEventUseCase getAdminEventUseCase;
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
      (r)
      {
        List<Event> state1 = [];
        List<Event> state2 = [];
        List<Event> state3 = [];
        for(int i = 0 ; i < r.length ; i ++){
          if(r[i].state == '1'){
            state1.add(r[i]);
          }else if(r[i].state == '2'){
            state2.add(r[i]);
          }
          if(r[i].state == '3' && r[i].attend == 1){
            state3.add(r[i]);
          }
        }
        return myEventState.value = myEventState.value.copyWith(
            myEventsMessage: "success",
            myEventsState: RequestState.loaded,
            myEventsState1: state1,
        myEventsState2: state2,
        myEventsState3: state3);
      }
    );
  }

  getAdminEvent()async{
    myEventState.value =
        myEventState.value.copyWith(myEventsState: RequestState.loading);
    final result = await getAdminEventUseCase(const NoParameters());

    result.fold(
            (l) => myEventState.value = myEventState.value.copyWith(
          myEventsMessage: l.message,
          myEventsState: RequestState.error,
        ),
            (r)
        {
          List<Event> state1 = [];
          List<Event> state2 = [];
          List<Event> state3 = [];
          for(int i = 0 ; i < r.length ; i ++){
            if(r[i].state == '1'){
              state1.add(r[i]);
            }else if(r[i].state == '2'){
              state2.add(r[i]);
            }
            if(r[i].state == '3'){
              state3.add(r[i]);
            }
          }
          return myEventState.value = myEventState.value.copyWith(
              myEventsMessage: "success",
              myEventsState: RequestState.loaded,
              myEventsState1: state1,
              myEventsState2: state2,
              myEventsState3: state3);
        }
    );
  }

  MyEventsController(
      {required this.getMyEventUseCase, required this.myEventState,required this.getAdminEventUseCase});


  @override
  List<Object?> get props => [getMyEventUseCase, myEventState];

  @override
  bool? get stringify => throw UnimplementedError();
}
