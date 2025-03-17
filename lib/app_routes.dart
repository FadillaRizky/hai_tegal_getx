import 'package:get/get.dart';
import 'package:hai_tegal_getx/bindings/home_binding.dart';
import 'package:hai_tegal_getx/bindings/index_binding.dart';
import 'package:hai_tegal_getx/screen/index.dart';

import 'screen/menu/splash_screen.dart';

class AppRoutes {
  static const String init = '/';
  static const String index = '/index';
  static const String home = '/index';
  static const String notification = '/index';
  static const String saved = '/index';
  static const String account = '/settings';

  // GetPage list for GetMaterialApp
  static final routes = [
    GetPage(name: init, page: () => SplashScreen(), transition: Transition.fadeIn),
    GetPage(
      name: index,
      page: () => Index(),
      transition: Transition.rightToLeft,
      bindings: [IndexBinding(), HomeBinding()],
    ),
    // GetPage(
    //   name: settings,
    //   page: () => SettingsScreen(),
    //   binding: SettingsBinding(), // Optional: Bind controllers
    // ),
  ];
}
