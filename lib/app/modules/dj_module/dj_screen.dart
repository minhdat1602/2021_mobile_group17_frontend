import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/routes/app_pages.dart';
import 'package:shimmer/shimmer.dart';

class DJScreen extends StatefulWidget {
  const DJScreen({Key key}) : super(key: key);

  @override
  _DJScreenState createState() => _DJScreenState();
}

class _DJScreenState extends State<DJScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () => {Get.offNamed(Routes.INITIAL)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        color: Colors.black,
        child: Center(
          child: Shimmer.fromColors(
            child: Text(
              "DJ",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
            baseColor: Colors.white,
            highlightColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
