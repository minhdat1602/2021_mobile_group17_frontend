import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/utils/utils.dart';
import 'package:mobile_nhom17_2021/app/core/utils/price_toVnd.dart';
import 'package:mobile_nhom17_2021/app/core/utils/utils.dart';
import 'package:mobile_nhom17_2021/app/global_widgets/progress.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_bottom_nav_module/bottom_nav_controller.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_home_module/home_controller.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_product_module/product_controller.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_shop_module/shop_controller.dart';
import 'package:mobile_nhom17_2021/app/routes/app_pages.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../global_widgets/appbar.dart';
import 'widgets/product_carousel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Trang chủ"),
      body: Obx(() => homeController.loaded
          ? Container(
              width: Get.width,
              color: Colors.white,
              padding: EdgeInsets.only(bottom: 30),
              child: ListView(
                children: [
                  _buildBanner(),
                  SizedBox(height: 40),
                  _buildHighLigh(),
                  SizedBox(height: 40),
                  _buildBestSeller(),

                  // SizedBox(height: 15),
                  // _buildCategoryComponent(),
                  // _buildSportComponent(),
                  // _buildMember(),
                  // _buildSaleoffComponent(),
                  // SizedBox(height: 50),
                ],
              ),
            )
          : CustomProgress()),
    );
  }

  Widget _buildHighLigh() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Gợi ý hôm nay",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.find<ShopController>().fetchProducts("highligh", null);
                    Get.toNamed(Routes.SHOP);
                  },
                  child: Text(
                    "Xem thêm",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          ProductCarousel(
            imageCarouselController: homeController.imageCarouselController,
            products: homeController.discount,
          ),
        ],
      ),
    );
  }

  Container _buildBestSeller() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sản phẩm bán chạy",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.find<ShopController>().fetchProducts("hot", null);
                    Get.toNamed(Routes.SHOP);
                  },
                  child: Text(
                    "Xem thêm",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          ProductCarousel(
            imageCarouselController: homeController.imageCarouselController,
            products: homeController.bestseller,
          ),
        ],
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
                    Get.to(Routes.SHOP);
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
                    Get.toNamed(Routes.SHOP);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Image.asset(
                          "assets/images/7.jpg",
                          fit: BoxFit.fitHeight,
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
                    Get.toNamed(Routes.SHOP);
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
          Get.to(Routes.SHOP);
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
          Get.to(Routes.SHOP);
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

  SizedBox _buildBanner() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.65,
      child: Carousel(
        dotSize: 5.0,
        dotSpacing: 15.0,
        autoplayDuration: Duration(seconds: 6),
        autoplay: false,
        dotColor: Colors.black,
        indicatorBgPadding: 10,
        dotBgColor: Colors.transparent,
        images: [
          _buildVideoPlayer(),
          Stack(
            fit: StackFit.expand,
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: Get.height * 0.65,
                color: Colors.black,
                alignment: Alignment.center,
                child: Image.asset("assets/images/3.jpg", fit: BoxFit.cover),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: Get.width * 0.15),
                  width: Get.width * 0.65,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(5, 5),
                        color: Colors.blue[50],
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {
                      Get.find<ShopController>().fetchProductAll();
                      Get.toNamed(Routes.SHOP);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cửa hàng",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Icon(Icons.arrow_forward, color: Colors.black),
                      ],
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0.2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Stack(
            fit: StackFit.expand,
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: Get.height * 0.65,
                color: Colors.black,
                alignment: Alignment.center,
                child: Image.asset("assets/images/2.jpg", fit: BoxFit.cover),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: Get.width * 0.15),
                  width: Get.width * 0.65,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(5, 5),
                        color: Colors.blue[50],
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {
                      Get.find<ShopController>().fetchProductAll();
                      Get.toNamed(Routes.SHOP);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cửa hàng",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Icon(Icons.arrow_forward, color: Colors.black),
                      ],
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0.2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: Get.height * 0.65,
          color: Colors.black,
          alignment: Alignment.center,
          child: AspectRatio(
            aspectRatio: 0.65,
            child: VideoPlayer(homeController.videoPlayerController),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: Get.width * 0.15),
            width: Get.width * 0.65,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(5, 5),
                  color: Colors.blue[50],
                ),
              ],
            ),
            child: TextButton(
              onPressed: () {
                Get.find<ShopController>().fetchProductAll();
                Get.toNamed(Routes.SHOP);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Cửa hàng",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Icon(Icons.arrow_forward, color: Colors.black),
                ],
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 0.2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
