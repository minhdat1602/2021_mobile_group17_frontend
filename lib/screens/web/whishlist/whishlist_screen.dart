import 'package:flutter/material.dart';
import 'package:mobile_nhom17_2021/screens/web/whishlist/component/body.dart';
import 'package:mobile_nhom17_2021/widgets/widgets.dart';

class WhishlistScreen extends StatefulWidget {
  static String routeName = "/whishlist";
  @override
  _WhishlistScreenState createState() => _WhishlistScreenState();
}

class _WhishlistScreenState extends State<WhishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Danh sách yêu thích"),
      floatingActionButton: _buildAddWhishlishBtn(),
      body: Body(),
    );
  }

  FloatingActionButton _buildAddWhishlishBtn() {
    return FloatingActionButton(
      onPressed: () {},
      child: Icon(Icons.add),
      backgroundColor: Colors.grey,
    );
  }
}
