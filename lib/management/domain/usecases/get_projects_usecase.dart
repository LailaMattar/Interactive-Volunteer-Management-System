import 'package:dartz/dartz.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/management/domain/entities/project.dart';
import 'package:takatof/management/domain/repositories/base_management_repository.dart';

class GetProjectsUseCase extends BaseUseCase<List<Project>,NoParameters>{
  final BaseManagementRepository baseManagementRepository;

  GetProjectsUseCase(this.baseManagementRepository);

  @override
  Future<Either<Failure, List<Project>>> call(NoParameters parameters) async{
    return await baseManagementRepository.getProjects();
  }
}