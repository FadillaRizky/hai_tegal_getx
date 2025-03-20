import 'package:get/get.dart';
import 'package:hai_tegal_getx/controller/home_controller.dart';
import 'package:hai_tegal_getx/controller/index_controller.dart';
import 'package:hai_tegal_getx/controller/tag_controller.dart';

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IndexController>(() => IndexController());
    Get.lazyPut<TagsController>(() => TagsController());
  }
}