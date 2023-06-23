import 'package:equatable/equatable.dart';
import 'package:takatof/core/utils/enums.dart';

class EventProcessingState extends Equatable {
  final String eventProcessingResponse;
  final RequestState eventProcessingState;
  final RequestState commentState;
  final String eventProcessingMessage;

  const EventProcessingState(
      {this.eventProcessingResponse = '',
      this.eventProcessingState = RequestState.wait,
      this.commentState = RequestState.wait,
      this.eventProcessingMessage = ''});

  EventProcessingState copyWith({
    String? eventProcessingResponse,
    RequestState? eventProcessingState,
    RequestState? commentState,
    String? eventProcessingMessage,
  }) {
    return EventProcessingState(
      eventProcessingResponse:
      eventProcessingResponse ?? this.eventProcessingResponse,
      eventProcessingState: eventProcessingState ?? this.eventProcessingState,
      commentState: commentState ?? this.commentState,
      eventProcessingMessage:
      eventProcessingMessage ?? this.eventProcessingMessage,
    );
  }

  @override
  List<Object?> get props => [
        eventProcessingResponse,
        eventProcessingState,
        eventProcessingMessage,
      ];
}
