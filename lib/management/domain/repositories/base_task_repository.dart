import 'package:dartz/dartz.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/management/domain/entities/task.dart';

abstract class BaseTaskRepository{
  Future<Either<Failure,List<MyTask>>> getMyTasks();

  Future<Either<Failure,String>> registerToTask(int parameters);

  Future<Either<Failure,String>> rejectTask(int parameters);

  Future<Either<Failure,List<MyTask>>> getNewTasks();
}