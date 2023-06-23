import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/management/domain/entities/measurement.dart';
import 'package:takatof/management/domain/repositories/base_evaluation_repository.dart';

class SaveEvaluateUseCase
    extends BaseUseCase<String, SaveEvaluationParameters> {
  final BaseEvaluationRepository baseEvaluationRepository;

  SaveEvaluateUseCase(this.baseEvaluationRepository);

  @override
  Future<Either<Failure, String>> call(
      SaveEvaluationParameters parameters) async {
    return await baseEvaluationRepository.saveEvaluation(parameters);
  }
}

class SaveEvaluationParameters extends Equatable {
  final int eventId;
  final int volunteerId;
  final int day;
  final List<Measurement> measurement;

  const SaveEvaluationParameters(
      {required this.eventId,
      required this.volunteerId,
      required this.day,
      required this.measurement});

  @override
  List<Object?> get props => [
        eventId,
        volunteerId,
        day,
        measurement,
      ];
}
