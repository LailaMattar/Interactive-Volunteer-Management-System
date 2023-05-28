import 'package:dartz/dartz.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/management/domain/entities/task.dart';
import 'package:takatof/management/domain/repositories/base_task_repository.dart';

class GetMyTasksUseCase extends BaseUseCase<List<MyTask>,NoParameters>{
  final BaseTaskRepository baseTaskRepository;


  GetMyTasksUseCase(this.baseTaskRepository);

  @override
  Future<Either<Failure, List<MyTask>>> call(NoParameters parameters) async{
    return await baseTaskRepository.getMyTasks();
  }
}