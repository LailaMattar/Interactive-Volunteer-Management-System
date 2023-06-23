import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/management/domain/repositories/base_evaluation_repository.dart';
import 'package:takatof/management/domain/usecases/get_volunteers_for_attend_usecase.dart';

class SaveAttendUseCase extends BaseUseCase<String,SaveAttendParameters>{
  final BaseEvaluationRepository baseEvaluationRepository;

  SaveAttendUseCase(this.baseEvaluationRepository);

  @override
  Future<Either<Failure, String>> call(SaveAttendParameters parameters) async{
    return await baseEvaluationRepository.saveAttend(parameters);
  }

}

class SaveAttendParameters extends Equatable{
  final int eventId;
  final int day;
  List<int> ids;

  SaveAttendParameters({required this.eventId,required this.day,required this.ids});

  @override
  List<Object?> get props => [
    eventId,
    day,
    ids
  ];

}