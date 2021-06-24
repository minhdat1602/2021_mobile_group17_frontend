import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/models/cart.dart';
import 'package:mobile_nhom17_2021/app/models/cart_item.dart';
import 'package:mobile_nhom17_2021/app/models/inventory.dart';
import 'package:mobile_nhom17_2021/app/models/product.dart';
import 'package:mobile_nhom17_2021/app/services/shopping-cart_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingCartController extends GetxController {
  ShoppingCartAPI shoppingCartAPI = Get.put<ShoppingCartAPI>(ShoppingCartAPI());

  Rx<Cart> cart = Cart().obs;
  SharedPreferences sprefs;

  @override
  void onInit() {
    initCart();
    super.onInit();
  }

  void initCart() async {
    sprefs = await SharedPreferences.getInstance();
    var cartStr = sprefs.getString("cart");
    if (cartStr != null) {
      cart.value = Cart.fromJson(json.decode(cartStr));
    } else {
      Cart initCart = new Cart();
      initCart.cartItems = [];
      cart.value = initCart;
      sprefs.setString("cart", json.encode(cart.toJson()));
    }
  }

  void updateCart(Cart cart) async {
    sprefs = await SharedPreferences.getInstance();

    // Tạo cart mới , khác tham chiếu
    Cart newCart = new Cart();

    //copy danh sách item
    List<CartItem> cartItem = <CartItem>[];
    for (CartItem item in cart.cartItems) {
      cartItem.add(item);
    }
    // gán giá trị cho cart mới
    newCart.user = cart.user;
    newCart.cartItems = cartItem;

    // Hoàn tất update
    this.cart.value = newCart;
    sprefs.setString("cart", json.encode(this.cart.toJson()));
  }

  void saveProductToCart(Inventory inventory, Product product) async {
    Cart cart;
    //lấy cart từ Sprefs
    String cartJson = sprefs.get("cart");
    if (cartJson != null) cart = Cart.fromJson(json.decode(cartJson));
    inventory.product = product;
    List<CartItem> cartItems = cart.cartItems;

    //item mới
    CartItem cartItem;
    cartItem = new CartItem(inventory: inventory, quantity: 1);

    // if (cartItems == null) cartItems = [];
    bool contains = false;
    int size = cartItems.length;

    // Kiểm tra xem item đó có đã có trong danh sách item của cart chưa

    for (int i = 0; i < size; i++) {
      // nếu có thì tăng số lượng lên 1
      if (cartItems[i].inventory.id == cartItem.inventory.id) {
        contains = true;
        cartItems[i].quantity = cartItems[i].quantity + 1;
        break;
      }
    }
    // Nếu không thì thêm item mới vào danh sách item
    if (!contains) {
      cartItems.add(cartItem);
    }

    //save danh sách item mới cho cart
    cart.cartItems = cartItems;

    //save vào sprefs
    sprefs.setString("cart", json.encode(cart.toJson()));
    this.cart.value = cart;
  }

  void getCartByUserId(int userId) async {
    try {
      cart.value = await shoppingCartAPI.getByUserId(userId);
      if (cart.value != null)
        sprefs.setString("cart", json.encode(cart.value.toJson()));
    } catch (e) {
      print(e.message);
    }
  }
}
