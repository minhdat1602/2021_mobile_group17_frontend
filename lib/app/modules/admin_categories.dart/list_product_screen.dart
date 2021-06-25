import 'package:flutter/material.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_home_module/widgets/appbar.dart';
import 'package:mobile_nhom17_2021/app/modules/admin_home_module/widgets/drawer.dart';

class ListProductScreen extends StatefulWidget {
  static String routeName = "/admin/list-product";
  const ListProductScreen({Key key}) : super(key: key);

  @override
  _ListProductScreenState createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  String filter = "Tất cả sản phẩm";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(),
      drawer: DrawerWidget(),
      backgroundColor: Color(0xFF2A2D3E),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: buildHead(),
          ),
          Container(
            height: 120,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
            ),
            child: Row(
              children: [
                Center(
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: Image(
                      image: NetworkImage(
                          "https://assets.adidas.com/images/w_276,h_276,f_auto,q_auto:sensitive,fl_lossy/b3646fca76a44decb317acee00db5373_9366/ZX_2K_Boost_2.0_Shoes_White_GZ7824_01_standard.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Ultra boot N.A 1.0",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Code: SP0001",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "2,000,000 đ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "150",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row tbHead() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Mã",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Tên",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Giá",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Trạng thái",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Row buildHead() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DropdownButton<String>(
          hint: Text(
            filter,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          underline: Container(width: 0, height: 0),
          items: <String>[
            'Tất cả sản phẩm',
            'Sản phẩm mới',
            'Sản phẩm hot',
            'Sản phẩm nổi bật'
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
              onTap: () => setState(() {
                filter = value;
              }),
            );
          }).toList(),
          onChanged: (value) {
            print(value);
          },
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(Icons.add),
          label: Text("Thêm sản phẩm"),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
        ),
      ],
    );
  }
}
