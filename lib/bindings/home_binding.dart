import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:hai_tegal_getx/controller/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}