import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_nhom17_2021/models/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveCart(Cart cart) async {
  Uri url = Uri.parse("https://mobile2021group17.herokuapp.com/cart");

  String bodys = json.encode(cart.toJson());

  var response = await http.post(url,
      headers: {"Content-Type": "application/json; charset=utf-8"},
      body: bodys);
  // Cart cart;
  if (response.statusCode == 200) {
    try {
      SharedPreferences sprefs = await SharedPreferences.getInstance();
      // cart = Cart.fromJson(json.decode(response.body));
      sprefs.setString("cart", response.body);
    } catch (e) {
      print("Something get wrong!");
    }
  } else
    print("Something get wrong! Status code ${response.statusCode}");
}
