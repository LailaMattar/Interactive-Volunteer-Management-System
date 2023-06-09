import 'package:dartz/dartz.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/management/domain/repositories/base_task_repository.dart';

class RegisterToTaskUseCase extends BaseUseCase<String,int>{
  BaseTaskRepository baseTaskRepository;

  RegisterToTaskUseCase(this.baseTaskRepository);

  @override
  Future<Either<Failure, String>> call(int parameters) async{
    return await baseTaskRepository.registerToTask(parameters);
  }
}