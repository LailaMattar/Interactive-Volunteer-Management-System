import 'package:dartz/dartz.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/management/domain/repositories/base_task_repository.dart';

class RejectTaskUseCase extends BaseUseCase<String,int>{
  final BaseTaskRepository baseTaskRepository;

  RejectTaskUseCase(this.baseTaskRepository);

  @override
  Future<Either<Failure, String>> call(int parameters) async{
    return await baseTaskRepository.rejectTask(parameters);
  }

}