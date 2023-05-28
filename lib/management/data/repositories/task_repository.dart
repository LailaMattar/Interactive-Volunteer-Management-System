import 'package:dartz/dartz.dart';
import 'package:takatof/core/error/exceptions.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/management/data/datasource/task_remote_datasource.dart';
import 'package:takatof/management/domain/entities/task.dart';
import 'package:takatof/management/domain/repositories/base_task_repository.dart';

class TaskRepository extends BaseTaskRepository{
  BaseTaskRemoteDataSource baseTaskRemoteDataSource;

  TaskRepository(this.baseTaskRemoteDataSource);

  @override
  Future<Either<Failure, List<MyTask>>> getMyTasks() async{
    try{
      final result =await baseTaskRemoteDataSource.getMyTasks();
      return Right(result);
    }on ServerException catch (failure){
      print("exception my tasks");
      return Left(ServerFailure(message: failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, String>> acceptTask(int parameters) async{
    try{
      final result =await baseTaskRemoteDataSource.acceptTask(parameters);
      return Right(result);
    }on ServerException catch (failure){
      print("exception accept task");
      return Left(ServerFailure(message: failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, String>> rejectTask(int parameters) async{
    try{
      final result =await baseTaskRemoteDataSource.rejectTask(parameters);
      return Right(result);
    }on ServerException catch (failure){
      print("exception reject task");
      return Left(ServerFailure(message: failure.errorModel.statusMessage));
    }
  }



}