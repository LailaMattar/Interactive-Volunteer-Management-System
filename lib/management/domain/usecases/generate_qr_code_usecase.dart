import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/management/domain/repositories/base_management_repository.dart';

class GenerateQRCodeUseCase extends BaseUseCase<String,GenerateQRCodeParameters>{
  final BaseManagementRepository baseManagementRepository;

  GenerateQRCodeUseCase(this.baseManagementRepository);

  @override
  Future<Either<Failure, String>> call(GenerateQRCodeParameters parameters) async{
    return await baseManagementRepository.generateQRCode(parameters);
  }

}

class GenerateQRCodeParameters extends Equatable{
  final int eventId;

  const GenerateQRCodeParameters({required this.eventId});

  @override
  List<Object?> get props => [
    eventId,
  ];


}