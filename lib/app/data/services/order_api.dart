import 'dart:convert';

import 'package:mobile_nhom17_2021/app/data/models/order.dart';
import 'package:mobile_nhom17_2021/app/data/models/order_statistics.dart';
import 'package:mobile_nhom17_2021/app/data/services/contants.dart';
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

  Future<List<Order>> fetchOrdersByUser(int userId, int statusId) async {
    String urlStr =
        "$host\/order\/user?userId=$userId${statusId == null ? '' : '&statusId=$statusId'}";
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

  Future<Order> updateStatus(Order order) async {
    String urlStr = "$host\/order";
    Uri url = Uri.parse(urlStr);
    var response;
    var body = json.encode(order.toJson());
    try {
      response = await http.Client().put(url, headers: headers, body: body);
    } catch (e) {
      print(e);
    }
    if (response.statusCode == 200) {
      try {
        return Order.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      } catch (e) {
        print(e);
        return null;
      }
    } else {
      print("Có cái gì đó sai sai ${response.statusCode}");
      return null;
    }
  }

  Future<List<Order>> fetchOrdersByStatus(int statusId) async {
    String urlStr = "$host\/order\/status\/$statusId";
    Uri url = Uri.parse(urlStr);
    List<Order> orders;
    var response;
    try {
      response = await http.Client().get(url, headers: headers);
    } catch (e) {
      print(e);
      return null;
    }
    if (response.statusCode == 200) {
      try {
        Iterable data = json.decode(utf8.decode(response.bodyBytes));
        orders = data.map((orderStr) => Order.fromJson(orderStr)).toList();
      } catch (e) {
        print(e);
        return null;
      }
    } else {
      print("Có cái gì đó sai sai ${response.statusCode}");
      orders = null;
    }
    return orders;
  }

  Future<OrderStatistics> fetchOrderStatistics() async {
    String urlStr = "$host\/statistics\/order";
    Uri url = Uri.parse(urlStr);
    List<OrderStatistics> orderStatistics;
    var response;
    try {
      response = await http.Client().get(url, headers: headers);
    } catch (e) {
      print(e);
    }
    if (response.statusCode == 200) {
      try {
        String utf8Str = utf8.decode(response.bodyBytes);
        Map<dynamic, dynamic> jsonModel = json.decode(utf8Str);
        return OrderStatistics.fromJson(jsonModel);
      } catch (e) {
        print(e);
        return null;
      }
    } else {
      print("Có cái gì đó sai sai ${response.statusCode}");
      return null;
    }
  }
}
