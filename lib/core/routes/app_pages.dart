import 'package:get/get.dart';
import 'package:takatof/management/presentation/screens/authscreen/login_screen.dart';
import 'package:takatof/management/presentation/screens/homescreens/home_screen.dart';
import 'package:takatof/management/presentation/screens/splashscreen/splash_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static const home = Routes.home;
  static const splash = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: () {
        return const SplashScreen();
      },
    ),
    GetPage(
      name: _Paths.splash,
      page: () {
        return  HomeScreen();
      },
    ),
    GetPage(
      name: _Paths.login,
      page: () => LoginScreen(),
    ),
  ];
}
