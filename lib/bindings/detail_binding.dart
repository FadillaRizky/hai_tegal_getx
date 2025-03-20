
import 'package:get/get.dart';
import 'package:hai_tegal_getx/controller/detail_post_controller.dart';
import 'package:hai_tegal_getx/controller/index_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IndexController>(() => IndexController());
    Get.lazyPut<DetailPostController>(() => DetailPostController());
  }
}