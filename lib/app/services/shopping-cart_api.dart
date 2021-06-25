import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_nhom17_2021/app/models/cart.dart';
import 'package:mobile_nhom17_2021/app/data/provider/contants.dart';

class ShoppingCartAPI {
  Future<Cart> save(Cart cart) async {
    String url = "https://mobile2021group17.herokuapp.com/cart";
    Uri uri = Uri.parse(url);
    String body = json.encode(cart.toJson());
    var response = await http.Client().put(
      uri,
      headers: headers,
      body: body,
      encoding: Encoding.getByName("utf-8"),
    );

    if (response.statusCode == 200) {
      try {
        return json.decode(utf8.decode(response.bodyBytes));
      } catch (e) {
        print("Có gì đó sai sai:${e.message}");
        return null;
      }
    } else {
      print("Có gì đó sai sai ${response.statusCode}");
      return null;
    }
  }

  Future<Cart> getByUserId(int userId) async {
    String url = "https://mobile2021group17.herokuapp.com/cart/$userId";
    Uri uri = Uri.parse(url);
    var response = await http.Client().get(uri, headers: headers);

    if (response.statusCode == 200) {
      try {
        return json.decode(utf8.decode(response.bodyBytes));
      } catch (e) {
        print("Có gì đó sai sai:${e.message}");
        return null;
      }
    } else {
      print("Có gì đó sai sai ${response.statusCode}");
      return null;
    }
  }
}
