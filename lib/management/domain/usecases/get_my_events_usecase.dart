import 'package:dartz/dartz.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/management/domain/entities/event.dart';
import 'package:takatof/management/domain/repositories/base_management_repository.dart';

class GetMyEventUseCase extends BaseUseCase<List<Event>,NoParameters>{
  final BaseManagementRepository baseManagementRepository;

  GetMyEventUseCase(this.baseManagementRepository);

  @override
  Future<Either<Failure, List<Event>>> call(NoParameters parameters) async{
    return await baseManagementRepository.getMyEvents();
  }
}