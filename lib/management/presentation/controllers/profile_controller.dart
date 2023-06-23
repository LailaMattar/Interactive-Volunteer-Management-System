import 'package:cool_alert/cool_alert.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/usecases/get_profile_usecase.dart';
import 'package:takatof/management/domain/usecases/upload_profile_image_usecase.dart';
import 'package:takatof/management/presentation/controllers/profile_save_image_state.dart';
import 'package:takatof/management/presentation/controllers/profile_state.dart';
import 'package:takatof/management/presentation/screens/homescreens/bottom_nav_bar.dart';

class ProfileController extends GetxController implements Equatable {
  final GetProfileUseCase getProfileUseCase;
  final UploadProfileImageUseCase uploadProfileImageUseCase;
  Rx<ProfileState> state;
  Rx<ProfileSaveImageState> sendState;
  final BuildContext context;

  ProfileController(
      {required this.getProfileUseCase,
      required this.uploadProfileImageUseCase,
      required this.state,
      required this.sendState,
      required this.context,});

  getProfile(GetProfileParameters parameters) async {
    state.value = state.value.copyWith(state: RequestState.loading);
    final result = await getProfileUseCase(parameters);

    result.fold(
        (l) => state.value = state.value.copyWith(
              message: l.message,
              state: RequestState.error,
            ), (r) {
      return state.value = state.value
          .copyWith(message: "success", state: RequestState.loaded, profile: r);
    });
  }

  saveProfileImage(UploadProfileImageParameters parameters) async {
    sendState.value = sendState.value.copyWith(state: RequestState.loading);
    final result = await uploadProfileImageUseCase(parameters);

    result.fold(
        (l) => sendState.value = sendState.value.copyWith(
              message: l.message,
              state: RequestState.error,
            ), (r) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: r,
        confirmBtnColor: ColorResources.greenPrimary,
        onConfirmBtnTap: (){
          Navigator.of(context, rootNavigator: true).pop();
          Get.offAll(()=> BottomNavBar());
        },
        barrierDismissible: false,
        confirmBtnText: 'حسناً',
      );
      return sendState.value = sendState.value
          .copyWith(message: "success", state: RequestState.loaded, response: r);
    });
  }

  @override
  List<Object?> get props => [getProfileUseCase, state];

  @override
  bool? get stringify => throw UnimplementedError();
}
