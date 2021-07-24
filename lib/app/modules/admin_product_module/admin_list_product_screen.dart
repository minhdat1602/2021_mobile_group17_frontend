import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:mobile_nhom17_2021/app/core/utils/price_toVnd.dart';
import 'package:mobile_nhom17_2021/app/core/utils/utils.dart';
import 'package:mobile_nhom17_2021/app/data/models/cart.dart';
import 'package:mobile_nhom17_2021/app/data/models/product.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_dashboard_module/widgets/admin_appbar.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_dashboard_module/widgets/admin_menu_drawer.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_product_module/admin_list_product_controller.dart';
import 'package:mobile_nhom17_2021/app/modules/auth_user_module/auth_controller.dart';

class AdminListProductScreen extends StatelessWidget {
  var x = Get.put(AuthController());
  AdminListProductController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(),
      drawer: AdminDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "Thêm sản phẩm",
        onPressed: () {},
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.symmetric(vertical: 16),
        color: Color(0xff11101d),
        child: Obx(() => FutureBuilder<List<Product>>(
              future: controller.products,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) =>
                        _buildItem(snapshot.data[index]),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("ERROR"));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )),
      ),
    );
  }

  Slidable _buildItem(Product product) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.2,
      secondaryActions: [
        IconSlideAction(
          caption: 'Nhập hàng',
          color: Colors.indigo,
          icon: Icons.input,
          onTap: () {},
        ),
        IconSlideAction(
          caption: 'Chi tiết',
          color: Colors.redAccent,
          icon: Icons.more,
          onTap: () {},
        ),
        IconSlideAction(
          caption: 'Xóa',
          color: Colors.blue,
          icon: Icons.delete,
          onTap: () {},
        ),
      ],
      child: Container(
        width: Get.width,
        height: 100,
        padding: EdgeInsets.only(bottom: 5, top: 5, right: 10, left: 3),
        decoration: BoxDecoration(
            color: Colors.white, border: Border.all(color: Colors.grey[300])),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                "${ProjectUtil.getDisplay(product)}",
                height: 100.0,
                width: 120.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 7),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "${product.name}",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "SKU: ${product.code}",
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                ),
                Text(
                  "Giá: ${PriceUtil.toCurrency(product.price)} đ",
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                ),
                Text(
                  "Tồn kho: ${ProjectUtil.getStock(product)}",
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                      "${product.active == 1 ? 'Đang bán' : 'Ngừng bán'}",
                      style: TextStyle(color: Colors.black45))),
            ),
          ],
        ),
      ),
    );
  }
}
