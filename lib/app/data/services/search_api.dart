import 'dart:convert';
import 'dart:io';

import 'package:mobile_nhom17_2021/app/data/models/product.dart';
import 'package:mobile_nhom17_2021/app/data/services/contants.dart';
import "package:http/http.dart" as http;

class SearchAPI {
  var client = http.Client();
  Future<List<Product>> search(String keyword) async {
    String url = "$host\/search\?keyword=$keyword";
    print(url);
    Uri uri = Uri.parse(url);
    var response;
    try {
      response = await client.get(uri, headers: headers);
    } catch (e) {
      print(e.message);
    }
    if (response.statusCode == 200) {
      Iterable ite = json.decode(utf8.decode(response.bodyBytes));
      return ite.map((e) => Product.fromJson(e)).toList();
    } else {
      print("[INFO] Lỗi ${response.statusCode}");
      throw new Exception(response.statusCode);
    }
  }
}
