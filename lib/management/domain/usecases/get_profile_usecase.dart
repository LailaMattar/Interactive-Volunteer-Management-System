import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/management/domain/entities/profile.dart';
import 'package:takatof/management/domain/repositories/base_management_repository.dart';

class GetProfileUseCase extends BaseUseCase<Profile,GetProfileParameters>{
  final BaseManagementRepository baseManagementRepository;

  GetProfileUseCase(this.baseManagementRepository);

  @override
  Future<Either<Failure, Profile>> call(GetProfileParameters parameters) async{
    return baseManagementRepository.getProfile(parameters);
  }

}

class GetProfileParameters extends Equatable{
  final int id;

  const GetProfileParameters({required this.id});

  @override
  List<Object?> get props => [
    id,
  ];


}