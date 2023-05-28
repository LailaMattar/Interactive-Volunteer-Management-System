import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/entities/event.dart';
import 'package:takatof/management/domain/usecases/register_in_event_usecase.dart';
import 'package:takatof/management/presentation/controllers/event_processing_state.dart';

class EventProcessingController extends GetxController implements Equatable {
  final RegisterInEventUseCase registerInEventUseCase;
  final Rx<EventProcessingState> eventProcessingState;
  final Event event;

  EventProcessingController({
    required this.eventProcessingState,
    required this.registerInEventUseCase,
    required this.event,
  });

  registerInEvent() async {
    eventProcessingState.value = eventProcessingState.value
        .copyWith(registerInEventState: RequestState.loading);
    final result = await registerInEventUseCase(event.id);

    result.fold(
            (l) => eventProcessingState.value = eventProcessingState.value.copyWith(
          registerInEventMessage: l.message,
          registerInEventState: RequestState.error,
        ), (r) {
      return eventProcessingState.value = eventProcessingState.value.copyWith(
          registerInEventMessage: r,
          registerInEventState: RequestState.loaded,
          registerInEventResponse: r);
    });
  }

  @override
  List<Object?> get props => [
        registerInEventUseCase,
        eventProcessingState,
      ];

  @override
  bool? get stringify => throw UnimplementedError();
}
