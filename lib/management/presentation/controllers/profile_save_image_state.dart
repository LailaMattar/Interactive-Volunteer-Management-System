import 'package:equatable/equatable.dart';
import 'package:takatof/core/utils/enums.dart';

class ProfileSaveImageState extends Equatable {
  final String response;
  final RequestState state;
  final String message;

  const ProfileSaveImageState(
      {this.response = '', this.state = RequestState.wait, this.message = ''});

  ProfileSaveImageState copyWith({
    String? response,
    RequestState? state,
    String? message,
  }) {
    return ProfileSaveImageState(
      response: response ?? this.response,
      state: state ?? this.state,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        response,
        state,
        message,
      ];
}
