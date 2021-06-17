import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_nhom17_2021/models/brand.dart';
import 'package:mobile_nhom17_2021/models/category.dart';
import 'package:mobile_nhom17_2021/screens/web/shop_screen.dart';
import 'package:mobile_nhom17_2021/service/product_service.dart';
import 'package:mobile_nhom17_2021/widgets/appbar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuScreen extends StatefulWidget {
  static String routeName = "/menu";
  // final PersistentTabController _controller;
  // MenuScreen(this._controller);
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<Brand> brands = new List<Brand>.empty();
  List<Category> categories = new List<Category>.empty();

  @override
  void initState() {
    _initData();
    super.initState();
  }

  Future<void> _initData() async {
    final _prefs = await SharedPreferences.getInstance();

    Iterable brandsData = json.decode(_prefs.getString("brands"));
    Iterable categoriesData = json.decode(_prefs.getString("categories"));

    setState(() {
      brands = brandsData.map((brand) => Brand.fromJson(brand)).toList();
      categories = categoriesData
          .map((category) => Category.fromJson(category))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Danh mục"),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black87,
        child: Theme(
          data: Theme.of(context).copyWith(
              accentColor: Colors.white54,
              unselectedWidgetColor: Colors.white54),
          child: ListView(
            children: [
              _buildHomeBtn(),
              Divider(color: Colors.white54),
              _buildShopAllBtn(),
              Divider(color: Colors.white54),
              _buildNewBtn(),
              Divider(color: Colors.white54),
              _buildSaleBtn(),
              Divider(color: Colors.white54),
              _buildCategoriesBtn(),
              Divider(color: Colors.white54),
              _buildBrandBtn(),
              Divider(color: Colors.white54),
              _buildCollectionBtn(),
              Divider(color: Colors.white54),
              _buildMaleBtn(),
              Divider(color: Colors.white54),
              _buildFemaleBtn(),
              Divider(color: Colors.white54),
              _buildChildrenBtn(),
              Divider(color: Colors.white54),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _buildHomeBtn() {
    return ListTile(
      title: Text("Trang chủ", style: TextStyle(color: Colors.white54)),
      hoverColor: Colors.white54,
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      onTap: () {
        setState(() {
          // widget._controller.index = 0;
        });
      },
    );
  }

  ListTile _buildShopAllBtn() {
    return ListTile(
      title: Text("Tất cả sản phẩm", style: TextStyle(color: Colors.white54)),
      hoverColor: Colors.white54,
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      onTap: () {
        pushNewScreen(
          context,
          screen: ShopScreen(fetchProduct: fetchProductAll()),
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
    );
  }

  ListTile _buildNewBtn() {
    return ListTile(
      title: Text("Mới nhất", style: TextStyle(color: Colors.white54)),
      hoverColor: Colors.white54,
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      onTap: () {
        pushNewScreen(
          context,
          screen: ShopScreen(fetchProduct: fetchProductNew()),
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
    );
  }

  ListTile _buildSaleBtn() {
    return ListTile(
      title: Text("Giảm giá", style: TextStyle(color: Colors.white54)),
      hoverColor: Colors.white54,
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      onTap: () {
        setState(() {
          pushNewScreen(
            context,
            screen: ShopScreen(fetchProduct: fetchProductDiscount()),
            withNavBar: true, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        });
      },
    );
  }

  ListTile _buildMaleBtn() {
    return ListTile(
      title: Text("Nam", style: TextStyle(color: Colors.white54)),
      hoverColor: Colors.white54,
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      onTap: () {
        setState(() {
          pushNewScreen(
            context,
            screen: ShopScreen(fetchProduct: fetchProductType(1)),
            withNavBar: true, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        });
      },
    );
  }

  ListTile _buildFemaleBtn() {
    return ListTile(
      title: Text("Nữ", style: TextStyle(color: Colors.white54)),
      hoverColor: Colors.white54,
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      onTap: () {
        pushNewScreen(
          context,
          screen: ShopScreen(fetchProduct: fetchProductType(2)),
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
    );
  }

  ListTile _buildChildrenBtn() {
    return ListTile(
      title: Text("Trẻ em", style: TextStyle(color: Colors.white54)),
      hoverColor: Colors.white54,
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      onTap: () {
        pushNewScreen(
          context,
          screen: ShopScreen(fetchProduct: fetchProductType(3)),
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
    );
  }

  ExpansionTile _buildCategoriesBtn() {
    return ExpansionTile(
      title: Text("Loại sản phẩm", style: TextStyle(color: Colors.white54)),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment: Alignment.centerLeft,
      backgroundColor: Colors.black,
      childrenPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      children: categories
          .map<Widget>(
            (category) => ListTile(
              title:
                  Text(category.name, style: TextStyle(color: Colors.white54)),
              hoverColor: Colors.white54,
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              onTap: () {
                pushNewScreen(
                  context,
                  screen: ShopScreen(
                      fetchProduct: fetchProductCategory(category.id)),
                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
            ),
          )
          .toList(),
    );
  }

  ExpansionTile _buildBrandBtn() {
    return ExpansionTile(
      title: Text("Thương hiệu", style: TextStyle(color: Colors.white54)),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment: Alignment.centerLeft,
      backgroundColor: Colors.black,
      childrenPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      children: brands
          .map<Widget>(
            (brand) => ListTile(
              title: Text(brand.name, style: TextStyle(color: Colors.white54)),
              hoverColor: Colors.white54,
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              onTap: () {
                pushNewScreen(
                  context,
                  screen: ShopScreen(fetchProduct: fetchProductBrand(brand.id)),
                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
            ),
          )
          .toList(),
    );
  }

  ExpansionTile _buildCollectionBtn() {
    return ExpansionTile(
      title: Text("Bộ sưu tập", style: TextStyle(color: Colors.white54)),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment: Alignment.centerLeft,
      backgroundColor: Colors.black,
      childrenPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      children: brands
          .map<Widget>(
            (brand) => ExpansionTile(
              title: Text(brand.name, style: TextStyle(color: Colors.white54)),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              expandedAlignment: Alignment.centerLeft,
              backgroundColor: Colors.black,
              childrenPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              children: brand.collections
                  .map<Widget>(
                    (collection) => ListTile(
                      title: Text(collection.name,
                          style: TextStyle(color: Colors.white54)),
                      hoverColor: Colors.white54,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      onTap: () {
                        pushNewScreen(
                          context,
                          screen: ShopScreen(
                              fetchProduct:
                                  fetchProductCollection(collection.id)),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }
}
