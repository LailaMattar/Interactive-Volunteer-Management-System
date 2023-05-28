import 'package:dartz/dartz.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/management/domain/entities/task.dart';

abstract class BaseTaskRepository{
  Future<Either<Failure,List<MyTask>>> getMyTasks();

  Future<Either<Failure,String>> acceptTask(int parameters);

  Future<Either<Failure,String>> rejectTask(int parameters);
}