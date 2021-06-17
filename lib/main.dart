import 'package:flutter/material.dart';
import 'package:mobile_nhom17_2021/routes.dart';
import 'package:mobile_nhom17_2021/screens/web/bottom_nav_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shoes Project',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.black,
      ),
      routes: routes,
      initialRoute: BottomNavScreen.routeName,
    );
  }
}
