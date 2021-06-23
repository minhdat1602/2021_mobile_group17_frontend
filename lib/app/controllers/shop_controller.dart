import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/data/models/cart.dart';
import 'package:mobile_nhom17_2021/app/data/models/cart_item.dart';
import 'package:mobile_nhom17_2021/app/data/models/inventory.dart';
import 'package:mobile_nhom17_2021/app/data/models/product.dart';
import 'package:mobile_nhom17_2021/app/data/models/user.dart';
import 'package:mobile_nhom17_2021/app/data/provider/shop_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopController extends GetxController {
  ShopAPI shopAPI = Get.put<ShopAPI>(ShopAPI());

  var products = Future.value(<Product>[]).obs;
  var product = Product().obs;
  var recentlyViews = <Product>[].obs;
  var total = 0.obs;
  var cart = Cart().obs;

  var orginList;

  @override
  void onInit() {
    super.onInit();
    recentlyViews.value = [];
    initCart();
  }

  void initCart() async {
    SharedPreferences sprefs = await SharedPreferences.getInstance();
    var cartStr = sprefs.getString("cart");
    if (cartStr != null) {
      cart.value = Cart.fromJson(json.decode(cartStr));
    } else {
      cart.value = new Cart();
      cart.value.cartItems = [];

      var userStr = sprefs.getString("user");
      if (userStr != null) {
        User user = User.fromJson(json.decode(userStr));
        cart.value.user = user;
      }
    }
  }

  Future saveProductToCart(Inventory inventory, Product product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Cart cart;
    CartItem cartItem;
    String cartJson = prefs.get("cart");
    if (cartJson != null) cart = Cart.fromJson(json.decode(cartJson));
    inventory.product = product;
    if (cart == null) {
      cart = new Cart();
      cartItem = new CartItem(inventory: inventory, quantity: 1);
      List<CartItem> cartItems = [];
      cartItems.add(cartItem);
      cart.cartItems = cartItems;
      try {
        prefs.setString("cart", json.encode(cart.toJson()));
      } catch (e) {
        print("ERROR$e");
      }

      print(cartItems.length);
    } else {
      cartItem = new CartItem(inventory: inventory, quantity: 1);

      List<CartItem> cartItems = cart.cartItems;
      if (cartItems == null) cartItems = [];
      bool contains = false;
      int size = cartItems.length;
      for (int i = 0; i < size; i++) {
        if (cartItems[i].inventory.id == cartItem.inventory.id) {
          contains = true;
          cartItems[i].quantity = cartItems[i].quantity + 1;
        }
        if (!contains) {
          cartItems.add(cartItem);
          contains = true;
        }
        cart.cartItems = cartItems;
        if (prefs.getString("user") != null) {
          User user = User.fromJson(json.decode(prefs.getString("user")));
          cart.user = user;
        }
      }
    }
    prefs.setString("cart", json.encode(cart.toJson()));
    this.cart.value = cart;
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
