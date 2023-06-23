import 'package:dartz/dartz.dart';
import 'package:takatof/core/error/exceptions.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/management/data/datasource/evaluation_remote_datasource.dart';
import 'package:takatof/management/domain/entities/evaluation.dart';
import 'package:takatof/management/domain/entities/volunteer.dart';
import 'package:takatof/management/domain/repositories/base_evaluation_repository.dart';
import 'package:takatof/management/domain/usecases/get_evaluation_usecase.dart';
import 'package:takatof/management/domain/usecases/get_volunteers_for_attend_usecase.dart';
import 'package:takatof/management/domain/usecases/get_volunteers_for_evaluate_usecase.dart';
import 'package:takatof/management/domain/usecases/save_attend_usecase.dart';
import 'package:takatof/management/domain/usecases/save_evaluation_usecase.dart';

class EvaluationRepository extends BaseEvaluationRepository{
  final BaseEvaluationRemoteDataSource baseEvaluationRemoteDataSource;

  EvaluationRepository(this.baseEvaluationRemoteDataSource);

  @override
  Future<Either<Failure, List<Volunteer>>> getVolunteerForAttend(VolunteersForAttendParameters parameters) async{
    try{
      final result =await baseEvaluationRemoteDataSource.getVolunteersForAttend(parameters);
      return Right(result);
    }on ServerException catch (failure){
      print("exceptionnnnn");
      return Left(ServerFailure(message: failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, String>> saveAttend(SaveAttendParameters parameters) async{
    try{
      final result =await baseEvaluationRemoteDataSource.saveAttend(parameters);
      return Right(result);
    }on ServerException catch (failure){
      print("exceptionnnnn");
      return Left(ServerFailure(message: failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Volunteer>>> getVolunteerForEvaluate(VolunteersForEvaluateParameters parameters)async{
    try{
      final result =await baseEvaluationRemoteDataSource.getVolunteersForEvaluate(parameters);
      return Right(result);
    }on ServerException catch (failure){
      print("exceptionnnnn getVolunteerForEvaluate");
      return Left(ServerFailure(message: failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, MyEvaluation>> getEvaluation(EvaluationParameters parameters) async{
    try{
      final result =await baseEvaluationRemoteDataSource.getEvaluation(parameters);
      return Right(result);
    }on ServerException catch (failure){
      print("exceptionnnnn getEvaluation");
      return Left(ServerFailure(message: failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, String>> saveEvaluation(SaveEvaluationParameters parameters) async{
    try{
      final result =await baseEvaluationRemoteDataSource.saveEvaluation(parameters);
      return Right(result);
    }on ServerException catch (failure){
      print("exceptionnnnn saveEvaluation");
      return Left(ServerFailure(message: failure.errorModel.statusMessage));
    }
  }

}