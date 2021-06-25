import 'package:flutter/material.dart';

class ConnectivityScreen extends StatelessWidget {
  const ConnectivityScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off,
              size: 100,
            ),
            Text(
              "Không có kết nối mạng !",
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
              ),
            )
          ],
        ),
      ),
    );
  }
}
