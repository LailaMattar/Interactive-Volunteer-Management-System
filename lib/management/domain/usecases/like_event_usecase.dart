import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/management/domain/repositories/base_management_repository.dart';

class LikeEventUseCase extends BaseUseCase<String,LikeEventParameters>{
  BaseManagementRepository baseManagementRepository;

  LikeEventUseCase(this.baseManagementRepository);

  @override
  Future<Either<Failure, String>> call(LikeEventParameters parameters) async{
    return await baseManagementRepository.likeEvent(parameters);
  }

}

class LikeEventParameters extends Equatable{
  final int activityId;

  const LikeEventParameters({required this.activityId});

  @override
  List<Object?> get props => [
    activityId,
  ];

}