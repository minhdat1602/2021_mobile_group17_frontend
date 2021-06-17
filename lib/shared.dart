import 'dart:convert';

import 'package:mobile_nhom17_2021/models/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("user");
}

Future<Cart> getCartFromSprefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Cart cart;
  try {
    cart = Cart.fromJson(json.decode(prefs.getString("cart")));
  } catch (e) {
    print(e);
  }
  if (cart == null) {
    cart = new Cart();
    cart.cartItems = [];
  }
  // print(cart.toString());
  return cart;
}
