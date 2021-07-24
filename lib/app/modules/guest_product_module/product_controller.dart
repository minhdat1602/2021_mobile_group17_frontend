import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/data/models/product.dart';

class ProductController extends GetxController {
  Rx<Product> _product = Product().obs;
  get product => this._product.value;
  set product(value) => this._product.value = value;

  ScrollController scrollController;
  RxList<Product> recentlyViews = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    scrollController = new ScrollController(
      initialScrollOffset: 0,
      keepScrollOffset: true,
    );
  }

  void addRecentlyViewed(Product product) {
    if (!isContain(recentlyViews, product)) {
      recentlyViews.add(product);
      if (recentlyViews.length > 7) recentlyViews.removeAt(0);
    }
  }

  bool isContain(List<Product> list, Product product) {
    bool result = false;
    for (Product item in list) {
      if (item.id == product.id) result = true;
    }
    return result;
  }
}
