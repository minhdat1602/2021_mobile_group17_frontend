import 'dart:convert';

import 'package:mobile_nhom17_2021/app/data/models/product.dart';
import 'package:mobile_nhom17_2021/app/data/services/contants.dart';
import 'package:http/http.dart' as http;

class ProductAPI {
  Future<List<Product>> fetchAll() async {
    String uriStr = "$host/admin/product";
    Uri url = Uri.parse(uriStr);
    var response;
    try {
      response = await http.Client().get(url, headers: headers);
      if (response.statusCode == 200) {
        Iterable data = json.decode(utf8.decode(response.bodyBytes));
        return data.map((e) => Product.fromJson(e)).toList();
      } else {
        print("ERROR: ${response.statusCode}");
        throw new Exception("ERROR: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      throw new Exception(e);
    }
  }
}
