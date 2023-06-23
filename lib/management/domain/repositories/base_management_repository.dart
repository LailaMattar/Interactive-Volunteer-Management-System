import 'package:dartz/dartz.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/management/domain/entities/Initiative.dart';
import 'package:takatof/management/domain/entities/event.dart';
import 'package:takatof/management/domain/entities/event_details.dart';
import 'package:takatof/management/domain/entities/profile.dart';
import 'package:takatof/management/domain/entities/project.dart';
import 'package:takatof/management/domain/entities/auth.dart';
import 'package:takatof/management/domain/entities/register_request.dart';
import 'package:takatof/management/domain/entities/volunteer.dart';
import 'package:takatof/management/domain/usecases/accept_register_request_usecase.dart';
import 'package:takatof/management/domain/usecases/add_admin_note_usecase.dart';
import 'package:takatof/management/domain/usecases/add_volunteer_comment_usecase.dart';
import 'package:takatof/management/domain/usecases/generate_qr_code_usecase.dart';
import 'package:takatof/management/domain/usecases/get_event_details_usecase.dart';
import 'package:takatof/management/domain/usecases/get_profile_usecase.dart';
import 'package:takatof/management/domain/usecases/get_register_requests_usecase.dart';
import 'package:takatof/management/domain/usecases/like_event_usecase.dart';
import 'package:takatof/management/domain/usecases/scan_qr_code_usecase.dart';
import 'package:takatof/management/domain/usecases/upload_profile_image_usecase.dart';

abstract class BaseManagementRepository{
  Future<Either<Failure,String>> login(Auth parameters);

  Future<Either<Failure,List<Project>>> getProjects();

  Future<Either<Failure,List<Event>>> getEvents();

  Future<Either<Failure,List<Event>>> getMyEvents();

  Future<Either<Failure,List<Event>>> getAdminEvents();

  Future<Either<Failure,Initiative>> getInitiativeDetails(int parameters);

  Future<Either<Failure,String>> registerInEvent(int parameters);

  Future<Either<Failure,String>> endEvent(int parameters);

  Future<Either<Failure,String>> addAdminNote(AdminNoteParameters parameters);

  Future<Either<Failure,String>> addVolunteerComment(VolunteerCommentParameters parameters);

  Future<Either<Failure,String>> likeEvent(LikeEventParameters parameters);

  Future<Either<Failure,String>> generateQRCode(GenerateQRCodeParameters parameters);

  Future<Either<Failure,String>> scanQRCode(ScanQRCodeParameters parameters);

  Future<Either<Failure,List<RegisterRequest>>> getRegisterRequests(GetRegisterRequestsParameters parameters);

  Future<Either<Failure,String>> acceptRegisterRequest(AcceptRegisterRequestParameters parameters);

  Future<Either<Failure,Profile>> getProfile(GetProfileParameters parameters);

  Future<Either<Failure,String>> uploadPhoto(UploadProfileImageParameters parameters);

  Future<Either<Failure,EventDetails>> getEventDetails(GetEventDetailsParameters parameters);
}