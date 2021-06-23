import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/data/models/brand.dart';
import 'package:mobile_nhom17_2021/app/data/models/category.dart';
import 'package:mobile_nhom17_2021/app/services/menu_api.dart';

class MenuController extends GetxController {
  MenuAPI menuAPI = Get.put<MenuAPI>(MenuAPI());

  var categories = Future.value(<Category>[]).obs;
  var brands = Future.value(<Brand>[]).obs;

  @override
  void onInit() {
    super.onInit();
    brands.value = menuAPI.fetchBrandAll();
    categories.value = menuAPI.fetchCategoryAll();
  }
}
