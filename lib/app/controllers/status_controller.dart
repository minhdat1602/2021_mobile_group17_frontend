import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/models/status.dart';
import 'package:mobile_nhom17_2021/app/services/order_status_api.dart';

class StatusController extends GetxController {
  StatusAPI statusAPI = Get.put<StatusAPI>(StatusAPI());

  var status = Future.value(<Status>[]).obs;

  @override
  void onInit() {
    fetchStatus();
    super.onInit();
  }

  // Lấy danh sách tất cả trang thái của đơn hàng,
  void fetchStatus() async {
    status.value = statusAPI.fetchStatus();
    status.value
        .then((value) => value.insert(0, Status(id: 0, name: "Tất cả đơn")));
  }
}
