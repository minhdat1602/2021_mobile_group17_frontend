import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/models/inventory.dart';
import 'package:mobile_nhom17_2021/app/models/product.dart';
import 'package:mobile_nhom17_2021/app/models/user.dart';
import 'package:mobile_nhom17_2021/app/data/provider/shop_api.dart';
import 'package:mobile_nhom17_2021/app/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopController extends GetxController {
  ShopAPI shopAPI = Get.put<ShopAPI>(ShopAPI());

  var products = Future.value(<Product>[]).obs;
  var product = Product().obs;
  var recentlyViews = <Product>[].obs;
  var total = 0.obs;

  var orginList;

  @override
  void onInit() {
    super.onInit();
    recentlyViews.value = [];
  }

  void fetchProductAll() {
    products.value = shopAPI.fetchProductAll();
    products.value.then((value) {
      total.value = value.length;
      orginList = value;
    });
  }

  void fetchProducts(String type, int id) {
    String host =
        "https://mobile2021group17.herokuapp.com/product/$type${id == null ? '' : '/$id'}";
    print(host);
    products.value = shopAPI.fetchProducts(host);
    products.value.then((value) {
      total.value = value.length;
      orginList = value;
    });
  }

  void filter(String category, String price) async {
    var results = <Product>[];
    // var a = await products.value;
    var list = orginList;
    if (category != null) {
      for (Product product in list) {
        if (product.category.name == category) {
          results.add(product);
        }
      }
    } else {
      results = list;
    }
    int priceInt = -1;
    if (price == null) {
    } else if (price == "0 - 1,000,000 đ") {
      priceInt = 0;
    } else if (price == "1,000,000 - 2,000,000 đ") {
      priceInt = 1;
    } else if (price == "2,000,000 - 3,000,000 đ") {
      priceInt = 2;
    } else {
      priceInt = 3;
    }
    var result2 = <Product>[];
    if (price != null) {
      for (Product product in results) {
        print(product.price);
        print(priceInt * 1000000);
        print((priceInt + 1) * 1000000);
        if (priceInt == 3) {
          if (product.price >= priceInt * 1000000) {
            result2.add(product);
          }
        } else {
          if (product.price >= priceInt * 1000000 &&
              product.price <= (priceInt + 1) * 1000000) {
            result2.add(product);
          }
        }
      }
    } else {
      result2 = results;
    }

    print(result2.length);
    products.value = Future.value(result2);
    total.value = result2.length;
  }

  void addRecentlyViewed(Product product) {
    recentlyViews.add(product);
    if (recentlyViews.length > 6) recentlyViews.removeAt(0);
  }
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool isStored = false;
  //   String productJson = json.encode(product.toJson());
  //   print(productJson);
  //   List<String> recentlyVieweds = prefs.getStringList("recentlyViewed");
  //   if (recentlyVieweds == null) {
  //     recentlyVieweds = [];
  //     recentlyVieweds.add(productJson);
  //   } else if (recentlyVieweds.length >= 6) {
  //     recentlyVieweds.removeAt(0);
  //   } else {
  //     for (int i = 0; i < recentlyVieweds.length; i++) {
  //       if (recentlyVieweds[i] == productJson) {
  //         isStored = true;
  //       }
  //     }
  //     if (!isStored) {
  //       recentlyVieweds.add(productJson);
  //     }
  //   }
  //   prefs.setStringList("recentlyViewed", recentlyVieweds);
  // }
}
