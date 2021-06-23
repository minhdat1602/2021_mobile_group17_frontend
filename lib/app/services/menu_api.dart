import 'dart:convert';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/data/models/brand.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_nhom17_2021/app/data/models/category.dart';

const baseUrl = 'http://gerador-nomes.herokuapp.com/nomes/10';

class MenuAPI extends GetConnect {
  Future<List<Brand>> fetchBrandAll() async {
    Uri url = Uri.parse("https://mobile2021group17.herokuapp.com/brand/all");
    var response = await http.Client()
        .get(url, headers: {"Content-Type": "application/json"});
    List<Brand> brands = [];
    if (response.statusCode == 200) {
      try {
        Iterable data = json.decode(response.body);
        brands = data.map((brand) => Brand.fromJson(brand)).toList();
      } catch (e) {
        print("Something get wrong!");
      }
    } else
      print("Something get wrong! Status code ${response.statusCode}");
    return brands;
  }

  Future<List<Category>> fetchCategoryAll() async {
    Uri url = Uri.parse("https://mobile2021group17.herokuapp.com/category/all");
    var response = await http
        .get(url, headers: {"Content-Type": "application/json; charset=utf-8"});
    List<Category> categories = [];
    if (response.statusCode == 200) {
      try {
        Iterable data = json.decode(response.body);
        categories =
            data.map((category) => Category.fromJson(category)).toList();
      } catch (e) {
        print("Something get wrong!");
      }
    } else
      print("Something get wrong! Status code ${response.statusCode}");
    return categories;
  }
}
