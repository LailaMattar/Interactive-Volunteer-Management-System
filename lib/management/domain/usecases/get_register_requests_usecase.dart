import 'package:dartz/dartz.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/management/domain/entities/register_request.dart';
import 'package:takatof/management/domain/entities/volunteer.dart';
import 'package:takatof/management/domain/repositories/base_management_repository.dart';

class GetRegisterRequestsUseCase extends BaseUseCase<List<RegisterRequest>,GetRegisterRequestsParameters>{
  final BaseManagementRepository baseManagementRepository;

  GetRegisterRequestsUseCase(this.baseManagementRepository);

  @override
  Future<Either<Failure, List<RegisterRequest>>> call(GetRegisterRequestsParameters parameters) async{
    return await baseManagementRepository.getRegisterRequests(parameters);
  }

}

class GetRegisterRequestsParameters {
  final int eventId;

  GetRegisterRequestsParameters({required this.eventId});
}