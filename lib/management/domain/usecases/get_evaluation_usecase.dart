import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/management/domain/entities/evaluation.dart';
import 'package:takatof/management/domain/repositories/base_evaluation_repository.dart';

class GetEvaluationUseCase extends BaseUseCase<MyEvaluation,EvaluationParameters>{
  final BaseEvaluationRepository baseEvaluationRepository;

  GetEvaluationUseCase(this.baseEvaluationRepository);

  @override
  Future<Either<Failure, MyEvaluation>> call(EvaluationParameters parameters) async{
    return await baseEvaluationRepository.getEvaluation(parameters);
  }

}

class EvaluationParameters extends Equatable {
  final int eventId;
  final int volunteerId;
  final int day;

  const EvaluationParameters(
      {required this.eventId, required this.volunteerId, required this.day});

  @override
  List<Object?> get props => [
    eventId,
    volunteerId,
    day,
  ];
}
