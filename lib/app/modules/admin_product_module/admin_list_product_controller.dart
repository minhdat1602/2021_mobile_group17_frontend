import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/data/models/product.dart';
import 'package:mobile_nhom17_2021/app/data/services/product_api.dart';
import 'package:mobile_nhom17_2021/app/data/services/shop_api.dart';

class AdminListProductController extends GetxController {
  final ProductAPI productAPI;
  AdminListProductController(this.productAPI);

  var _products = Future.value(<Product>[]).obs;
  get products => this._products.value;
  set products(value) => this._products.value = value;

  @override
  void onInit() async {
    super.onInit();
    _products.value = productAPI.fetchAll();
  }

  void input() {}
  void detail() {}

  void delete() {}
}
