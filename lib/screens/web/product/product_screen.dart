import 'package:flutter/material.dart';
import 'package:mobile_nhom17_2021/config/styles.dart';
import 'package:mobile_nhom17_2021/models/product.dart';
import 'package:mobile_nhom17_2021/screens/web/product/widgets/delivery_widget.dart';
import 'package:mobile_nhom17_2021/screens/web/product/widgets/description_widget.dart';
import 'package:mobile_nhom17_2021/screens/web/product/widgets/overview_widget.dart';
import 'package:mobile_nhom17_2021/screens/web/product/widgets/returns_widget.dart';
import 'package:mobile_nhom17_2021/screens/web/product/widgets/size_guide_widget.dart';
import 'package:mobile_nhom17_2021/screens/web/product_size_screen.dart';
import 'package:mobile_nhom17_2021/widgets/appbar.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  ProductDetailScreen({Key key, this.product}) : super(key: key);
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _bodyWidget = [
      OverviewWidget(product: widget.product),
      DescriptionWidget(
        product: widget.product,
      ),
      SizeGuideWidget(),
      DeliveryWidget(),
      ReturnsWidget(),
    ];
    return Scaffold(
      appBar: AppBarWidget(title: "Sản phẩm"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProductSizeScreen()));
        },
        child: Icon(Icons.add_shopping_cart_sharp),
        backgroundColor: Styles.secondaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DefaultTabController(
              length: 5,
              child: PreferredSize(
                preferredSize: Size.fromHeight(30.0),
                child: Material(
                  color: Colors.black,
                  child: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.white.withOpacity(0.3),
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(
                        child:
                            Text("Tổng quan", style: TextStyle(fontSize: 16)),
                      ),
                      Tab(child: Text("Mô tả", style: TextStyle(fontSize: 16))),
                      Tab(
                          child: Text("Chọn kích cỡ",
                              style: TextStyle(fontSize: 16))),
                      Tab(
                          child: Text("Vận chuyển",
                              style: TextStyle(fontSize: 16))),
                      Tab(
                          child:
                              Text("Đổi trả", style: TextStyle(fontSize: 16))),
                    ],
                    onTap: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
              ),
            ),
            _bodyWidget[_currentIndex],
          ],
        ),
      ),
    );
  }
}
