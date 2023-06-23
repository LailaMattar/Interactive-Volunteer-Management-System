import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/management/domain/entities/volunteer.dart';
import 'package:takatof/management/domain/repositories/base_evaluation_repository.dart';

class GetVolunteersForAttendUseCase extends BaseUseCase<List<Volunteer>,VolunteersForAttendParameters>{
  final BaseEvaluationRepository baseEvaluationRepository;

  GetVolunteersForAttendUseCase(this.baseEvaluationRepository);

  @override
  Future<Either<Failure, List<Volunteer>>> call(VolunteersForAttendParameters parameters) async{
    return await baseEvaluationRepository.getVolunteerForAttend(parameters);
  }

}

class VolunteersForAttendParameters extends Equatable{
  final int eventId;
  final int day;

  const VolunteersForAttendParameters({required this.eventId,required this.day});

  @override
  List<Object?> get props => [
    eventId,
    day,
  ];

}