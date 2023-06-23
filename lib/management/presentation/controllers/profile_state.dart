import 'package:equatable/equatable.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/entities/profile.dart';

class ProfileState extends Equatable {
  Profile? profile;
  final RequestState state;
  final String message;

  ProfileState(
      {this.profile, this.state = RequestState.loading, this.message = ''});

  ProfileState copyWith({
    Profile? profile,
    RequestState? state,
    String? message,
  }) {
    return ProfileState(
      profile: profile,
      state: state ?? this.state,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        profile,
        state,
        message,
      ];
}
