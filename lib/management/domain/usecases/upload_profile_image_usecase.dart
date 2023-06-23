import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/management/domain/repositories/base_management_repository.dart';

class UploadProfileImageUseCase
    extends BaseUseCase<String, UploadProfileImageParameters> {
  final BaseManagementRepository baseManagementRepository;

  UploadProfileImageUseCase(this.baseManagementRepository);

  @override
  Future<Either<Failure, String>> call(UploadProfileImageParameters parameters) async{
    return await baseManagementRepository.uploadPhoto(parameters);
  }

}

class UploadProfileImageParameters extends Equatable {
  final String path;
  final String imageName;
  final String volunteerId;

  const UploadProfileImageParameters(
      {required this.path, required this.imageName, required this.volunteerId});

  @override
  List<Object?> get props => [
    path,
    imageName,
    volunteerId,
  ];
}
