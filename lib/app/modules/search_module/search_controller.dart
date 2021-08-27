import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/data/models/product.dart';
import 'package:mobile_nhom17_2021/app/data/services/search_api.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_shop_module/shop_controller.dart';
import 'package:mobile_nhom17_2021/app/routes/app_pages.dart';

class SearchController extends GetxController {
  SearchAPI api = Get.put(SearchAPI());

  var keyword = ''.obs;

  ShopController shopController = Get.put(ShopController());

  Future<void> searchByKeyword() async {
    String key = keyword.value;
    if (key.length > 1) {
      Future<List<Product>> products = api.search(key);
      if (products != null) {
        shopController.products.value = products;
        products.then((value) => shopController.total.value = value.length);
        if (Get.previousRoute != Routes.SHOP)
          Get.offNamed(Routes.SHOP);
        else
          Get.back();
      }
    }
  }
}
