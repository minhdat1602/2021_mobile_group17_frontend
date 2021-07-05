import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomNavController extends GetxController {
  final ptController = PersistentTabController().obs;

  @override
  void onInit() {
    ptController.value.index = 0;
    super.onInit();
  }
}
