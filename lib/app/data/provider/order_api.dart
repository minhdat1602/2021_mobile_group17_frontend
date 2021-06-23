import 'dart:convert';

import 'package:mobile_nhom17_2021/app/data/models/order.dart';
import 'package:mobile_nhom17_2021/app/data/provider/contants.dart';
import 'package:http/http.dart' as http;

class OrderAPI {
  Future<List<Order>> fetchOrders() async {
    String urlStr = "$host\/order\/all";
    Uri url = Uri.parse(urlStr);
    List<Order> orders;
    var response;
    try {
      response = await http.Client().get(url, headers: headers);
    } catch (e) {
      print(e);
    }
    if (response.statusCode == 200) {
      try {
        Iterable data = json.decode(utf8.decode(response.bodyBytes));
        orders = data.map((orderStr) => Order.fromJson(orderStr)).toList();
      } catch (e) {
        print(e);
      }
    } else {
      print("Có cái gì đó sai sai ${response.statusCode}");
      orders = null;
    }
    return orders;
  }
}
