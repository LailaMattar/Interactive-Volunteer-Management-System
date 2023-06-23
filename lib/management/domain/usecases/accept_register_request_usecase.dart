import 'package:dartz/dartz.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/management/domain/repositories/base_management_repository.dart';

class AcceptRegisterRequestUseCase
    extends BaseUseCase<String, AcceptRegisterRequestParameters> {
  final BaseManagementRepository baseManagementRepository;

  AcceptRegisterRequestUseCase(this.baseManagementRepository);

  @override
  Future<Either<Failure, String>> call(AcceptRegisterRequestParameters parameters) async{
    return await baseManagementRepository.acceptRegisterRequest(parameters);
  }
}

class AcceptRegisterRequestParameters {
  final int eventId;
  final int volunteerId;

  AcceptRegisterRequestParameters(
      {required this.eventId, required this.volunteerId});
}
