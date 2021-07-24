import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/data/models/status.dart';
import 'package:mobile_nhom17_2021/app/data/services/order_status_api.dart';

class AdminStatusController extends GetxController {
  StatusAPI statusAPI = Get.put(StatusAPI());
  var statuses = <Status>[].obs;

  @override
  void onInit() {
    initValue();
    super.onInit();
  }

  initValue() async {
    statuses.value = await statusAPI.fetchStatus().then((value) {
      value.insert(
          value.indexOf(value.first),
          new Status()
            ..id = 0
            ..name = "Tất cả đơn");
      return value;
    });
  }
}
