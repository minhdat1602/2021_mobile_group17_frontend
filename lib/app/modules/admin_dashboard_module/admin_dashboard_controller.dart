import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/data/models/order_statistics.dart';
import 'package:mobile_nhom17_2021/app/data/services/order_api.dart';

class DashBoardController extends GetxController {
  OrderAPI orderAPI = Get.put(OrderAPI());
  var _orderStatistic = Future.value(OrderStatistics()).obs;
  get orderStatistic => this._orderStatistic.value;

  @override
  void onInit() {
    _orderStatistic.value = orderAPI.fetchOrderStatistics();
    super.onInit();
  }
}
