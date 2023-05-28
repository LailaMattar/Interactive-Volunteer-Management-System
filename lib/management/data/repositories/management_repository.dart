import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:takatof/core/error/exceptions.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/management/data/datasource/management_remote_datasource.dart';
import 'package:takatof/management/domain/entities/Initiative.dart';
import 'package:takatof/management/domain/entities/event.dart';
import 'package:takatof/management/domain/entities/project.dart';
import 'package:takatof/management/domain/entities/volunteer.dart';
import 'package:takatof/management/domain/repositories/base_management_repository.dart';

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
  Future<Either<Failure, String>> login(Volunteer parameters) async{
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
}