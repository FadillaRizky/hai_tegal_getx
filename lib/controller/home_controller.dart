import 'package:get/get.dart';
import 'package:hai_tegal_getx/controller/tag_controller.dart';

class HomeController extends GetxController {
  // Mock data for featured tags on home screen
  final featuredTags =
      [
        {'tags_id': '1', 'tags_name': 'Beach'},
        {'tags_id': '2', 'tags_name': 'Mountain'},
        {'tags_id': '3', 'tags_name': 'Culinary'},
        {'tags_id': '4', 'tags_name': 'Culture'},
        {'tags_id': '5', 'tags_name': 'Historical'},
        {'tags_id': '6', 'tags_name': 'Nature'},
        {'tags_id': '7', 'tags_name': 'Adventure'},
        {'tags_id': '8', 'tags_name': 'Family'},
      ].obs;

  // Navigate to tag screen with the selected tag
  void navigateToTagScreen(Map<String, dynamic> tag) {
    // Get or create TagsController instance
    final TagsController tagsController = Get.find<TagsController>();

    // Set the selected tag
    tagsController.selectTag(tag);

    // Navigate to the tags screen
    Get.toNamed('/tags');
  }
}
