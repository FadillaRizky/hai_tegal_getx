import 'package:get/get.dart';
import 'package:hai_tegal_getx/app_routes.dart';
import 'package:hai_tegal_getx/controller/tag_controller.dart';

class IndexController extends GetxController {
  var isLoading = true.obs;
  var selectedIndex = 0.obs;

  

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  void navigateBackAndChangeIndex(int index) {
    selectedIndex.value = index;
    Get.offAndToNamed(AppRoutes.home);
  }

  void navigateToTagScreen(Map<String, dynamic> tag) {
    // Get or create TagsController instance
    final TagsController tagsController = Get.find<TagsController>();

    // Set the selected tag
    tagsController.selectTag(tag);

    // Navigate to the tags screen
    Get.toNamed('/tags');
  }
}
