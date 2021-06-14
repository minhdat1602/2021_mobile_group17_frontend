import 'package:flutter/material.dart';
import 'package:mobile_nhom17_2021/config/styles.dart';
import 'package:mobile_nhom17_2021/models/product.dart';
import 'package:mobile_nhom17_2021/utils/PriceUtil.dart';

class ProductSizeScreen extends StatefulWidget {
  Product product;
  ProductSizeScreen({Key key, this.product}) : super(key: key);
  @override
  _ProductSizeScreenState createState() => _ProductSizeScreenState();
}

class _ProductSizeScreenState extends State<ProductSizeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Styles.secondaryColor,
        child: Icon(Icons.close_rounded),
        elevation: 0,
      ),
      body: Container(
        color: Styles.secondaryColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "THÊM VÀO GIỎ HÀNG",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 15),
            Text(
              widget.product.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 15),
            Text(
              PriceUtil.toCurrency(widget.product.price),
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Chọn kích thước:",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 15),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Styles.secondaryColor,
              height: 200,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.zero,
              child: GridView.builder(
                  padding: EdgeInsets.zero,
                  // itemCount: widget.product.stocks.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) => Text("s")),
              // _buildSizeItem(widget.product.stocks[index].size)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeItem(String size) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextButton(
        onPressed: () {},
        child: Text(
          size,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        style: TextButton.styleFrom(
            backgroundColor: Styles.secondaryColor,
            side: BorderSide(
              width: 1,
              color: Colors.white,
            )),
      ),
    );
  }
}
