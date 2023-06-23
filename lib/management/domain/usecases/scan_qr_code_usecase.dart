import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/management/domain/repositories/base_management_repository.dart';

class ScanQRCodeUseCase extends BaseUseCase<String,ScanQRCodeParameters>{
  BaseManagementRepository baseManagementRepository;

  ScanQRCodeUseCase(this.baseManagementRepository);

  @override
  Future<Either<Failure, String>> call(ScanQRCodeParameters parameters) async{
    return await baseManagementRepository.scanQRCode(parameters);
  }

}

class ScanQRCodeParameters extends Equatable{
  final String qrString;
  final int eventId;
  final int volunteerId;

  const ScanQRCodeParameters({required this.qrString,required this.eventId,required this.volunteerId});

  @override
  List<Object?> get props => [
    qrString,
    eventId,
    volunteerId,
  ];
}