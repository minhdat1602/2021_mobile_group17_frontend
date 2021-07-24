import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_product_module/product_controller.dart';

class ProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(() => ProductController());
  }
}
