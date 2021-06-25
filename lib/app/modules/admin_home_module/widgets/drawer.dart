import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/routes/app_pages.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF212332),
        child: Theme(
          data: ThemeData(
            accentColor: Colors.white,
            unselectedWidgetColor: Colors.white60,
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
              ListTile(
                title: Text(
                  "Trang chủ Admin",
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 20,
                  ),
                ),
                leading: Icon(
                  Icons.home_outlined,
                  color: Colors.white60,
                  size: 20 * 1.6,
                ),
                onTap: () {},
                hoverColor: Colors.white60,
              ),
              BuildItems(
                title: "Quản lý danh mục",
                icon: Icons.category_outlined,
                children: [
                  BuildItems(
                    title: "Loại danh mục",
                    icon: Icons.arrow_right_alt,
                    size: 16,
                    children: [
                      BuildItem(
                        title: "Loại sản phẩm",
                        icon: Icons.arrow_right_alt,
                        callback: () {},
                      ),
                    ],
                  ),
                  BuildItem(
                    title: "Danh sách sản phẩm",
                    icon: Icons.arrow_right_alt,
                    callback: () {
                      Get.offNamed(Routes.ADMIN_LIST_PRODUCT);
                    },
                  ),
                ],
              ),
              BuildItems(
                title: "Giao dịch",
                icon: Icons.category_outlined,
                children: [
                  BuildItem(
                    title: "Đơn hàng",
                    icon: Icons.arrow_right_alt,
                    callback: () {
                      Get.offNamed(Routes.ADMIN_LIST_ORDER);
                    },
                  ),
                  BuildItem(
                    title: "Báo cáo",
                    icon: Icons.arrow_right_alt,
                    callback: () {
                      Get.offNamed(Routes.ADMIN_LIST_PRODUCT);
                    },
                  ),
                  BuildItem(
                    title: "Nhập hàng",
                    icon: Icons.arrow_right_alt,
                    callback: () {
                      Get.offNamed(Routes.ADMIN_LIST_PRODUCT);
                    },
                  ),
                  BuildItem(
                    title: "Đối tác",
                    icon: Icons.arrow_right_alt,
                    callback: () {
                      Get.offNamed(Routes.ADMIN_LIST_PRODUCT);
                    },
                  ),
                ],
              ),
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
                    color: Colors.white60,
                    fontSize: 20,
                  ),
                ),
                leading: Icon(
                  Icons.stacked_line_chart_sharp,
                  color: Colors.white60,
                  size: 20 * 1.6,
                ),
                onTap: () {},
                hoverColor: Colors.white60,
              ),
              ListTile(
                title: Text(
                  "Email",
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 20,
                  ),
                ),
                leading: Icon(
                  Icons.email_outlined,
                  color: Colors.white60,
                  size: 20 * 1.6,
                ),
                onTap: () {},
                hoverColor: Colors.white60,
              ),
              ListTile(
                title: Text(
                  "Thông báo",
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 20,
                  ),
                ),
                leading: Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.white60,
                  size: 20 * 1.6,
                ),
                onTap: () {},
                hoverColor: Colors.white60,
              ),
              ListTile(
                title: Text(
                  "Cài đặt  ",
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 20,
                  ),
                ),
                leading: Icon(
                  Icons.settings_outlined,
                  color: Colors.white60,
                  size: 20 * 1.6,
                ),
                onTap: () {},
                hoverColor: Colors.white60,
              ),
            ],
          ),
        ),
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
          color: Colors.white60,
          fontSize: size == null ? 20 : size,
        ),
      ),
      leading: Icon(
        icon,
        color: Colors.white60,
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
          color: Colors.white60,
          fontSize: size == null ? 16 : size,
        ),
      ),
      leading: Icon(
        icon,
        color: Colors.white60,
        size: size == null ? 16 * 1.8 : size * 1.8,
      ),
      onTap: callback,
      hoverColor: Colors.white60,
    );
  }
}
