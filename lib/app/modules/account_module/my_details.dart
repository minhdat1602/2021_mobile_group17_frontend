import 'package:flutter/material.dart';
import 'package:mobile_nhom17_2021/app/data/models/user.dart';

class MyDetailsScreen extends StatefulWidget {
  static String routeName = "/my-detail";
  final User user;
  const MyDetailsScreen({Key key, this.user}) : super(key: key);

  @override
  _MyDetailsScreenState createState() => _MyDetailsScreenState();
}

class _MyDetailsScreenState extends State<MyDetailsScreen> {
  String _lastName, _firstName, _phone, _sonha, _xa, _huyen, _tinh;
  final _myDetailsForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark, // Màu icon giờ pin trên status bar
        title: Text(
          "Thay đổi thông tin",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [],
      ),
      body: SafeArea(
        child: Form(
          key: _myDetailsForm,
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 1,
                  color: Colors.grey[300],
                )
              ],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text("Thông tin chi tiết", style: Styles.headingStyle),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: _buildFirstNameTf(),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: _buildLastNameTf(),
                      ),
                    ),
                  ],
                ),
                _buildPhoneTf(),
                _buildSoNhaTf(),
                _buildXaTf(),
                _buildHuyenTf(),
                _buildTinhTf(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _myDetailsForm.currentState.save();
                        if (_myDetailsForm.currentState.validate()) {
                          widget.user.userInfo.firstName = _firstName;
                          widget.user.userInfo.lastName = _lastName;
                          widget.user.userInfo.phone = _phone;
                          widget.user.userInfo.sonha = _sonha;
                          widget.user.userInfo.xa = _xa;
                          widget.user.userInfo.huyen = _huyen;
                          widget.user.userInfo.tinh = _tinh;
                          // updateUserInfo(widget.user.userInfo).then(
                          //   (value) => {
                          //     Navigator.pop(context),
                          //   },
                          // );
                        }
                      },
                      child: Text(
                        "Cập nhật",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo[400],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildLastNameTf() {
    return TextFormField(
      onSaved: (value) => _lastName = value,
      // cursorColor: Styles.secondaryColor,
      initialValue: widget.user.userInfo.lastName,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            // borderSide: BorderSide(color: Styles.secondaryColor, width: 2.5),
            ),
        labelText: "Tên",
        // labelStyle: TextStyle(color: Styles.secondaryColor),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Vui lòng nhập tên";
        } else {
          return null;
        }
      },
    );
  }

  TextFormField _buildFirstNameTf() {
    return TextFormField(
      onSaved: (value) => _firstName = value,
      initialValue: widget.user.userInfo.firstName,
      // cursorColor: Styles.secondaryColor,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            // borderSide: BorderSide(color: Styles.secondaryColor, width: 2.5),
            ),
        labelText: "Họ",
        // labelStyle: TextStyle(color: Styles.secondaryColor),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Vui lòng nhập họ";
        } else {
          return null;
        }
      },
    );
  }

  TextFormField _buildSoNhaTf() {
    return TextFormField(
      onSaved: (value) => _sonha = value,
      // cursorColor: Styles.secondaryColor,
      initialValue: widget.user.userInfo.sonha,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            // borderSide: BorderSide(color: Styles.secondaryColor, width: 2.5),
            ),
        labelText: "Số nhà/Tên đường",
        // labelStyle: TextStyle(color: Styles.secondaryColor),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Vui lòng nhập số nhà/tên đường";
        } else {
          return null;
        }
      },
    );
  }

  TextFormField _buildXaTf() {
    return TextFormField(
      onSaved: (value) => _xa = value,
      // cursorColor: Styles.secondaryColor,
      initialValue: widget.user.userInfo.xa,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            // borderSide: BorderSide(color: Styles.secondaryColor, width: 2.5),
            ),
        labelText: "Xã/Phường",
        // labelStyle: TextStyle(color: Styles.secondaryColor),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Vui lòng nhập xã/phường";
        } else {
          return null;
        }
      },
    );
  }

  TextFormField _buildHuyenTf() {
    return TextFormField(
      onSaved: (value) => _huyen = value,
      // cursorColor: Styles.secondaryColor,
      initialValue: widget.user.userInfo.huyen,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            // borderSide: BorderSide(color: Styles.secondaryColor, width: 2.5),
            ),
        labelText: "Quận/Huyện",
        // labelStyle: TextStyle(color: Styles.secondaryColor),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Vui lòng nhập huyện/quận";
        } else {
          return null;
        }
      },
    );
  }

  TextFormField _buildTinhTf() {
    return TextFormField(
      onSaved: (value) => _tinh = value,
      // cursorColor: Styles.secondaryColor,
      initialValue: widget.user.userInfo.tinh,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            // borderSide: BorderSide(color: Styles.secondaryColor, width: 2.5),
            ),
        labelText: "Tỉnh/Thành phố",
        // labelStyle: TextStyle(color: Styles.secondaryColor),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Vui lòng nhập tỉnh/thành phố";
        } else {
          return null;
        }
      },
    );
  }

  TextFormField _buildPhoneTf() {
    return TextFormField(
      onSaved: (value) => _phone = value,
      // cursorColor: Styles.secondaryColor,
      initialValue: widget.user.userInfo.phone,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            // borderSide: BorderSide(color: Styles.secondaryColor, width: 2.5),
            ),
        labelText: "Số điện thoại",
        // labelStyle: TextStyle(color: Styles.secondaryColor),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Nhập số điện thoại";
        } else {
          return null;
        }
      },
    );
  }
}
