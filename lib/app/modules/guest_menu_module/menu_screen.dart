import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/data/models/brand.dart';
import 'package:mobile_nhom17_2021/app/data/models/category.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_bottom_nav_module/bottom_nav_controller.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_menu_module/menu_controller.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_shop_module/shop_controller.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_shop_module/shop_screen.dart';
import 'package:mobile_nhom17_2021/app/routes/app_pages.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../global_widgets/appbar.dart';

class MenuScreen extends StatelessWidget {
  MenuController menuController = Get.find();
  BottomNavController bottomNavController = Get.find<BottomNavController>();
  ShopController shopController = Get.put(ShopController());

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
              _buildHotBtn(),
              Divider(color: Colors.white54),
              _buildHighlighBtn(),
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
        bottomNavController.ptController.index = 0;
      },
    );
  }

  ListTile _buildShopAllBtn() {
    return ListTile(
      title: Text("Tất cả sản phẩm", style: TextStyle(color: Colors.white54)),
      hoverColor: Colors.white54,
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      onTap: () {
        shopController.fetchProductAll();
        pushNewScreen(
          Get.context,
          screen: ShopScreen(),
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
    );
  }

  ListTile _buildHotBtn() {
    return ListTile(
      title: Text("Bán chạy", style: TextStyle(color: Colors.white54)),
      hoverColor: Colors.white54,
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      onTap: () {
        shopController.fetchProducts("hot", null);
        Get.toNamed(Routes.SHOP);
      },
    );
  }

  ListTile _buildHighlighBtn() {
    return ListTile(
      title: Text("Nổi bật", style: TextStyle(color: Colors.white54)),
      hoverColor: Colors.white54,
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      onTap: () {
        shopController.fetchProducts("highligh", null);
        Get.toNamed(Routes.SHOP);
      },
    );
  }

  ListTile _buildNewBtn() {
    return ListTile(
      title: Text("Mới nhất", style: TextStyle(color: Colors.white54)),
      hoverColor: Colors.white54,
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      onTap: () {
        shopController.fetchProducts("new", null);
        Get.toNamed(Routes.SHOP);
      },
    );
  }

  ListTile _buildSaleBtn() {
    return ListTile(
      title: Text("Giảm giá", style: TextStyle(color: Colors.white54)),
      hoverColor: Colors.white54,
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      onTap: () {
        shopController.fetchProducts("discount", null);
        Get.toNamed(Routes.SHOP);
      },
    );
  }

  ListTile _buildMaleBtn() {
    return ListTile(
      title: Text("Nam", style: TextStyle(color: Colors.white54)),
      hoverColor: Colors.white54,
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      onTap: () {
        shopController.fetchProducts("type", 1);
        Get.toNamed(Routes.SHOP);
      },
    );
  }

  ListTile _buildFemaleBtn() {
    return ListTile(
      title: Text("Nữ", style: TextStyle(color: Colors.white54)),
      hoverColor: Colors.white54,
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      onTap: () {
        shopController.fetchProducts("type", 2);
        Get.toNamed(Routes.SHOP);
      },
    );
  }

  ListTile _buildChildrenBtn() {
    return ListTile(
      title: Text("Trẻ em", style: TextStyle(color: Colors.white54)),
      hoverColor: Colors.white54,
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      onTap: () {
        shopController.fetchProducts("type", 3);
        Get.toNamed(Routes.SHOP);
      },
    );
  }

  Widget _buildCategoriesBtn() {
    return FutureBuilder<List<Category>>(
      future: menuController.categories.value,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ExpansionTile(
            title:
                Text("Loại sản phẩm", style: TextStyle(color: Colors.white54)),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            expandedAlignment: Alignment.centerLeft,
            backgroundColor: Colors.black,
            childrenPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            children: snapshot.data
                .map<Widget>(
                  (category) => ListTile(
                    title: Text(category.name,
                        style: TextStyle(color: Colors.white54)),
                    hoverColor: Colors.white54,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    onTap: () {
                      shopController.fetchProducts("category", category.id);
                      Get.toNamed(Routes.SHOP);
                    },
                  ),
                )
                .toList(),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Có gì đó sai sai"));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildBrandBtn() {
    return FutureBuilder<List<Brand>>(
      future: menuController.brands.value,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ExpansionTile(
            title: Text("Thương hiệu", style: TextStyle(color: Colors.white54)),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            expandedAlignment: Alignment.centerLeft,
            backgroundColor: Colors.black,
            childrenPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            children: snapshot.data
                .map<Widget>(
                  (brand) => ListTile(
                    title: Text(brand.name,
                        style: TextStyle(color: Colors.white54)),
                    hoverColor: Colors.white54,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    onTap: () {
                      shopController.fetchProducts("brand", brand.id);
                      Get.toNamed(Routes.SHOP);
                    },
                  ),
                )
                .toList(),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Có gì đó sai sai"));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildCollectionBtn() {
    return FutureBuilder<List<Brand>>(
      future: menuController.brands.value,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ExpansionTile(
            title: Text("Bộ sưu tập", style: TextStyle(color: Colors.white54)),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            expandedAlignment: Alignment.centerLeft,
            backgroundColor: Colors.black,
            childrenPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            children: snapshot.data
                .map<Widget>(
                  (brand) => ExpansionTile(
                    title: Text(brand.name,
                        style: TextStyle(color: Colors.white54)),
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
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            onTap: () {
                              shopController.fetchProducts(
                                  "collection", collection.id);
                              Get.toNamed(Routes.SHOP);
                            },
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList(),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Có gì đó sai sai"));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
