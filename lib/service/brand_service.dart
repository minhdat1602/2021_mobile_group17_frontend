import 'package:mobile_nhom17_2021/models/brand.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<List<Brand>> fetchBrandAll() async {
  Uri url = Uri.parse("https://mobile2021group17.herokuapp.com/brand/all");
  var response = await http
      .get(url, headers: {"Content-Type": "application/json; charset=utf-8"});
  List<Brand> brands = [];
  if (response.statusCode == 200) {
    try {
      SharedPreferences sprefs = await SharedPreferences.getInstance();
      sprefs.setString("brands", response.body);

      Iterable data = json.decode(response.body);
      brands = data.map((brand) => Brand.fromJson(brand)).toList();
    } catch (e) {
      print("Something get wrong!");
    }
  } else
    print("Something get wrong! Status code ${response.statusCode}");
  return brands;
}
