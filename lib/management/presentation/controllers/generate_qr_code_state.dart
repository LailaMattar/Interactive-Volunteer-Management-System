import 'package:equatable/equatable.dart';
import 'package:takatof/core/utils/enums.dart';

class GenerateQRCoedState extends Equatable {
  final String response;
  final RequestState state;
  final String message;

  const GenerateQRCoedState(
      {this.response = '',
      this.state = RequestState.loading,
      this.message = ''});

  GenerateQRCoedState copyWith({
    String? response,
    RequestState? state,
    String? message,
  }) {
    return GenerateQRCoedState(
        response: response ?? this.response,
        state: state ?? this.state,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [
        response,
        state,
        message,
      ];
}
