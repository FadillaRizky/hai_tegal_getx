import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_tegal_getx/controller/splash_controller.dart';
import 'package:hai_tegal_getx/services/api.dart';

import 'app_routes.dart';

void main() {
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBindings(),
      debugShowCheckedModeBanner: false,
      title: 'Hai Tegal Apps',
      initialRoute: AppRoutes.init,
      getPages: AppRoutes.routes,
      defaultTransition: Transition.fade,
    );
  }
}

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
    
    // Get.lazyPut(() => ApiClient(), fenix: true);
  }
}