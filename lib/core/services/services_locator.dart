import 'package:get_it/get_it.dart';
import 'package:takatof/management/data/datasource/management_remote_datasource.dart';
import 'package:takatof/management/data/datasource/task_remote_datasource.dart';
import 'package:takatof/management/data/repositories/management_repository.dart';
import 'package:takatof/management/data/repositories/task_repository.dart';
import 'package:takatof/management/domain/repositories/base_management_repository.dart';
import 'package:takatof/management/domain/repositories/base_task_repository.dart';
import 'package:takatof/management/domain/usecases/accept_task_usecase.dart';
import 'package:takatof/management/domain/usecases/get_initiative_usecase.dart';
import 'package:takatof/management/domain/usecases/register_in_event_usecase.dart';
import 'package:takatof/management/domain/usecases/reject_task_usecase.dart';

final sl = GetIt.instance;

class ServicesLocator{
  void init(){
    ///helper
    // sl.registerSingleton<DioHelper>(DioHelper());

    /// USE CASE
    ///
    /// MANAGEMENT USE CASE
    sl.registerLazySingleton(() => GetInitiativeUseCase(sl<BaseManagementRepository>()));
    sl.registerLazySingleton(() => RegisterInEventUseCase(sl<BaseManagementRepository>()));
    /// TASK USE CASE
    sl.registerLazySingleton(() => RejectTaskUseCase(sl<BaseTaskRepository>()));
    sl.registerLazySingleton(() => AcceptTaskUseCase(sl<BaseTaskRepository>()));

    /// REPOSITORY
    ///
    /// MANAGEMENT REPOSITORY
    sl.registerLazySingleton<BaseManagementRepository>(() => ManagementRepository(sl()) );
    /// TASK REPOSITORY
    sl.registerLazySingleton<BaseTaskRepository>(() => TaskRepository(sl()) );

    /// DATA SOURCE
    ///
    /// MANAGEMENT DATA SOURCE
    sl.registerLazySingleton<BaseManagementDataSource>(() => ManagementDataSource());
    /// TASK DATA SOURCE
    sl.registerLazySingleton<BaseTaskRemoteDataSource>(() => TaskRemoteDataSource());
  }
}