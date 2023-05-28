part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const home = _Paths.home;
  static const login = _Paths.login;
  static const splash = _Paths.splash;
}

abstract class _Paths {
  _Paths._();
  static const home = '/home';
  static const login = '/login';
  static const splash = '/splash';
}
