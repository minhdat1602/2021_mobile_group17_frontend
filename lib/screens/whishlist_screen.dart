import 'package:flutter/material.dart';
import 'package:mobile_nhom17_2021/widgets/widgets.dart';

class WhishlistScreen extends StatefulWidget {
  @override
  _WhishlistScreenState createState() => _WhishlistScreenState();
}

class _WhishlistScreenState extends State<WhishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Danh sách yêu thích"),
      floatingActionButton: _buildAddWhishlishBtn(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey,
            )
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Danh sách yêu thích",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "0 sản phẩm",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue[900],
                ),
              ),
            ],
          ),
        ),
      ),
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
