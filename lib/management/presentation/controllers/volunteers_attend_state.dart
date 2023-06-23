import 'package:equatable/equatable.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/entities/volunteer.dart';

class VolunteersAttendState extends Equatable{
  final List<Volunteer> volunteers;
  final RequestState state;
  final RequestState sendState;
  final String message;

  const VolunteersAttendState({
    this.volunteers =const [],
    this.state = RequestState.loading,
    this.sendState = RequestState.wait,
    this.message = '',
  });

  VolunteersAttendState copyWith({
    List<Volunteer>? volunteers,
    RequestState? state,
    RequestState? sendState,
    String? message,
}){
    return VolunteersAttendState(
      volunteers: volunteers ?? this.volunteers,
      state: state ?? this.state,
      message: message ?? this.message,
      sendState: sendState ?? this.sendState,
    );
  }

  @override
  List<Object?> get props => [
    volunteers,
    state,
    message,
    sendState,
  ];

}