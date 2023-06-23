import 'package:get_it/get_it.dart';
import 'package:takatof/management/data/datasource/evaluation_remote_datasource.dart';
import 'package:takatof/management/data/datasource/management_remote_datasource.dart';
import 'package:takatof/management/data/datasource/task_remote_datasource.dart';
import 'package:takatof/management/data/repositories/evaluation_repository.dart';
import 'package:takatof/management/data/repositories/management_repository.dart';
import 'package:takatof/management/data/repositories/task_repository.dart';
import 'package:takatof/management/domain/repositories/base_evaluation_repository.dart';
import 'package:takatof/management/domain/repositories/base_management_repository.dart';
import 'package:takatof/management/domain/repositories/base_task_repository.dart';
import 'package:takatof/management/domain/usecases/accept_register_request_usecase.dart';
import 'package:takatof/management/domain/usecases/accept_task_usecase.dart';
import 'package:takatof/management/domain/usecases/add_admin_note_usecase.dart';
import 'package:takatof/management/domain/usecases/add_volunteer_comment_usecase.dart';
import 'package:takatof/management/domain/usecases/end_event_usecase.dart';
import 'package:takatof/management/domain/usecases/generate_qr_code_usecase.dart';
import 'package:takatof/management/domain/usecases/get_admin_event_usecase.dart';
import 'package:takatof/management/domain/usecases/get_evaluation_usecase.dart';
import 'package:takatof/management/domain/usecases/get_event_details_usecase.dart';
import 'package:takatof/management/domain/usecases/get_initiative_usecase.dart';
import 'package:takatof/management/domain/usecases/get_new_task_usecase.dart';
import 'package:takatof/management/domain/usecases/get_profile_usecase.dart';
import 'package:takatof/management/domain/usecases/get_register_requests_usecase.dart';
import 'package:takatof/management/domain/usecases/get_volunteers_for_attend_usecase.dart';
import 'package:takatof/management/domain/usecases/get_volunteers_for_evaluate_usecase.dart';
import 'package:takatof/management/domain/usecases/like_event_usecase.dart';
import 'package:takatof/management/domain/usecases/register_in_event_usecase.dart';
import 'package:takatof/management/domain/usecases/reject_task_usecase.dart';
import 'package:takatof/management/domain/usecases/save_attend_usecase.dart';
import 'package:takatof/management/domain/usecases/save_evaluation_usecase.dart';
import 'package:takatof/management/domain/usecases/scan_qr_code_usecase.dart';
import 'package:takatof/management/domain/usecases/upload_profile_image_usecase.dart';

final sl = GetIt.instance;

class ServicesLocator{
  void init(){
    /// USE CASE
    ///
    /// MANAGEMENT USE CASE
    sl.registerLazySingleton(() => GetInitiativeUseCase(sl<BaseManagementRepository>()));
    sl.registerLazySingleton(() => RegisterInEventUseCase(sl<BaseManagementRepository>()));
    sl.registerLazySingleton(() => EndEventUseCase(sl<BaseManagementRepository>()));
    sl.registerLazySingleton(() => AddAdminNoteUseCase(sl<BaseManagementRepository>()));
    sl.registerLazySingleton(() => AddVolunteerCommentUseCase(sl<BaseManagementRepository>()));
    sl.registerLazySingleton(() => LikeEventUseCase(sl<BaseManagementRepository>()));
    sl.registerLazySingleton(() => GetAdminEventUseCase(sl<BaseManagementRepository>()));
    sl.registerLazySingleton(() => GenerateQRCodeUseCase(sl<BaseManagementRepository>()));
    sl.registerLazySingleton(() => ScanQRCodeUseCase(sl<BaseManagementRepository>()));
    sl.registerLazySingleton(() => GetRegisterRequestsUseCase(sl<BaseManagementRepository>()));
    sl.registerLazySingleton(() => AcceptRegisterRequestUseCase(sl<BaseManagementRepository>()));
    sl.registerLazySingleton(() => GetProfileUseCase(sl<BaseManagementRepository>()));
    sl.registerLazySingleton(() => UploadProfileImageUseCase(sl<BaseManagementRepository>()));
    sl.registerLazySingleton(() => GetEventDetailsUseCase(sl<BaseManagementRepository>()));
    /// TASK USE CASE
    sl.registerLazySingleton(() => RejectTaskUseCase(sl<BaseTaskRepository>()));
    sl.registerLazySingleton(() => RegisterToTaskUseCase(sl<BaseTaskRepository>()));
    sl.registerLazySingleton(() => GetNewTaskUseCase(sl<BaseTaskRepository>()));
    /// EVALUATION  USE CASE
    sl.registerLazySingleton(()=>GetVolunteersForAttendUseCase(sl<BaseEvaluationRepository>()));
    sl.registerLazySingleton(()=>SaveAttendUseCase(sl<BaseEvaluationRepository>()));
    sl.registerLazySingleton(()=>GetVolunteersForEvaluateUseCase(sl<BaseEvaluationRepository>()));
    sl.registerLazySingleton(()=>GetEvaluationUseCase(sl<BaseEvaluationRepository>()));
    sl.registerLazySingleton(()=>SaveEvaluateUseCase(sl<BaseEvaluationRepository>()));

    /// REPOSITORY
    ///
    /// MANAGEMENT REPOSITORY
    sl.registerLazySingleton<BaseManagementRepository>(() => ManagementRepository(sl()) );
    /// TASK REPOSITORY
    sl.registerLazySingleton<BaseTaskRepository>(() => TaskRepository(sl()) );
    /// EVALUATION REPOSITORY
    sl.registerLazySingleton<BaseEvaluationRepository>(() => EvaluationRepository(sl()));

    /// DATA SOURCE
    ///
    /// MANAGEMENT DATA SOURCE
    sl.registerLazySingleton<BaseManagementDataSource>(() => ManagementDataSource());
    /// TASK DATA SOURCE
    sl.registerLazySingleton<BaseTaskRemoteDataSource>(() => TaskRemoteDataSource());
    /// EVALUATION DATA SOURCE
    sl.registerLazySingleton<BaseEvaluationRemoteDataSource>(() => EvaluationRemoteDataSource());
  }
}