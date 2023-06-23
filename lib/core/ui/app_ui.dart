import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/images/app_images.dart';
import 'package:takatof/core/strings/app_strings.dart';
import 'package:takatof/core/utils/app_constance.dart';
import 'package:takatof/management/presentation/screens/drawer/registerrequests/register_requests_screen.dart';
import 'package:takatof/management/presentation/screens/drawer/badges/badges_screen.dart';
import 'package:takatof/management/presentation/screens/drawer/calander/calander_screen.dart';
import 'package:takatof/management/presentation/screens/drawer/myevents/admin_events_screen.dart';
import 'package:takatof/management/presentation/screens/drawer/myevents/my_events_screen.dart';
import 'package:takatof/management/presentation/screens/drawer/tasks/tasks_list_screen.dart';
import 'package:takatof/management/presentation/screens/drawer/virtualstore/vitual_store_screen.dart';
import 'package:takatof/management/presentation/screens/drawer/qrscanner/qr_code_scanner_screen.dart';

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
              height: Get.height/3,
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
          Visibility(
            visible: AppConstance.role == 'admin',
            child: ListTile(
              leading: const Icon(
                Icons.event_available_outlined,
                size: 30,
                color: ColorResources.white,
              ),
              title: const Text(
                'فعاليات المشرف',
                style: TextStyle(
                    color: ColorResources.white,
                    fontSize: 18
                ),
              ),
              onTap: () {
                Get.to(()=> AdminEventsScreen());
              },
            ),
          ),
          Visibility(
            visible: AppConstance.role == 'admin',
            child: ListTile(
              leading: const Icon(
                Icons.app_registration,
                size: 30,
                color: ColorResources.white,
              ),
              title: const Text(
                'طلبات الانضمام',
                style: TextStyle(
                    color: ColorResources.white,
                    fontSize: 18
                ),
              ),
              onTap: () {
                Get.to(()=> RegisterRequestsScreen());
              },
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.badge,
              size: 30,
              color: ColorResources.white,
            ),
            title: const Text(
              'الشارات',
              style: TextStyle(
                  color: ColorResources.white,
                  fontSize: 18
              ),
            ),
            onTap: () {
              Get.to(()=>const BadgesScreen());
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.store,
              size: 30,
              color: ColorResources.white,
            ),
            title: const Text(
              'المتجر الافتراضي',
              style: TextStyle(
                  color: ColorResources.white,
                  fontSize: 18
              ),
            ),
            onTap: () {
              Get.to(()=>const VirtualStoreScreen());
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.qr_code_scanner,
              size: 30,
              color: ColorResources.white,
            ),
            title: const Text(
              'تسجيل الحضور',
              style: TextStyle(
                  color: ColorResources.white,
                  fontSize: 18
              ),
            ),
            onTap: () {
              Get.to(()=>const QRViewExample());
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.calendar_today,
              size: 30,
              color: ColorResources.white,
            ),
            title: const Text(
              'روزناما',
              style: TextStyle(
                  color: ColorResources.white,
                  fontSize: 18
              ),
            ),
            onTap: () {
              Get.to(()=> CalendarScreen());
            },
          ),
        ],
      ),
    );
  }
}