import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/search_module/search_controller.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchController>(() => SearchController());
  }
}
