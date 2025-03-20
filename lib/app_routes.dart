import 'package:get/get.dart';
import 'package:hai_tegal_getx/bindings/detail_binding.dart';
import 'package:hai_tegal_getx/bindings/home_binding.dart';
import 'package:hai_tegal_getx/bindings/index_binding.dart';
import 'package:hai_tegal_getx/bindings/tags_binding.dart';
import 'package:hai_tegal_getx/screen/home/detail_post_screen.dart';
import 'package:hai_tegal_getx/screen/home/tags_screen.dart';
import 'package:hai_tegal_getx/screen/index.dart';

import 'screen/menu/splash_screen.dart';

class AppRoutes {
  static const String init = '/';
  static const String index = '/index';
  static const String home = '/index';
  static const String notification = '/index';
  static const String saved = '/index';
  static const String account = '/settings';

  static const String DETAIL_POST = '/detail-post';
  static const String TAGS = '/tags';

  // GetPage list for GetMaterialApp
  static final routes = [
    GetPage(name: init, page: () => SplashScreen(), transition: Transition.fadeIn),
    GetPage(
      name: index,
      page: () => Index(),
      transition: Transition.rightToLeft,
      bindings: [IndexBinding(), HomeBinding()],
    ),
    GetPage(
      name: DETAIL_POST,
      page: () => DetailPostScreen(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: TAGS,
      page: () => TagsScreen(),
      binding: TagsBinding(), // Optional: Bind controllers
    ),
  ];
}

