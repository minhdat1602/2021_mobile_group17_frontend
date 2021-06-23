import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_home_module/widgets/appbar.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_home_module/widgets/drawer.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(),
      body: SafeArea(
        child: Text('AdminHomeController'),
      ),
      drawer: DrawerWidget(),
    );
  }
}
