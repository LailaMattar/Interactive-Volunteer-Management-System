import 'package:equatable/equatable.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/entities/volunteer.dart';

class VolunteersEvaluateState extends Equatable{
  final List<Volunteer> volunteers;
  final RequestState state;
  final String message;


  const VolunteersEvaluateState({
    this.volunteers = const [],
    this.state = RequestState.loading,
    this.message = '',
  });

  VolunteersEvaluateState copyWith({
    List<Volunteer>? volunteers,
    RequestState? state,
    String? message,
}){
    return VolunteersEvaluateState(
      volunteers: volunteers ?? this.volunteers,
      state: state ?? this.state,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    volunteers,
    state,
    message,
  ];

}