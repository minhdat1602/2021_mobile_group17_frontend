import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/modules/auth_user_module/auth_controller.dart';
import 'package:mobile_nhom17_2021/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminDrawer extends StatelessWidget {
  AuthController authController = Get.find();
  // const DrawerWidget({
  //   Key key,
  // }) : super(key: key);

  // url launcher
  final _url =
      'https://console.firebase.google.com/u/0/project/pushmessage-4f5c5/notification';
  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xff11101d),
        child: Theme(
          data: ThemeData(
            accentColor: Colors.white,
            unselectedWidgetColor: Colors.white,
          ),
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Text(
                    "DJ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              _buildDashboard(),
              _buildCatagories(),
              _buildOrders(),
              BuildItems(
                title: "Quản lý giao diện",
                icon: Icons.important_devices_sharp,
                children: [],
              ),
              BuildItems(
                title: "Quản lý user",
                icon: Icons.person_outline,
                children: [],
              ),
              ListTile(
                title: Text(
                  "Báo cáo",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                leading: Icon(
                  Icons.stacked_line_chart_sharp,
                  color: Colors.white,
                  size: 20 * 1.6,
                ),
                onTap: () {},
                hoverColor: Colors.white,
              ),
              ListTile(
                title: Text(
                  "Email",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                leading: Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                  size: 20 * 1.6,
                ),
                onTap: () {},
                hoverColor: Colors.white,
              ),
              ListTile(
                title: Text(
                  "Thông báo",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                leading: Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.white,
                  size: 20 * 1.6,
                ),
                onTap: () {
                  // _launchURL();
                  Get.toNamed(Routes.ADMIN_NOTIFICATION);
                },
                hoverColor: Colors.white,
              ),
              ListTile(
                title: Text(
                  "Cài đặt  ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                leading: Icon(
                  Icons.settings_outlined,
                  color: Colors.white,
                  size: 20 * 1.6,
                ),
                onTap: () {},
                hoverColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildOrders() {
    return Container(
      color: Get.currentRoute == Routes.ADMIN_LIST_ORDER
          ? Colors.white
          : Colors.transparent,
      child: ListTile(
        title: Text(
          "Đơn hàng",
          style: TextStyle(
            color: Get.currentRoute == Routes.ADMIN_LIST_ORDER
                ? Colors.black
                : Colors.white,
            fontSize: 20,
          ),
        ),
        leading: Icon(
          Icons.assignment_sharp,
          color: Get.currentRoute == Routes.ADMIN_LIST_ORDER
              ? Colors.black
              : Colors.white,
          size: 20 * 1.6,
        ),
        onTap: () {
          Get.toNamed(Routes.ADMIN_LIST_ORDER);
        },
        hoverColor: Colors.white,
      ),
    );
  }

  ExpansionTile _buildCatagories() {
    return ExpansionTile(
      title: Text(
        "Danh mục",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      leading: Icon(
        Icons.category,
        color: Colors.white,
        size: 20 * 1.6,
      ),
      backgroundColor: Color(0xFF2A2D3E),
      childrenPadding: EdgeInsets.only(left: 16),
      children: [
        ListTile(
          title: Text(
            "Sản phẩm",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          leading: Icon(
            Icons.production_quantity_limits,
            color: Colors.white,
            size: 16 * 1.6,
          ),
          onTap: () {},
        ),
        ListTile(
          title: Text(
            "Thương hiệu",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          leading: Icon(
            Icons.branding_watermark,
            color: Colors.white,
            size: 16 * 1.6,
          ),
          onTap: () {},
        )
      ],
    );
  }

  Container _buildDashboard() {
    return Container(
      color: Get.currentRoute == Routes.ADMIN_DASHBOARD
          ? Colors.white
          : Colors.transparent,
      child: ListTile(
        title: Text(
          "Dashboard",
          style: TextStyle(
            color: Get.currentRoute == Routes.ADMIN_DASHBOARD
                ? Colors.black
                : Colors.white,
            fontSize: 20,
          ),
        ),
        leading: Icon(
          Icons.dashboard,
          color: Get.currentRoute == Routes.ADMIN_DASHBOARD
              ? Colors.black
              : Colors.white,
          size: 20 * 1.6,
        ),
        onTap: () {
          if (authController.user.id > 0) {
            if (authController.isPermission("ADMIN") ||
                authController.isPermission("DASHBOARD")) {
              Get.offNamed(Routes.ADMIN_DASHBOARD);
            } else {
              Get.dialog(
                  AlertDialog(
                    title: Text("Quyền truy cập"),
                    content: Text("Bạn không có quyền truy cập nội dung này !"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          if (Get.isDialogOpen) Get.back();
                        },
                        child: Text("OK"),
                      )
                    ],
                  ),
                  barrierDismissible: false);
            }
          }
        },
      ),
    );
  }
}

class BuildItems extends StatelessWidget {
  final String title;
  final IconData icon;
  final double size;
  final List<Widget> children;
  const BuildItems({Key key, this.title, this.icon, this.children, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: size == null ? 20 : size,
        ),
      ),
      leading: Icon(
        icon,
        color: Colors.white,
        size: size == null ? 20 * 1.6 : size * 1.6,
      ),
      backgroundColor: Color(0xFF2A2D3E),
      childrenPadding: EdgeInsets.only(left: 16),
      children: children,
    );
  }
}

class BuildItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final double size;
  final Function callback;
  const BuildItem({Key key, this.title, this.icon, this.callback, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: size == null ? 16 : size,
        ),
      ),
      leading: Icon(
        icon,
        color: Colors.white,
        size: size == null ? 16 * 1.8 : size * 1.8,
      ),
      onTap: callback,
      hoverColor: Colors.white,
    );
  }
}
