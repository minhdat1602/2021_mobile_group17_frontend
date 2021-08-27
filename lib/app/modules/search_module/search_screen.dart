import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/search_module/search_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchController searchController = Get.put(SearchController());

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
          title: Obx(
            () => TextFormField(
              cursorColor: Colors.black45,
              autofocus: true,
              onChanged: (value) => searchController.keyword.value = value,
              initialValue: searchController.keyword.value,
              decoration: InputDecoration(
                hintText: "Sản phẩm, thương hiệu và mọi thứ bạn cần...",
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                await searchController.searchByKeyword();
              },
              icon: Icon(Icons.search),
            ),
          ],
        ),
      ),
    );
  }
}
