import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_nhom17_2021/app/data/models/coupon.dart';

import 'contants.dart';

class CouponApi extends GetConnect {
  var client = http.Client();

  Future<Coupon> findByCode(String code) async {
    String urlStr = "$host/coupon/$code";
    Uri url = Uri.parse(urlStr);

    var response;
    try {
      response = await client.get(url, headers: headers);

      if (response.statusCode == 200) {
        return Coupon.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      } else {
        print("find coupon by code error: ${response.statusCode}");
        throw new Exception("Không tìm thấy coupon !");
      }
    } catch (e) {
      print(e);
      throw new Exception("Không tìm thấy coupon !");
    }
  }
}
