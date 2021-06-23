import 'package:mobile_nhom17_2021/app/data/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShopAPI {
  Future<List<Product>> fetchProductAll() async {
    Uri url = Uri.parse("https://mobile2021group17.herokuapp.com/product/all");
    var response = await http.get(url);
    List<Product> products = [];
    if (response.statusCode == 200) {
      try {
        Iterable data = json.decode(response.body.toString());
        products = data.map((product) => Product.fromJson(product)).toList();
      } catch (e) {
        print("Something get wrong!:");
        print(e);
      }
    } else
      print("Something get wrong! Status code ${response.statusCode}");
    print(products.length);
    return products;
  }

  Future<List<Product>> fetchProducts(String hostName) async {
    Uri url = Uri.parse("$hostName");
    var response = await http
        .get(url, headers: {"Content-Type": "application/json; charset=utf-8"});
    List<Product> products = [];
    if (response.statusCode == 200) {
      try {
        Iterable data = json.decode(response.body);
        products = data.map((product) => Product.fromJson(product)).toList();
      } catch (e) {
        print("Something get wrong!");
      }
    } else
      print("Something get wrong! Status code ${response.statusCode}");
    print(products.length);
    return products;
  }

  Future<List<Product>> fetchProductNew() async {
    Uri url = Uri.parse("https://mobile2021group17.herokuapp.com/product/new");
    var response = await http
        .get(url, headers: {"Content-Type": "application/json; charset=utf-8"});
    List<Product> products = [];
    if (response.statusCode == 200) {
      try {
        Iterable data = json.decode(response.body);
        products = data.map((product) => Product.fromJson(product)).toList();
      } catch (e) {
        print("Something get wrong!");
      }
    } else
      print("Something get wrong! Status code ${response.statusCode}");
    print(products.length);
    return products;
  }

  Future<List<Product>> fetchProductDiscount() async {
    Uri url =
        Uri.parse("https://mobile2021group17.herokuapp.com/product/discount");
    var response = await http
        .get(url, headers: {"Content-Type": "application/json; charset=utf-8"});
    List<Product> products = [];
    if (response.statusCode == 200) {
      try {
        Iterable data = json.decode(response.body);
        products = data.map((product) => Product.fromJson(product)).toList();
      } catch (e) {
        print("Something get wrong!");
      }
    } else
      print("Something get wrong! Status code ${response.statusCode}");
    print(products.length);
    return products;
  }

  Future<List<Product>> fetchProductCategory(int id) async {
    Uri url = Uri.parse(
        "https://mobile2021group17.herokuapp.com/product/category/$id");
    var response = await http
        .get(url, headers: {"Content-Type": "application/json; charset=utf-8"});
    List<Product> products = [];
    if (response.statusCode == 200) {
      try {
        Iterable data = json.decode(response.body);
        products = data.map((product) => Product.fromJson(product)).toList();
      } catch (e) {
        print("Something get wrong!");
      }
    } else
      print("Something get wrong! Status code ${response.statusCode}");
    print(products.length);
    return products;
  }

  Future<List<Product>> fetchProductBrand(int id) async {
    Uri url =
        Uri.parse("https://mobile2021group17.herokuapp.com/product/brand/$id");
    var response = await http
        .get(url, headers: {"Content-Type": "application/json; charset=utf-8"});
    List<Product> products = [];
    if (response.statusCode == 200) {
      try {
        Iterable data = json.decode(response.body);
        products = data.map((product) => Product.fromJson(product)).toList();
      } catch (e) {
        print("Something get wrong!");
      }
    } else
      print("Something get wrong! Status code ${response.statusCode}");
    print(products.length);
    return products;
  }

  Future<List<Product>> fetchProductCollection(int id) async {
    Uri url = Uri.parse(
        "https://mobile2021group17.herokuapp.com/product/collection/$id");
    var response = await http
        .get(url, headers: {"Content-Type": "application/json; charset=utf-8"});
    List<Product> products = [];
    if (response.statusCode == 200) {
      try {
        Iterable data = json.decode(response.body);
        products = data.map((product) => Product.fromJson(product)).toList();
      } catch (e) {
        print("Something get wrong!");
      }
    } else
      print("Something get wrong! Status code ${response.statusCode}");
    print(products.length);
    return products;
  }

  Future<List<Product>> fetchProductType(int id) async {
    Uri url =
        Uri.parse("https://mobile2021group17.herokuapp.com/product/type/$id");
    var response = await http
        .get(url, headers: {"Content-Type": "application/json; charset=utf-8"});
    List<Product> products = [];
    if (response.statusCode == 200) {
      try {
        Iterable data = json.decode(response.body);
        products = data.map((product) => Product.fromJson(product)).toList();
      } catch (e) {
        print("Something get wrong!");
      }
    } else
      print("Something get wrong! Status code ${response.statusCode}");
    print(products.length);
    return products;
  }
}
