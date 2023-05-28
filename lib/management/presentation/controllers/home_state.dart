import 'package:equatable/equatable.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/entities/event.dart';
import 'package:takatof/management/domain/entities/project.dart';

class HomeState extends Equatable {
  final List<Project> projects;
  final RequestState projectsState;
  final String projectsMessage;

  final List<Event> events;
  final RequestState eventsState;
  final String eventsMessage;

  const HomeState({
    this.projectsState = RequestState.loading,
    this.projects = const [],
    this.projectsMessage = '',
    this.eventsState = RequestState.loading,
    this.events = const [],
    this.eventsMessage = '',
  });

  HomeState copyWith({
    List<Project>? projects,
    RequestState? projectsState,
    String? projectsMessage,
    List<Event>? events,
    RequestState? eventsState,
    String? eventsMessage,
  }) {
    return HomeState(
        projects: projects ?? this.projects,
        projectsState: projectsState ?? this.projectsState,
        projectsMessage: projectsMessage ?? this.projectsMessage,
        events: events ?? this.events,
        eventsState: eventsState ?? this.eventsState,
        eventsMessage: eventsMessage ?? this.eventsMessage);
  }

  @override
  List<Object?> get props => [
        projects,
        projectsState,
        projectsMessage,
        events,
        eventsState,
        eventsMessage,
      ];
}
