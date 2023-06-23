import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/management/domain/entities/volunteer.dart';
import 'package:takatof/management/domain/repositories/base_evaluation_repository.dart';

class GetVolunteersForEvaluateUseCase extends BaseUseCase<List<Volunteer>,VolunteersForEvaluateParameters>{
  final BaseEvaluationRepository baseEvaluationRepository;

  GetVolunteersForEvaluateUseCase(this.baseEvaluationRepository);

  @override
  Future<Either<Failure, List<Volunteer>>> call(VolunteersForEvaluateParameters parameters) async{
    return await baseEvaluationRepository.getVolunteerForEvaluate(parameters);
  }

}

class VolunteersForEvaluateParameters extends Equatable{
  final int eventId;
  final int day;

  const VolunteersForEvaluateParameters({required this.eventId,required this.day});

  @override
  List<Object?> get props => [
    eventId,
    day,
  ];

}