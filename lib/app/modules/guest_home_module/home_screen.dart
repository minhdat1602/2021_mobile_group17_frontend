import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_shop_module/shop_controller.dart';
import 'package:mobile_nhom17_2021/app/routes/app_pages.dart';

import '../../screens/web/global_widgets/appbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Trang chủ"),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: ListView(
          children: [
            _buildCarouselComponent(),
            SizedBox(height: 15),
            _buildCategoryComponent(),
            _buildSportComponent(),
            _buildMember(),
            _buildSaleoffComponent(),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildMember() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      child: InkWell(
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset(
              "assets/images/11.jpg",
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  onPressed: () {
                    Get.find<ShopController>().fetchProductAll();
                    Get.to(Routes.USER_SHOP);
                  },
                  child: Text(
                    "Cửa hàng",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      letterSpacing: 1.5,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0.2,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildSportComponent() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Thể thao",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.find<ShopController>().fetchProducts("category", 2);
                    Get.toNamed(Routes.USER_SHOP);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Image.asset(
                          "assets/images/7.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Bóng đá",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.find<ShopController>().fetchProducts("category", 1);
                    Get.toNamed(Routes.USER_SHOP);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Image.asset(
                          "assets/images/6.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Đường phố",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildCategoryComponent() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: InkWell(
        onTap: () {
          Get.find<ShopController>().fetchProductAll();
          Get.to(Routes.USER_SHOP);
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Loại sản phẩm",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Tất cả sản phẩm ",
                  style: TextStyle(letterSpacing: 1),
                ),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              child: Image.asset(
                "assets/images/5.jpg",
                fit: BoxFit.fitWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildSaleoffComponent() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: InkWell(
        onTap: () {
          Get.find<ShopController>().fetchProducts("discount", null);
          Get.to(Routes.USER_SHOP);
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Giảm giá",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Tất cả sản phẩm ",
                  style: TextStyle(letterSpacing: 1),
                ),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              child: Image.asset(
                "assets/images/4.jpg",
                fit: BoxFit.fitWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _buildCarouselComponent() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.65,
      child: Carousel(
        dotSize: 5.0,
        dotSpacing: 15.0,
        dotColor: Colors.black,
        indicatorBgPadding: 10,
        dotBgColor: Colors.transparent,
        images: [
          InkWell(
            onTap: () {
              Get.find<ShopController>().fetchProductAll();
              Get.toNamed(Routes.USER_SHOP);
            },
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset(
                  "assets/images/3.jpg",
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 45),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Cửa hàng",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          letterSpacing: 1.5,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0.2,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              print("click picture 2");
            },
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.topCenter,
              children: [
                Image.asset(
                  "assets/images/1.jpg",
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 45),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      onPressed: () {
                        Get.find<ShopController>().fetchProductAll();
                        Get.toNamed(Routes.USER_SHOP);
                      },
                      child: Text(
                        "Cửa hàng",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          letterSpacing: 1.5,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0.2,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              print("click picture 1");
            },
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset(
                  "assets/images/2.jpg",
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 45),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      onPressed: () {
                        Get.find<ShopController>().fetchProductAll();
                        Get.to(Routes.USER_SHOP);
                      },
                      child: Text(
                        "Cửa hàng",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          letterSpacing: 1.5,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0.2,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
