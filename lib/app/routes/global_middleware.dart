import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/auth_user_module/auth_controller.dart';

import 'app_pages.dart';

class GlobalMiddleWare extends GetMiddleware {
  // var authController;
  final authController = Get.put(AuthController());

  @override
  RouteSettings redirect(String route) {
    if (authController.user.id == 0) {
      return null;
    } else {
      List<String> role = authController.user.role;
      if (role == null || role.isEmpty) {
        return null;
      } else {
        for (String r in role) {
          print("ROLE: $r");
          switch (r) {
            case "ADMIN":
              return RouteSettings(name: Routes.ADMIN_DASHBOARD);
              break;
            case "DASHBOARD":
              return RouteSettings(name: Routes.ADMIN_DASHBOARD);
              break;
            case "ORDER":
              return RouteSettings(name: Routes.ADMIN_LIST_ORDER);
              break;
            case "PRODUCT":
              return RouteSettings(name: Routes.ADMIN_LIST_PRODUCT);
              break;
            // case "CONFIG":
            //   return RouteSettings(name: Routes.ADMIN_LIST_USER);
            default:
              return null;
          }
        }
      }
    }
    // print("MIDDLEWAREEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE!!!!!!!!!!!!");
    // return authController.user.id == 0
    // ? null
    // : RouteSettings(name: Routes.ADMIN_HOME);
  }

  @override
  GetPage onPageCalled(GetPage page) {
    print('>>> Page ${page.name} called');
    return page;
    // print('>>> Page ${page.name} called');
    // print('>>> User ${authController.user.lastName} logged');
    // return authController.user.lastName != null
    //     ? page.copyWith(arguments: {'user': authController.user.lastName})
    //     : page;
  }

  @override
  GetPageBuilder onPageBuildStart(GetPageBuilder page) {
    print('Bindings of ${page.toString()} are ready');
    return page;
  }

  @override
  Widget onPageBuilt(Widget page) {
    print('Widget ${page.toStringShort()} will be showed');
    return page;
  }

  @override
  void onPageDispose() {
    print('PageDisposed');
  }
}
