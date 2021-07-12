import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/routes/app_pages.dart';

class ConnectivityController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  var isOnline = RxnBool();

  @override
  void onInit() {
    super.onInit();

    initConnectivity();

    _connectivity.onConnectivityChanged.listen((result) async {
      if (result == ConnectivityResult.none) {
        isOnline.value = false;
        print("false");
        Get.offNamed(Routes.CONNECTIVITY);
      } else {
        await _updateConnectionStatus().then((bool isConnected) {
          isOnline.value = isConnected;
          print("true");
          print(Get.previousRoute);
          Get.offNamed(Routes.INITIAL);
        });
      }
    });
  }

  Future<void> initConnectivity() async {
    try {
      var status = await _connectivity.checkConnectivity();
      if (status == ConnectivityResult.none) {
        isOnline.value = false;
        Get.offNamed(Routes.CONNECTIVITY);
      } else {
        isOnline.value = true;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> _updateConnectionStatus() async {
    bool isConnected;
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup("google.com");
      if (result.isEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } catch (e) {
      isConnected = false;
    }
    return isConnected;
  }
}
