import 'package:dartz/dartz.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/management/domain/entities/task.dart';
import 'package:takatof/management/domain/repositories/base_task_repository.dart';

class GetNewTaskUseCase extends BaseUseCase<List<MyTask>,NoParameters>{
  final BaseTaskRepository baseTaskRepository;

  GetNewTaskUseCase(this.baseTaskRepository);

  @override
  Future<Either<Failure, List<MyTask>>> call(NoParameters parameters) async{
    return await baseTaskRepository.getNewTasks();
  }

}