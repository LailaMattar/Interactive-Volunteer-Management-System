import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatof/core/network/api_constance.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/entities/volunteer.dart';
import 'package:takatof/management/domain/usecases/login_usecase.dart';
import 'package:takatof/management/presentation/controllers/login_state.dart';

class LoginController extends GetxController implements Equatable{

  final LoginUseCase loginUseCase;
  Rx<LoginState> loginState;
  late Volunteer volunteer;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  LoginController({
    required this.loginUseCase,
    required this.loginState,
  });

  void login()async{
    loginState.value=const LoginState(
        loginState: RequestState.loading,
    );
    volunteer = Volunteer(email: email.text, password: password.text);
    try {
      final result = await loginUseCase(volunteer);

      result.fold(
            (l) {
              loginState.value = LoginState(
                  loginState: RequestState.error,
                  loginMessage: l.message
              );
              return loginState;
            },
            (r) {
              ApiConstance.token = 'Bearer $r';
              return loginState.value = LoginState(
                loginMessage: "success",
                loginState: RequestState.loaded,
                token: r,
              );
            },
      );
    }catch(e){
      print('error controller $e');
    }
  }

  @override
  void onInit() {
    email.text = 'laila@managentvolunteer.com';
    password.text = 'laila2001';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    loginUseCase,
    loginState,
    volunteer,
    email,
    password
  ];

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();

}