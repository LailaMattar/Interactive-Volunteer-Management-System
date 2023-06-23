import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/management/domain/repositories/base_management_repository.dart';

class AddVolunteerCommentUseCase extends BaseUseCase<String,VolunteerCommentParameters>{
  BaseManagementRepository baseManagementRepository;

  AddVolunteerCommentUseCase(this.baseManagementRepository);

  @override
  Future<Either<Failure, String>> call(VolunteerCommentParameters parameters) async{
    return await baseManagementRepository.addVolunteerComment(parameters);
  }

}

class VolunteerCommentParameters extends Equatable{
  final String comment;
  final int eventId;


  const VolunteerCommentParameters({required this.comment, required this.eventId});

  @override
  List<Object?> get props => [
    comment,
    eventId,
  ];

}