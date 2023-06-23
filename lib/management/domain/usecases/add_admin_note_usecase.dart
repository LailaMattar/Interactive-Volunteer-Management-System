import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/management/domain/repositories/base_management_repository.dart';

class AddAdminNoteUseCase extends BaseUseCase<String, AdminNoteParameters> {
  BaseManagementRepository baseManagementRepository;

  AddAdminNoteUseCase(this.baseManagementRepository);

  @override
  Future<Either<Failure, String>> call(AdminNoteParameters parameters) async{
    return await baseManagementRepository.addAdminNote(parameters);
  }
}

class AdminNoteParameters extends Equatable {
  final String note;
  final int activityId;

  const AdminNoteParameters({required this.note, required this.activityId});

  @override
  List<Object?> get props => [
        note,
        activityId,
      ];
}
