import 'package:equatable/equatable.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/entities/register_request.dart';
import 'package:takatof/management/domain/entities/volunteer.dart';

class RegisterRequestsState extends Equatable {
  final List<RegisterRequest> requests;
  final String sendResponse;
  final RequestState state;
  final RequestState sendState;
  final String message;

  const RegisterRequestsState(
      {this.requests = const [],
      this.sendResponse = '',
      this.state = RequestState.loading,
      this.sendState = RequestState.wait,
      this.message = ''});

  RegisterRequestsState copyWith({
    List<RegisterRequest>? requests,
    String? sendResponse,
    RequestState? state,
    RequestState? sendState,
    String? message,
  }) {
    return RegisterRequestsState(
      requests: requests ?? this.requests,
      sendResponse: sendResponse ?? this.sendResponse,
      sendState: sendState ?? this.sendState,
      state: state ?? this.state,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props =>
      [requests, sendResponse, state, sendState, message];
}
