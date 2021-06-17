import 'package:flutter/material.dart';

class ReturnsWidget extends StatelessWidget {
  ReturnsWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chính sách đổi trả:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Vui lòng trả lại hàng hóa không mong muốn của bạn cho chúng tôi trong vòng 14 ngày. Nếu bạn muốn trao đổi, hãy gửi lại cho chúng tôi sau 28 ngày. Các mục cá nhân hóa sẽ không được chấp nhận trừ khi văn bản cá nhân hóa không chính xác nếu mục đó bị lỗi.",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Đăng ký trả hàng tại đường liên kết bên dưới.",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "https://www.facebook.com/profile.php?id=100046653096864",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "xin lưu ý rằng bạn mở rộng chính sách trả hàng cho Giáng sinh trên liên kết sau: https://www.facebook.com/profile.php?id=100046653096864",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
