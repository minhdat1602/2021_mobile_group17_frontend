import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/core/utils/utils.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_shop_module/shop_controller.dart';
import 'package:mobile_nhom17_2021/app/core/utils/price_toVnd.dart';
import 'package:mobile_nhom17_2021/app/data/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../product_controller.dart';

class OverviewWidget extends StatefulWidget {
  final Product product;
  OverviewWidget({Key key, this.product}) : super(key: key);
  @override
  _OverviewWidgetState createState() => _OverviewWidgetState();
}

class _OverviewWidgetState extends State<OverviewWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 250,
            child: Carousel(
              dotSize: 5.0,
              dotSpacing: 15.0,
              dotColor: Colors.black,
              indicatorBgPadding: 10,
              dotBgColor: Colors.transparent,
              images: List.generate(
                widget.product.images.length,
                (index) => Image.network(
                  widget.product.images[index].url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 1,
                  color: Colors.grey,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10.0),
                _buildProductPrice(widget.product),
              ],
            ),
          ),
          _buildDescription(),
          _buildRecentlyViewed(),
        ],
      ),
    );
  }

  Widget _buildProductPrice(Product product) {
    if (product.discount <= 0) {
      return Text(
        "${PriceUtil.toCurrency(product.price)} ??",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      );
    } else {
      return Row(
        children: [
          Text(
            "${PriceUtil.toCurrency(product.price)}",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.lineThrough,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 10),
          Text(
            "${PriceUtil.toCurrency(product.price - product.discount)} ??",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.red,
            ),
          ),
        ],
      );
    }
  }

  Container _buildDescription() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(15.0),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            color: Colors.grey,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "M?? t???",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            widget.product.description == null
                ? ""
                : widget.product.description,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
              letterSpacing: 1.1,
              height: 1.5,
              color: Colors.black,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "?????C TH??M",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.indigo[800],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildRecentlyViewed() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            color: Colors.grey,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "S???n ph???m ???? xem",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 15.0),
          _buildRecentlyViewedItems(),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }

  Widget _buildRecentlyViewedItems() {
    return Expanded(
      child: ListView.builder(
        controller: Get.find<ProductController>().scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: Get.find<ProductController>().recentlyViews.length - 1,
        shrinkWrap: true,
        itemBuilder: (context, index) => _buildRecentlyViewedItem(
            Get.find<ProductController>().recentlyViews[index]),
      ),
    );
  }

  Padding _buildRecentlyViewedItem(Product product) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Material(
        color: Colors.grey[800],
        child: InkWell(
          onTap: () {
            // Get.find<ProductController>().product = product;
          }, // needed
          child: Ink.image(
            width: 150,
            height: 120,
            image: NetworkImage(ProjectUtil.getDisplay(product)),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  // Future<List<Product>> getRecentlyViewed() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String> recentlyViewedStrs = prefs.getStringList("recentlyViewed");
  //   List<Product> products = [];
  //   for (int i = 0; i < recentlyViewedStrs.length; i++) {
  //     products.add(Product.fromJson(json.decode(recentlyViewedStrs[i])));
  //   }
  //   recentlyViewedStrs.map((recentlyViewedStr) => {
  //         products.add(Product.fromJson(json.decode(recentlyViewedStr))),
  //       });

  //   print("product length:${products.length}");
  //   print("recentlyViewedStrs length:${recentlyViewedStrs.length}");

  //   return products;
  // }

}
