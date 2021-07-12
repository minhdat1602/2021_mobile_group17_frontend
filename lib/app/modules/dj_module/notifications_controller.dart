import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/guest_shop_module/shop_controller.dart';
import 'package:mobile_nhom17_2021/app/routes/app_pages.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationController extends GetxController {
  FlutterLocalNotificationsPlugin localNotification;

  @override
  void onInit() {
    super.onInit();
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("Asia/Ho_Chi_Minh"));

    //setting android
    var androidInitiallize =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        new InitializationSettings(android: androidInitiallize);

    // intanciate local notification
    localNotification = new FlutterLocalNotificationsPlugin();
    localNotification.initialize(initializationSettings);

    // Cloud Messaging Firebase initialization
    /// Gives you the messasge on which user taps
    /// and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("listen:1");
      if (message != null) {
        // final routeFromMessage = message.data['route'];
        // print(routeFromMessage);
        Get.find<ShopController>().fetchProductAll();
        Get.toNamed(Routes.USER_SHOP);
      }
    });

    // Foreground work
    FirebaseMessaging.onMessage.listen((message) {
      print("listen:2");
      if (message.notification != null) {
        showNotification(message);
      }
    });

    /// When the app is in background but opened and user taps
    /// on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("listen:3");
      // final routeFromMessage = message.data['route'];
      Get.find<ShopController>().fetchProductAll();
      Get.toNamed(Routes.USER_SHOP);
      // print(routeFromMessage);
    });
  }

  Future showNotification(RemoteMessage remoteMessage) async {
    var androidDetails = new AndroidNotificationDetails(
      "channelId",
      "local Notification",
      "This is the notification",
    );
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails);

    print(DateTime.now().microsecondsSinceEpoch ~/ 100000);

    await localNotification.show(
      DateTime.now().millisecondsSinceEpoch ~/ 100000,
      "${remoteMessage.notification.title}",
      "${remoteMessage.notification.body}",
      generalNotificationDetails,
    );
  }

  void scheduleAlarm() async {
    var androidDetails = new AndroidNotificationDetails(
      "channelId",
      "local Notification",
      "This is the notification",
    );
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails);
    await localNotification.zonedSchedule(
      0,
      "Notif title",
      "The Body of notification",
      tz.TZDateTime.from(DateTime.now().add(Duration(seconds: 3)),
          tz.getLocation("Asia/Ho_Chi_Minh")),
      generalNotificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }
}
