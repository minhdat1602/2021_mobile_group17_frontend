import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/controllers/menu_controller.dart';
import 'package:mobile_nhom17_2021/app/controllers/shop_controller.dart';
import 'package:mobile_nhom17_2021/app/models/brand.dart';
import 'package:mobile_nhom17_2021/app/models/category.dart';

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

  List<Category> _categories;

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
                DrawerHeader(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Text(
                      "DJ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ExpansionTile(
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
                ),
                ExpansionTile(
                  title: Text("Thương hiệu",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      )),
                  children: List.generate(
                          _categories == null ? 0 : _categories.length,
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
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
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
                    ),
                  ),
                  Expanded(
                    child: TextButton(
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
