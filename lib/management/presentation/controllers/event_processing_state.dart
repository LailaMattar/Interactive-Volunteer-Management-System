import 'package:equatable/equatable.dart';
import 'package:takatof/core/utils/enums.dart';

class EventProcessingState extends Equatable {
  final String registerInEventResponse;
  final RequestState registerInEventState;
  final String registerInEventMessage;

  const EventProcessingState(
      {this.registerInEventResponse = '',
      this.registerInEventState = RequestState.wait,
      this.registerInEventMessage = ''});

  EventProcessingState copyWith({
    String? registerInEventResponse,
    RequestState? registerInEventState,
    String? registerInEventMessage,
  }) {
    return EventProcessingState(
      registerInEventResponse:
          registerInEventResponse ?? this.registerInEventResponse,
      registerInEventState: registerInEventState ?? this.registerInEventState,
      registerInEventMessage:
          registerInEventMessage ?? this.registerInEventMessage,
    );
  }

  @override
  List<Object?> get props => [
        registerInEventResponse,
        registerInEventState,
        registerInEventMessage,
      ];
}
