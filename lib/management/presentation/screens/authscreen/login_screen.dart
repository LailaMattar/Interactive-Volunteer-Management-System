import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/error/app_error_widget.dart';
import 'package:takatof/core/images/app_images.dart';
import 'package:takatof/core/strings/app_strings.dart';
import 'package:takatof/core/ui/app_ui.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/data/datasource/management_remote_datasource.dart';
import 'package:takatof/management/data/repositories/management_repository.dart';
import 'package:takatof/management/domain/repositories/base_management_repository.dart';
import 'package:takatof/management/domain/usecases/login_usecase.dart';
import 'package:takatof/management/presentation/controllers/login_controller.dart';
import 'package:takatof/management/presentation/controllers/login_state.dart';
import 'package:takatof/management/presentation/screens/homescreens/bottom_nav_bar.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  late LoginController controller;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    BaseManagementDataSource baseManagementDataSource = ManagementDataSource();
    BaseManagementRepository baseManagementRepository = ManagementRepository(baseManagementDataSource);
    LoginUseCase loginUseCase = LoginUseCase(baseManagementRepository);
    controller = Get.put(
        LoginController(
            loginUseCase: loginUseCase,
            loginState:const LoginState(
                loginState: RequestState.wait
            ).obs
        )
    );

    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: ColorResources.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40,),
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset(AppImages.logo),
                ),
                const SizedBox(height: 100,),
                const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      AppStrings.login,
                      style: TextStyle(
                        fontSize: 20,
                        color: ColorResources.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextFormField(
                    controller: controller.email,
                    decoration:const InputDecoration(
                      hintText: AppStrings.email,
                      enabledBorder:OutlineInputBorder(
                        borderSide:  BorderSide(color: ColorResources.grey),
                        borderRadius : BorderRadius.all(Radius.circular(10)),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorResources.grey),
                        borderRadius : BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorResources.grey),
                        borderRadius : BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'ادخل البريد الالكتروني';
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextFormField(
                    controller: controller.password,
                    decoration:const InputDecoration(
                      hintText: AppStrings.password,
                      enabledBorder:OutlineInputBorder(
                        borderSide:  BorderSide(color: ColorResources.grey),
                        borderRadius : BorderRadius.all(Radius.circular(10)),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorResources.grey),
                        borderRadius : BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorResources.grey),
                        borderRadius : BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'ادخل كلمة المرور';
                      }
                    },
                  ),
                ),
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: InkWell(
                    onTap: (){
                      if (formKey.currentState!.validate()){
                        controller.login();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorResources.black,
                      ),
                      child:const Padding(
                        padding:  EdgeInsets.symmetric(vertical: 8),
                        child: Center(
                          child:  Text(
                            AppStrings.login,
                            style: TextStyle(
                              color: ColorResources.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                const Text(
                  AppStrings.didYouForgetYourPassword,
                  style: TextStyle(
                    color: ColorResources.greenPrimary,
                    decoration: TextDecoration.underline,
                  ),
                ),
                Obx(
                      (){
                        print('stateee : ${controller.loginState.value.loginState}');
                        switch(controller.loginState.value.loginState){
                          case RequestState.loading:
                            return const Center(child: AppUi.spinkitMain);
                            case RequestState.loaded:
                              WidgetsBinding.instance.addPostFrameCallback((_){
                                Get.off(()=> BottomNavBar());
                              });
                              return Container();
                            case RequestState.error:
                              print('error screen');
                              return AppErrorWidget.error(message: controller.loginState.value.loginMessage);
                            case RequestState.wait:
                              return Container();
                        }},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
