import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/services/checkout_api.dart';

import '../checkout_controller.dart';

class CheckoutBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutController>(() => CheckoutController());
  }
}
