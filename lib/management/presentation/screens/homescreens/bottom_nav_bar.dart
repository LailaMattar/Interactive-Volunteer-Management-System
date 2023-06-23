import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/images/app_images.dart';
import 'package:takatof/core/ui/app_ui.dart';
import 'package:takatof/core/utils/app_constance.dart';
import 'package:takatof/management/presentation/component/my_app_bar.dart';
import 'package:takatof/management/presentation/screens/homescreens/new_task_list_screen.dart';
import 'package:takatof/management/presentation/screens/homescreens/posts_screen.dart';
import 'package:takatof/management/presentation/screens/homescreens/profile_screen.dart';

import 'ads_screen.dart';
import 'home_screen.dart';
class BottomNavBar extends StatefulWidget {
  @override
  State createState() {
    return _BottomNavBarState();
  }
}

class _BottomNavBarState extends State {
  Widget? _child;
  RxInt selectedScreen = 2.obs;
  String title = 'الواجهة الرئيسية';

  @override
  void initState() {
    _child = HomeScreen();
    super.initState();
  }

  @override
  Widget build(context) {
    return Scaffold(
        backgroundColor: Color(0xFF75B7E1),
        extendBody: true,
        drawer: AppUi.drawer(),
        appBar: MyAppBar.mine(title: title),
        body: _child,
        bottomNavigationBar: Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset:const Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: FluidNavBar(
              icons: [
                FluidNavBarIcon(
                    icon: Icons.person,
                    selectedForegroundColor: Colors.white,
                    unselectedForegroundColor: ColorResources.grey,
                    backgroundColor: selectedScreen.value == 0 ?ColorResources.redPrimary:Colors.white,
                    extras: {"label": "home"}),
                FluidNavBarIcon(
                  // icon: Icons.home,
                  //   svgPath: AppImages.,
                  icon:Icons.event_available_outlined,
                    selectedForegroundColor: Colors.white,
                    unselectedForegroundColor: ColorResources.grey,
                    backgroundColor: selectedScreen.value == 1 ?ColorResources.redPrimary:Colors.white,
                    extras: {"label": "tasks"}),
                FluidNavBarIcon(
                  // icon: Icons.home,
                    svgPath: AppImages.home,
                    selectedForegroundColor: Colors.white,
                    unselectedForegroundColor: ColorResources.grey,
                    backgroundColor: selectedScreen.value == 2 ?ColorResources.redPrimary:Colors.white,
                    extras: {"label": "home"}),
                FluidNavBarIcon(
                  // icon: Icons.shutter_speed_sharp,
                    svgPath: AppImages.ads,
                    selectedForegroundColor: Colors.white,
                    unselectedForegroundColor: ColorResources.grey,
                    backgroundColor: selectedScreen.value == 3 ?ColorResources.redPrimary:Colors.white,
                    extras: {"label": "ads"}),
                FluidNavBarIcon(
                  // icon: Icons.note,
                    svgPath: AppImages.posts,
                    selectedForegroundColor: Colors.white,
                    unselectedForegroundColor: ColorResources.grey,
                    backgroundColor: selectedScreen.value == 4 ?ColorResources.redPrimary:Colors.white,
                    extras: {"label": "home"}),
              ],
              onChange: _handleNavigationChange,
              style:const FluidNavBarStyle(iconUnselectedForegroundColor: Colors.white),
              scaleFactor: 1.5,
              defaultIndex: selectedScreen.value,
              itemBuilder: (icon, item) => Semantics(
                label: icon.extras!["label"],
                child: item,
              ),
            ),
          ),
        ),
      );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      selectedScreen.value = index;
      switch (index) {
        case 0:
          title = 'الملف الشخصي';
          _child = ProfileScreen(id: AppConstance.id,);
          break;
        case 1:
          title = 'المهام الجديدة';
          _child = NewTaskListScreen();
          break;
        case 2:
          title = 'الواجهة الرئيسية';
          _child = HomeScreen();
          break;
        case 3:
          title = 'الإعلانات';
          _child =const AdsScreen();
          break;
        case 4:
          title = 'المنشورات';
          _child =const PostsScreen();
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration:const Duration(milliseconds: 300),
        child: _child,
      );
    });
  }
}