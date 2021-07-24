import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomProgress extends StatelessWidget {
  const CustomProgress({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Lấy dữ liệu",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w300,
              fontSize: 14,
              letterSpacing: 1.5,
            ),
          ),
          Container(
            width: Get.width / 3,
            child: LinearProgressIndicator(
              backgroundColor: Colors.white,
              color: Colors.black,
              minHeight: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
