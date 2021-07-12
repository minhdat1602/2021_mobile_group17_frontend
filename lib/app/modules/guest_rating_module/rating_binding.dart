import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_rating_module/rating_controller.dart';

class RatingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RatingController>(() => RatingController());
  }
}
