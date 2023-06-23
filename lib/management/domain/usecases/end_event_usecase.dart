import 'package:dartz/dartz.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/management/domain/repositories/base_management_repository.dart';

class EndEventUseCase extends BaseUseCase<String,int>{
  BaseManagementRepository baseManagementRepository;


  EndEventUseCase(this.baseManagementRepository);

  @override
  Future<Either<Failure, String>> call(int parameters) async{
    return await baseManagementRepository.endEvent(parameters);
  }
}