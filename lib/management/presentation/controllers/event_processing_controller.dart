import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/entities/event.dart';
import 'package:takatof/management/domain/usecases/add_admin_note_usecase.dart';
import 'package:takatof/management/domain/usecases/end_event_usecase.dart';
import 'package:takatof/management/domain/usecases/get_event_details_usecase.dart';
import 'package:takatof/management/domain/usecases/register_in_event_usecase.dart';
import 'package:takatof/management/presentation/controllers/event_details_state.dart';
import 'package:takatof/management/presentation/controllers/event_processing_state.dart';

class EventProcessingController extends GetxController implements Equatable {
  final RegisterInEventUseCase registerInEventUseCase;
  final EndEventUseCase endEventUseCase;
  final AddAdminNoteUseCase addAdminNoteUseCase;
  final GetEventDetailsUseCase getEventDetailsUseCase;
  final Rx<EventProcessingState> eventProcessingState;
  final Rx<EventDetailsState> detailsState;
  final Event event;

  EventProcessingController({
    required this.eventProcessingState,
    required this.endEventUseCase,
    required this.addAdminNoteUseCase,
    required this.getEventDetailsUseCase,
    required this.registerInEventUseCase,
    required this.detailsState,
    required this.event,
  });

  getEventDetails(GetEventDetailsParameters parameters)async {
    detailsState.value = detailsState.value
        .copyWith(state: RequestState.loading);
    final result = await getEventDetailsUseCase(parameters);

    result.fold(
            (l) => detailsState.value = detailsState.value.copyWith(
          message: l.message,
          state: RequestState.error,
        ), (r) {
      return detailsState.value = detailsState.value.copyWith(
          message: 'success',
          state: RequestState.loaded,
          eventDetails: r);
    });
  }

  registerInEvent() async {
    eventProcessingState.value = eventProcessingState.value
        .copyWith(eventProcessingState: RequestState.loading);
    final result = await registerInEventUseCase(event.id);

    result.fold(
        (l) => eventProcessingState.value = eventProcessingState.value.copyWith(
              eventProcessingMessage: l.message,
              eventProcessingState: RequestState.error,
            ), (r) {
      return eventProcessingState.value = eventProcessingState.value.copyWith(
          eventProcessingMessage: r,
          eventProcessingState: RequestState.loaded,
          eventProcessingResponse: r);
    });
  }

  endEvent() async {
    eventProcessingState.value = eventProcessingState.value
        .copyWith(eventProcessingState: RequestState.loading);
    final result = await endEventUseCase(event.id);

    result.fold(
        (l) => eventProcessingState.value = eventProcessingState.value.copyWith(
              eventProcessingMessage: l.message,
              eventProcessingState: RequestState.error,
            ), (r) {
      return eventProcessingState.value = eventProcessingState.value.copyWith(
          eventProcessingMessage: r,
          eventProcessingState: RequestState.loaded,
          eventProcessingResponse: r);
    });
  }

  addAdminComment(String comment) async {
    eventProcessingState.value = eventProcessingState.value
        .copyWith(commentState: RequestState.loading);
    final result = await addAdminNoteUseCase(
        AdminNoteParameters(note: comment, activityId: event.id)).then((value) => endEvent());

    result.fold(
        (l) => eventProcessingState.value = eventProcessingState.value.copyWith(
              eventProcessingMessage: l.message,
          commentState: RequestState.error,
            ), (r) {
      return eventProcessingState.value = eventProcessingState.value.copyWith(
          eventProcessingMessage: r,
          commentState: RequestState.loaded,
          eventProcessingResponse: r);
    });
  }

  @override
  List<Object?> get props => [
        registerInEventUseCase,
        endEventUseCase,
        addAdminNoteUseCase,
        eventProcessingState,
      ];

  @override
  bool? get stringify => throw UnimplementedError();
}
