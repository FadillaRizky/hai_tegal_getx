import 'package:get/get.dart';

import 'view/splash_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String settings = '/settings';

  // GetPage list for GetMaterialApp
  static final routes = [
    GetPage(
      name: home,
      page: () => SplashScreen(),
      transition: Transition.fadeIn,
    ),
    // GetPage(
    //   name: login,
    //   page: () => LoginScreen(),
    //   transition: Transition.rightToLeft,
    // ),
    // GetPage(
    //   name: settings,
    //   page: () => SettingsScreen(),
    //   binding: SettingsBinding(), // Optional: Bind controllers
    // ),
  ];
}