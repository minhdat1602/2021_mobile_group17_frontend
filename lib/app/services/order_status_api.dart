import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobile_nhom17_2021/app/models/status.dart';
import 'package:mobile_nhom17_2021/app/services/contants.dart';

class StatusAPI {
  Future<List<Status>> fetchStatus() async {
    String url = "$host\/status\/all";
    Uri uri = Uri.parse(url);

    var response;
    response = await http.Client().get(uri, headers: headers);
    List<Status> results = [];
    if (response.statusCode == 200) {
      Iterable data = json.decode(utf8.decode(response.bodyBytes));
      results = data.map((e) => Status.fromJson(e)).toList();
    } else {
      print("Lỗi: ${response.statusCode}");
      throw Exception();
    }
    return results;
  }
}
