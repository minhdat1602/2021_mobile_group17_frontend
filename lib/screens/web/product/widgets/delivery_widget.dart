import 'package:flutter/material.dart';

class DeliveryWidget extends StatelessWidget {
  DeliveryWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Giao hàng quốc tế: Chúng tôi giao hàng đến hơn 175 quốc gia.",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.6,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Truy cập trang giao hàng của chúng tôi để biết thêm thông tin về giao hàng tại Việt Nam và Quốc tế.",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.6,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
