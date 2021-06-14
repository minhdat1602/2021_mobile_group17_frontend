import 'package:flutter/material.dart';

import 'package:mobile_nhom17_2021/screens/bottom_nav_screen.dart';
import 'package:mobile_nhom17_2021/screens/login_screen.dart';
import 'package:mobile_nhom17_2021/screens/register_screen.dart';

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
      home: BottomNavScreen(),
      routes: {
        "/signup": (context) => RegisterScreen(),
        "/signin": (context) => LoginScreen(),
      },
    );
  }
}
