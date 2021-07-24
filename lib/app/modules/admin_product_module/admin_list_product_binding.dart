import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/data/services/product_api.dart';

import 'admin_list_product_controller.dart';

class AdminListProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminListProductController>(
        () => AdminListProductController(ProductAPI()));
  }
}
