import 'package:dartz/dartz.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/management/domain/entities/Initiative.dart';
import 'package:takatof/management/domain/repositories/base_management_repository.dart';

class GetInitiativeUseCase extends BaseUseCase<Initiative,int>{
  final BaseManagementRepository baseManagementRepository;

  GetInitiativeUseCase(this.baseManagementRepository);

  @override
  Future<Either<Failure, Initiative>> call(int parameters) async{
    return await baseManagementRepository.getInitiativeDetails(parameters);
  }

}