import 'dart:core';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/data/models/category.dart';
import 'package:mobile_nhom17_2021/app/data/models/type.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_menu_module/menu_controller.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_shop_module/shop_controller.dart';
import 'package:shimmer/shimmer.dart';

class EndDrawerWidget extends StatefulWidget {
  const EndDrawerWidget({Key key}) : super(key: key);

  @override
  _EndDrawerWidgetState createState() => _EndDrawerWidgetState();
}

class _EndDrawerWidgetState extends State<EndDrawerWidget> {
  MenuController menuController = Get.find<MenuController>();

  String _price;
  String size;
  String color;
  String _category;
  String category;

  String _type;

  List<Category> _categories = [];
  List<TypeModel> _types = [];

  @override
  void initState() {
    super.initState();
    menuController.categories.value.then((value) {
      if (value == null)
        _categories = [];
      else
        _categories = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 10,
            child: ListView(
              children: [
                _buildLogoHeader(),
                SizedBox(height: 15),
                _buildSearchBtn(),
                _buildPriceFilter(),
                _buildBrandFilter(),
                _buildTypeFilter(),
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: _buildDeleteBtn(),
                  ),
                  Expanded(
                    child: _buildApplyBtn(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBtn() {
    return Theme(
      data: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(0),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              height: 50,
              margin: EdgeInsets.only(left: 12),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  hintText: "Tìm kiếm...",
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            color: Colors.green,
            margin: EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
          ),
        ],
      ),
    );
  }

  DrawerHeader _buildLogoHeader() {
    return DrawerHeader(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Center(
        child: Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Colors.grey[400],
          direction: ShimmerDirection.ltr,
          child: Text(
            "ANT",
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  TextButton _buildDeleteBtn() {
    return TextButton(
      onPressed: () {
        setState(() {
          _price = null;
          _category = null;
        });
        Get.find<ShopController>().filter(_category, _price);
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.black,
        padding: EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      child: Text(
        "Xóa",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }

  TextButton _buildApplyBtn() {
    return TextButton(
      onPressed: () {
        Get.find<ShopController>().filter(_category, _price);
      },
      style: TextButton.styleFrom(
        backgroundColor: Get.theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      child: Text(
        "Áp dụng",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }

  ExpansionTile _buildTypeFilter() {
    return ExpansionTile(
      title: Text(
        "Giới tính",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      children: List.generate(
              _types == null ? 0 : _types.length, (index) => _types[index].name)
          .map<Widget>(
            (category) => ListTile(
              selectedTileColor: Get.theme.primaryColor,
              selected: true,
              title: Text(
                category,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              hoverColor: Colors.black,
              onTap: () {
                setState(() {
                  // _category = category;
                  // print(_price);
                });
              },
            ),
          )
          .toList(),
    );
  }

  ExpansionTile _buildBrandFilter() {
    return ExpansionTile(
      title: Text(
        "Thương hiệu",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      children: List.generate(_categories == null ? 0 : _categories.length,
              (index) => _categories[index].name)
          .map<Widget>(
            (category) => ListTile(
              selectedTileColor: Get.theme.primaryColor,
              selected: _category == category ? true : false,
              title: Text(
                category,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              hoverColor: Colors.black,
              onTap: () {
                setState(() {
                  _category = category;
                  print(_price);
                });
              },
            ),
          )
          .toList(),
    );
  }

  ExpansionTile _buildPriceFilter() {
    return ExpansionTile(
      title: Text("Giá tiền",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          )),
      children: [
        "0 - 1,000,000 đ",
        "1,000,000 - 2,000,000 đ",
        "2,000,000 - 3,000,000 đ",
        "> 3,000,000 đ",
      ]
          .map<Widget>(
            (price) => ListTile(
              selectedTileColor: Get.theme.primaryColor,
              selected: _price == price ? true : false,
              title: Text(
                price,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              hoverColor: Colors.black,
              onTap: () {
                setState(() {
                  _price = price;
                  print(_price);
                });
              },
            ),
          )
          .toList(),
    );
  }
}
