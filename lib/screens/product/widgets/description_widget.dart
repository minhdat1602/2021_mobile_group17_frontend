import 'package:flutter/material.dart';
import 'package:mobile_nhom17_2021/models/product.dart';
import 'package:mobile_nhom17_2021/utils/PriceUtil.dart';

class DescriptionWidget extends StatelessWidget {
  final Product product;
  DescriptionWidget({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
              fontFamily: "Karla",
            ),
          ),
          SizedBox(height: 10),
          _buildProductPrice(product),
          SizedBox(height: 15),
          Text(
            product.description == null ? "" : product.description,
            style: TextStyle(
              fontSize: 16,
              fontFamily: "Karla",
            ),
          ),
          SizedBox(height: 15),
          Text(
            "Chất liệu",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          Text(
            product.material == null ? "" : product.material,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 15),
          Text(
            "Màu sắc:",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          Text(
            product.colour == null ? "" : product.colour,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 20),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Mã sản phẩm: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                TextSpan(
                  text: product.code == null ? "" : product.code,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
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
}
