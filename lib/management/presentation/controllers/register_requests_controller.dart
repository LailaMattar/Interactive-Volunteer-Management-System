import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/usecases/accept_register_request_usecase.dart';
import 'package:takatof/management/domain/usecases/get_register_requests_usecase.dart';
import 'package:takatof/management/presentation/controllers/register_requests_state.dart';
import 'package:takatof/management/presentation/screens/drawer/registerrequests/register_requests_screen.dart';

class RegisterRequestsController extends GetxController {
  final GetRegisterRequestsUseCase getRegisterRequestsUseCase;
  final AcceptRegisterRequestUseCase acceptRegisterRequestUseCase;
  final BuildContext context;
  Rx<RegisterRequestsState> state;

  RegisterRequestsController(
      {required this.getRegisterRequestsUseCase,
      required this.acceptRegisterRequestUseCase,
        required this.context,
      required this.state});

  getRegisterRequests(GetRegisterRequestsParameters parameters) async {
    print('apiiii');
    state.value = state.value.copyWith(state: RequestState.loading);
    final result = await getRegisterRequestsUseCase(parameters);

    result.fold(
        (l) => state.value = state.value.copyWith(
              message: l.message,
              state: RequestState.error,
            ), (r) {
      // Get.off(RegisterRequestsScreen());
      return state.value = state.value.copyWith(
        message: "success",
        state: RequestState.loaded,
        requests: r,
      );
    });
  }

  acceptRegisterRequest(AcceptRegisterRequestParameters parameters)async {
    state.value = state.value.copyWith(sendState: RequestState.loading);
    final result = await acceptRegisterRequestUseCase(parameters);

    result.fold(
            (l) => state.value = state.value.copyWith(
          message: l.message,
          sendState: RequestState.error,
        ), (r) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: r,
        confirmBtnColor: ColorResources.greenPrimary,
        onConfirmBtnTap: (){
          // controller.state =const RegisterRequestsState(sendState: RequestState.wait).obs;
          // controller.getRegisterRequests(GetRegisterRequestsParameters(eventId: 1));
          getRegisterRequests(GetRegisterRequestsParameters(eventId: 1));
          Navigator.of(context, rootNavigator: true).pop();

        },
        barrierDismissible: false,
        confirmBtnText: 'حسناً',
      );
      return state.value = state.value.copyWith(
        message: "success",
        sendState: RequestState.wait,
        sendResponse: r,
        state: RequestState.loading
      );
    });
  }
}
