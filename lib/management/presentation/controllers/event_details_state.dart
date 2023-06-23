import 'package:equatable/equatable.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/entities/event_details.dart';

class EventDetailsState extends Equatable {
  final EventDetails? eventDetails;
  final RequestState state;
  final String message;

  const EventDetailsState(
      {this.eventDetails,
      this.state = RequestState.loading,
      this.message = ''});

  EventDetailsState copyWith({
    EventDetails? eventDetails,
    RequestState? state,
    String? message,
  }) {
    return EventDetailsState(
      eventDetails: eventDetails,
      state: state ?? this.state,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        eventDetails,
        state,
        message,
      ];
}
