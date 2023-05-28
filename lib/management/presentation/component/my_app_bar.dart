import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/images/app_images.dart';

class MyAppBar{
  static AppBar mine(){
    return AppBar(
      iconTheme:const IconThemeData(color: ColorResources.black),
      toolbarHeight: 70,
      backgroundColor: ColorResources.white,
      actions:[
        Expanded(
          // width: double.infinity,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 50.0),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: SizedBox(
                child: SvgPicture.asset(
                  AppImages.message,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            width: 75,
            height: 75,
            child: Image.asset(AppImages.logo),
          ),
        ),
      ],
    );
  }

  static AppBar titledAppBar({required String title}){
    return AppBar(
      title: Text(
        title,
        style:const TextStyle(
          color: ColorResources.black,
        ),
      ),
      leading:  IconButton(
        icon:const Icon(Icons.arrow_back, color: ColorResources.black),
        onPressed: (){Get.back();},
      ),
      centerTitle: true,
      backgroundColor: ColorResources.white,
    );
  }
}
