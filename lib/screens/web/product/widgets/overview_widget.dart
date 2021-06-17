import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:mobile_nhom17_2021/models/product.dart';
import 'package:mobile_nhom17_2021/utils/price_toVnd.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        "${PriceUtil.toCurrency(product.price)} VNĐ",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
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
            ),
          ),
          SizedBox(width: 10),
          Text(
            "${PriceUtil.toCurrency(product.price - product.discount)} VNĐ",
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
            "Mô tả",
            style: TextStyle(
              fontSize: 16.0,
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
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "ĐỌC THÊM",
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
              "Sản phẩm đã xem",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
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
      child: FutureBuilder(
        future: getRecentlyViewed(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    _buildRecentlyViewedItem(snapshot.data[index]));
            // itemBuilder: (context, index) => Container(
            //       child: Text("$index"),
            //       width: 100,
            //       height: 100,
            //     ));
          } else {
            return Text("Nothing");
          }
        },
      ),
    );
  }

  Padding _buildRecentlyViewedItem(Product product) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Material(
        color: Colors.grey[800],
        child: InkWell(
          onTap: () {}, // needed
          child: Ink.image(
            width: 150,
            height: 120,
            image: NetworkImage(_getDisplay(product)),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Future<List<Product>> getRecentlyViewed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> recentlyViewedStrs = prefs.getStringList("recentlyViewed");
    List<Product> products = [];
    for (int i = 0; i < recentlyViewedStrs.length; i++) {
      products.add(Product.fromJson(json.decode(recentlyViewedStrs[i])));
    }
    // recentlyViewedStrs.map((recentlyViewedStr) => {
    //       products.add(Product.fromJson(json.decode(recentlyViewedStr))),
    //     });

    print("product length:${products.length}");
    print("recentlyViewedStrs length:${recentlyViewedStrs.length}");

    return products;
  }

  String _getDisplay(Product product) {
    for (int i = 0; i < product.images.length; i++) {
      if (product.images[i].display == 1) return product.images[i].url;
    }
    return null;
  }
}
