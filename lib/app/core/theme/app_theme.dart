import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: Color.fromARGB(255, 67, 213, 176),
  accentColor: Color.fromARGB(255, 35, 103, 148),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    brightness: Brightness.dark,
    centerTitle: true,
    foregroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
  ),
  // fontFamily: 'Georgia',
  textTheme: TextTheme(
    headline1: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
    headline2: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
    headline3: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
    headline4: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.indigo[400]),
    bodyText1: TextStyle(
      color: Colors.black,
      fontSize: 14.0,
      letterSpacing: 0.3,
    ),
    bodyText2: TextStyle(
      color: Colors.red[400],
      fontSize: 14.0,
      letterSpacing: 0.3,
    ),
  ),
);
