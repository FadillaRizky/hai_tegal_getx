import 'package:get/get.dart';

class IndexController extends GetxController {
  var isLoading = true.obs;
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

}