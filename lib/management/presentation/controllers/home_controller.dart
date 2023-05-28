import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/entities/project.dart';
import 'package:takatof/management/domain/usecases/get_events_usecase.dart';
import 'package:takatof/management/domain/usecases/get_projects_usecase.dart';
import 'package:takatof/management/presentation/controllers/home_state.dart';

class HomeController extends GetxController implements Equatable {
  final GetProjectsUseCase getProjectsUseCase;
  final GetEventsUseCase getEventsUseCase;
  Rx<HomeState> homeState;

  HomeController({required this.getProjectsUseCase ,required this.getEventsUseCase ,required this.homeState});

  @override
  List<Object?> get props => [getProjectsUseCase,getEventsUseCase,homeState];

  void getProjects() async {
    homeState.value = homeState.value.copyWith(projectsState: RequestState.loading);
    final result = await getProjectsUseCase(const NoParameters());

    result.fold(
      (l) => homeState.value = homeState.value.copyWith(
        projectsMessage: l.message,
        projectsState: RequestState.error,
      ),
      (r) => homeState.value = homeState.value.copyWith(
          projectsMessage: "success",
          projectsState: RequestState.loaded,
          projects: r),
    );
  }

  void getEvents() async {
    homeState.value = homeState.value.copyWith(eventsState: RequestState.loading);
    final result = await getEventsUseCase(const NoParameters());

    result.fold(
      (l) => homeState.value = homeState.value.copyWith(
        eventsMessage: l.message,
        eventsState: RequestState.error,
      ),
      (r) => homeState.value = homeState.value.copyWith(
          eventsMessage: "success",
          eventsState: RequestState.loaded,
          events: r),
    );
  }

  @override
  void onInit() {
    print('initttt');
    super.onInit();
    getProjects();
    getEvents();
  }

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}
