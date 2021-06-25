import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF212332),
      ),
      body: WebView(
        initialUrl:
            'https://console.firebase.google.com/u/1/project/mobile-3cef0/notification',
        javascriptMode: JavascriptMode.unrestricted,
        onProgress: (int progress) {
          print("WebView is loading (progress : $progress%)");
        },
        gestureNavigationEnabled: true,
      ),
    );
  }
}
