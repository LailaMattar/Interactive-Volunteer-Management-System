import 'package:equatable/equatable.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/entities/event.dart';

class MyEventState extends Equatable {
  final List<Event> myEvents;
  final RequestState myEventsState;
  final String myEventsMessage;

  const MyEventState(
      {this.myEvents = const [],
      this.myEventsState = RequestState.loading,
      this.myEventsMessage = ''});

  @override
  List<Object?> get props => [
        myEvents,
        myEventsState,
        myEventsMessage,
      ];

  MyEventState copyWith({
    List<Event>? myEvents,
    RequestState? myEventsState,
    String? myEventsMessage,
})=>MyEventState(
    myEvents: myEvents ?? this.myEvents,
    myEventsState: myEventsState ?? this.myEventsState,
    myEventsMessage: myEventsMessage ?? this.myEventsMessage
  );
}
