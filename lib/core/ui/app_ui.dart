import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/images/app_images.dart';
import 'package:takatof/core/strings/app_strings.dart';
import 'package:takatof/management/presentation/screens/drawer/myevents/my_events_screen.dart';
import 'package:takatof/management/presentation/screens/drawer/tasks/tasks_list_screen.dart';

class AppUi{
  static const spinkitMain = SpinKitSpinningLines(
    color: ColorResources.redPrimary,
    size: 50.0,
  );

  static Future<bool?> showToast({required String message}){
    return Fluttertoast.showToast(
        msg:message,
        toastLength:
        Toast.LENGTH_SHORT,
        gravity:
        ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorResources.greenPrimary,
        textColor: ColorResources.white,
        fontSize: 16.0);
  }

  static Widget loading(){
    return const SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: spinkitMain,
      ),
    );
  }

  static BoxDecoration containerBoxDecoration(){
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: ColorResources.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 8,
          offset:const Offset(0, 0), // changes position of shadow
        ),
      ],
    );
  }

  static Drawer drawer(){
    return Drawer(
      width: (2*Get.width)/3,
      backgroundColor: ColorResources.black,
      child: Column(
        children: [
          Container(
              height: 250,
              width: double.infinity,
              decoration:const BoxDecoration(
                color: ColorResources.white,
              ),
              child: Center(
                child: Image.asset(AppImages.logo,height: 125,width: 125,),
              )
          ),
          ListTile(
            leading: const Icon(
              Icons.checklist,
              size: 30,
              color: ColorResources.white,
            ),
            title: const Text(
              AppStrings.tasksList,
              style: TextStyle(
                  color: ColorResources.white,
                  fontSize: 18
              ),
            ),
            onTap: () {
              Get.to(()=> TasksListScreen());
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.event_available_outlined,
              size: 30,
              color: ColorResources.white,
            ),
            title: const Text(
              AppStrings.myEvents,
              style: TextStyle(
                  color: ColorResources.white,
                  fontSize: 18
              ),
            ),
            onTap: () {
              Get.to(()=> MyEventsScreen());
            },
          ),
        ],
      ),
    );
  }
}