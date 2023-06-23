import 'package:dartz/dartz.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/management/domain/entities/evaluation.dart';
import 'package:takatof/management/domain/entities/volunteer.dart';
import 'package:takatof/management/domain/usecases/get_evaluation_usecase.dart';
import 'package:takatof/management/domain/usecases/get_volunteers_for_attend_usecase.dart';
import 'package:takatof/management/domain/usecases/get_volunteers_for_evaluate_usecase.dart';
import 'package:takatof/management/domain/usecases/save_attend_usecase.dart';
import 'package:takatof/management/domain/usecases/save_evaluation_usecase.dart';

abstract class BaseEvaluationRepository{
  Future<Either<Failure,List<Volunteer>>> getVolunteerForAttend(VolunteersForAttendParameters parameters);

  Future<Either<Failure,String>> saveAttend(SaveAttendParameters parameters);

  Future<Either<Failure,List<Volunteer>>> getVolunteerForEvaluate(VolunteersForEvaluateParameters parameters);

  Future<Either<Failure,MyEvaluation>> getEvaluation(EvaluationParameters parameters);

  Future<Either<Failure,String>> saveEvaluation(SaveEvaluationParameters parameters);
}