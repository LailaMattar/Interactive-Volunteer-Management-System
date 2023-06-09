import 'package:dartz/dartz.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/management/domain/entities/auth.dart';
import 'package:takatof/management/domain/repositories/base_management_repository.dart';

class LoginUseCase extends BaseUseCase<String,Auth>{
  final BaseManagementRepository baseManagementRepository;

  LoginUseCase(this.baseManagementRepository);
  
  @override
  Future<Either<Failure, String>> call(Auth parameters) async{
    return await baseManagementRepository.login(parameters);
  }

}