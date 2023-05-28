import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../../core/utils/enums.dart';

class LoginState extends Equatable{
  final String token;
  final RequestState loginState;
  final String loginMessage;


  const LoginState({
    this.token = '',
    required this.loginState,
    this.loginMessage = '',
  });

  @override
  List<Object?> get props => [
    token,
    loginState,
    loginMessage,
  ];
}