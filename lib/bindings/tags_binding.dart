import 'package:get/get.dart';
import 'package:hai_tegal_getx/controller/tag_controller.dart';

class TagsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TagsController>(() => TagsController());
  }
}