import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/images/app_images.dart';
import 'package:takatof/management/presentation/screens/authscreen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Get.updateLocale(const Locale('ar'));
    Timer(const Duration(seconds: 2),
            ()=>Get.off(()=>LoginScreen())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.white,
      body: Stack(
        children: [
          Container(
            decoration:const BoxDecoration(
                image: DecorationImage(image: AssetImage(AppImages.backGround,),fit: BoxFit.cover,)
            ),
          ),
          Center(
            child: PlayAnimationBuilder<double>(
              tween: Tween(begin: 50.0, end: 210.0),
              duration: const Duration(seconds: 1),
              builder: (context, value, _) {
                return Container(
                  width: value,
                  height: value,
                  child: Image.asset(AppImages.logo),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
