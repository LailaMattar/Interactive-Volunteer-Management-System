import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:takatof/core/error/exceptions.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/management/data/datasource/management_remote_datasource.dart';
import 'package:takatof/management/domain/entities/Initiative.dart';
import 'package:takatof/management/domain/entities/event.dart';
import 'package:takatof/management/domain/entities/event_details.dart';
import 'package:takatof/management/domain/entities/profile.dart';
import 'package:takatof/management/domain/entities/project.dart';
import 'package:takatof/management/domain/entities/auth.dart';
import 'package:takatof/management/domain/entities/register_request.dart';
import 'package:takatof/management/domain/repositories/base_management_repository.dart';
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

class ManagementRepository extends BaseManagementRepository{
  BaseManagementDataSource baseManagementDataSource;

  ManagementRepository(this.baseManagementDataSource);

  @override
  Future<Either<Failure, List<Project>>> getProjects() async{
    try{
      final result =await baseManagementDataSource.getProjects();
      return Right(result);
    }on ServerException catch (failure){
      print("exceptionnnnn");
      return Left(ServerFailure(message: failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, String>> login(Auth parameters) async{
    try{
      final result =await baseManagementDataSource.login(parameters);
      return Right(result);
    }on ServerException catch (failure){
      debugPrint("login exception ${failure.errorModel.statusMessage}");
      return Left(ServerFailure(message: failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Event>>> getEvents() async{
    try{
      final result =await baseManagementDataSource.getEvents();
      return Right(result);
    }on ServerException catch (failure){
      print("exception event");
      return Left(ServerFailure(message: failure.errorModel.statusMessage));
    }on AppException catch(failure){
      return  Left(AppFailure(message: failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Event>>> getMyEvents() async{
    try{
      final result =await baseManagementDataSource.getMyEvents();
      return Right(result);
    }on ServerException catch (failure){
      print("exception my event");
      return Left(ServerFailure(message: failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, Initiative>> getInitiativeDetails(int parameters) async{
    try{
      final result =await baseManagementDataSource.getInitiativeDetails(parameters);
      return Right(result);
    }on ServerException catch (failure){
      print("exception initiative");
      return Left(ServerFailure(message: failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, String>> registerInEvent(int parameters) async{
    try{
      final result =await baseManagementDataSource.registerInEvent(parameters);
      return Right(result);
    }on ServerException catch (failure){
      debugPrint("registerInEvent exception ${failure.errorModel.statusMessage}");
      return Left(ServerFailure(message: failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, String>> endEvent(int parameters) async{
    try{
      final result =await baseManagementDataSource.endEvent(parameters);
      return Right(result);
    }on ServerException catch (failure){
      debugPrint("endEvent exception ${failure.errorModel.statusMessage}");
      return Left(ServerFailure(message: failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, String>> addAdminNote(AdminNoteParameters parameters) async{
    try{
      final result =await baseManagementDataSource.addAdminNote(parameters);
      return Right(result);
    }on ServerException catch (failure){
      debugPrint("addAdminNote exception ${failure.errorModel.statusMessage}");
      return Left(ServerFailure(message: failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, String>> addVolunteerComment(VolunteerCommentParameters parameters) async{
    try{
      final result =await baseManagementDataSource.addVolunteerComment(parameters);
      return Right(result);
    }on ServerException catch (failure){
      debugPrint("addVolunteerComment exception ${failure.errorModel.statusMessage}");
      return Left(ServerFailure(message: failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, String>> likeEvent(LikeEventParameters parameters) async{
    try{
      final result =await baseManagementDataSource.likeEvent(parameters);
      return Right(result);
    }on ServerException catch (failure){
      debugPrint("likeEvent exception ${failure.errorModel.statusMessage}");
      return Left(ServerFailure(message: failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Event>>> getAdminEvents() async{
    try{
      final result =await baseManagementDataSource.getAdminEvents();
      return Right(result);
    }on ServerException catch (failure){
      print("exception my event");
      return Left(ServerFailure(message: failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, String>> generateQRCode(GenerateQRCodeParameters parameters) async{
    try{
      final result =await baseManagementDataSource.generateQRCode(parameters);
      return Right(result);
    }on ServerException catch (failure){
      print("exception generateQRCode");
      return Left(ServerFailure(message: failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, String>> scanQRCode(ScanQRCodeParameters parameters) async{
    try{
      final result =await baseManagementDataSource.scanQRCode(parameters);
      return Right(result);
    }on ServerException catch (failure){
      print("exception scanQRCode");
      return Left(ServerFailure(message: failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<RegisterRequest>>> getRegisterRequests(GetRegisterRequestsParameters parameters) async{
    try{
      final result =await baseManagementDataSource.getRegisterRequests(parameters);
      return Right(result);
    }on ServerException catch (failure){
      print("exception getRegisterRequests");
      return Left(ServerFailure(message: failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, String>> acceptRegisterRequest(AcceptRegisterRequestParameters parameters) async{
    try{
      final result =await baseManagementDataSource.acceptRegisterRequest(parameters);
      return Right(result);
    }on ServerException catch (failure){
      print("exception acceptRegisterRequest");
      return Left(ServerFailure(message: failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, Profile>> getProfile(GetProfileParameters parameters) async{
    try{
      final result =await baseManagementDataSource.getProfile(parameters);
      return Right(result);
    }on ServerException catch (failure){
      print("exception getProfile");
      return Left(ServerFailure(message: failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, String>> uploadPhoto(UploadProfileImageParameters parameters) async{
    try{
      final result =await baseManagementDataSource.uploadProfileImage(parameters);
      return Right(result);
    }on ServerException catch (failure){
      print("exception uploadPhoto");
      return Left(ServerFailure(message: failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, EventDetails>> getEventDetails(GetEventDetailsParameters parameters) async{
    try{
      final result =await baseManagementDataSource.getEventDetails(parameters);
      return Right(result);
    }on ServerException catch (failure){
      print("exception uploadPhoto");
      return Left(ServerFailure(message: failure.errorModel.statusMessage));
    }
  }
}