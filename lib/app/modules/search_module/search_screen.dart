import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        accentColor: Colors.white,
        backgroundColor: Colors.black,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          border: InputBorder.none,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            cursorColor: Colors.black45,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "Sản phẩm, thương hiệu và mọi thứ bạn cần...",
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
          ],
        ),
      ),
    );
  }
}
