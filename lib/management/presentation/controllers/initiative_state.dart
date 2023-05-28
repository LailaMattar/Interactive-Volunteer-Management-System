import 'package:equatable/equatable.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/entities/Initiative.dart';

class InitiativeState extends Equatable {
  final Initiative initiative;
  final RequestState initiativeState;
  final String initiativeMessage;

  const InitiativeState(
      {this.initiative = const Initiative.empty(),
      this.initiativeState = RequestState.loading,
      this.initiativeMessage = ''});

  InitiativeState copyWith({
    Initiative? initiative,
    RequestState? initiativeState,
    String? initiativeMessage,
  }) =>
      InitiativeState(
        initiative: initiative ?? this.initiative,
        initiativeState: initiativeState ?? this.initiativeState,
        initiativeMessage: initiativeMessage ?? this.initiativeMessage,
      );

  @override
  List<Object?> get props => [
        initiative,
        initiativeState,
        initiativeMessage,
      ];
}
