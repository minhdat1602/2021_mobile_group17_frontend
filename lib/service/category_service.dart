import 'package:http/http.dart' as http;
import 'package:mobile_nhom17_2021/models/category.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<List<Category>> fetchCategoryAll() async {
  Uri url = Uri.parse("https://mobile2021group17.herokuapp.com/category/all");
  var response = await http
      .get(url, headers: {"Content-Type": "application/json; charset=utf-8"});
  List<Category> categories = [];
  if (response.statusCode == 200) {
    try {
      SharedPreferences sprefs = await SharedPreferences.getInstance();
      sprefs.setString("categories", response.body);

      Iterable data = json.decode(response.body);
      categories = data.map((category) => Category.fromJson(category)).toList();
    } catch (e) {
      print("Something get wrong!");
    }
  } else
    print("Something get wrong! Status code ${response.statusCode}");
  return categories;
}
