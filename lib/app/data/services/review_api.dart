import 'package:mobile_nhom17_2021/app/data/models/review.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobile_nhom17_2021/app/data/services/contants.dart';

class ReviewAPI {
  Future<Review> rating(Review review) async {
    String url = "$host/review";
    print(url);
    Uri uri = Uri.parse(url);
    var response;
    var body = json.encode(review.toJson());
    try {
      response = await http.Client().post(uri, body: body, headers: headers);
      if (response.statusCode == 200) {
        var data = json.decode(utf8.decode(response.bodyBytes));
        if (data['status'] == 'success') {
          var rv = data['data'];
          Review result = Review.fromJson(rv);
          return result;
        } else
          return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Review>> fetchReview(int productId) async {
    String url =
        "https://mobile2021group17.herokuapp.com/review?productId=$productId";
    Uri uri = Uri.parse(url);

    var response;
    try {
      response = await http.Client().get(uri, headers: headers);
      List<Review> results;
      if (response.statusCode == 200) {
        var responseValue = json.decode(utf8.decode(response.bodyBytes));
        String status = responseValue['status'];
        if (status == 'success') {
          Iterable data = responseValue['data'];
          results = data.map((e) => Review.fromJson(e)).toList();
          return results;
        } else {
          print(responseValue['message']);
        }
      } else {
        print("Có gì đó sai sai ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
