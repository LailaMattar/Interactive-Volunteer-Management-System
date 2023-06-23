import 'package:equatable/equatable.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/entities/event.dart';

class MyEventState extends Equatable {
  final List<Event> myEventsState1;
  final List<Event> myEventsState2;
  final List<Event> myEventsState3;
  final RequestState myEventsState;
  final String myEventsMessage;

  const MyEventState(
      {
        this.myEventsState1 = const [],
        this.myEventsState2 = const [],
        this.myEventsState3 = const [],
      this.myEventsState = RequestState.loading,
      this.myEventsMessage = ''});

  @override
  List<Object?> get props => [
        myEventsState1,
        myEventsState,
        myEventsMessage,
      ];

  MyEventState copyWith({
    List<Event>? myEventsState1,
    List<Event>? myEventsState2,
    List<Event>? myEventsState3,
    RequestState? myEventsState,
    String? myEventsMessage,
})=>MyEventState(
      myEventsState1: myEventsState1 ?? this.myEventsState1,
    myEventsState2: myEventsState2 ?? this.myEventsState1,
    myEventsState3: myEventsState3 ?? this.myEventsState3,
    myEventsState: myEventsState ?? this.myEventsState,
    myEventsMessage: myEventsMessage ?? this.myEventsMessage
  );
}
