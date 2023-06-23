import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/core/usecase/base_usecase.dart';
import 'package:takatof/management/domain/entities/event_details.dart';
import 'package:takatof/management/domain/repositories/base_management_repository.dart';

class GetEventDetailsUseCase extends BaseUseCase<EventDetails,GetEventDetailsParameters>{
  final BaseManagementRepository baseManagementRepository;

  GetEventDetailsUseCase(this.baseManagementRepository);

  @override
  Future<Either<Failure, EventDetails>> call(GetEventDetailsParameters parameters) async{
    return await baseManagementRepository.getEventDetails(parameters);
  }

}

class GetEventDetailsParameters extends Equatable{
  final int eventId;

  const GetEventDetailsParameters({required this.eventId});

  @override
  List<Object?> get props => [
    eventId,
  ];

}