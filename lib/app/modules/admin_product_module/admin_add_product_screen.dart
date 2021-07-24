import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class AdminAddProductScreen extends StatefulWidget {
  const AdminAddProductScreen({Key key}) : super(key: key);

  @override
  _AdminAddProductScreenState createState() => _AdminAddProductScreenState();
}

class _AdminAddProductScreenState extends State<AdminAddProductScreen> {
  final GlobalKey _addProductForm = GlobalKey<FormState>();
  HtmlEditorController htmlController = HtmlEditorController();
  var colours = ['Đen', 'Trắng', 'Đỏ', 'Xanh', 'Vàng', 'Cam'];
  var types = ['Nam', 'Nữ', 'Trẻ em'];
  var isTypes = [false, false, false];
  var _currencies = [
    "Food",
    "Transport",
    "Personal",
    "Shopping",
    "Medical",
    "Rent",
    "Movie",
    "Salary"
  ];
  // var _category;
  bool _isChecked = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Thêm sản phẩm", style: TextStyle(color: Colors.white)),
          centerTitle: false,
        ),
        body: DirectSelectContainer(
          child: Container(
            width: Get.width,
            height: Get.height,
            // color: Colors.black,
            padding: EdgeInsets.all(16),
            child: Form(
                key: _addProductForm,
                child: ListView(
                  children: [
                    _buildProductName(),
                    SizedBox(height: 10),
                    _buildProductCode(),
                    SizedBox(height: 10),
                    _buildPrice(),
                    SizedBox(height: 10),
                    _buildColour(),
                    SizedBox(height: 10),
                    _buildGender(),
                    SizedBox(height: 10),
                    _buildProductDescription(),
                    SizedBox(height: 10),
                    _buildCategory(),
                    SizedBox(height: 10),
                    _buildBrand(),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ảnh chính",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(Icons.photo_library),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ảnh phụ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black54),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Icon(Icons.photo_library),
                              ),
                            ),
                            SizedBox(width: 10),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black54),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Icon(Icons.photo_library),
                              ),
                            ),
                            SizedBox(width: 10),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black54),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Icon(Icons.photo_library),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    _buildSubmitBtn(),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Column _buildBrand() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Thương hiệu",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 5),
        InputDecorator(
          decoration: InputDecoration(
              hintText: 'Please select expense',
              hintStyle: TextStyle(color: Colors.black54),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              // value: _category,
              hint: Text("Category"),
              isDense: true,
              onChanged: (String newValue) {
                setState(() {});
              },
              items: _currencies.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Loại",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 5),
        InputDecorator(
          decoration: InputDecoration(
              hintText: 'Please select expense',
              hintStyle: TextStyle(color: Colors.black54),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              // value: _category,
              hint: Text("Category"),
              isDense: true,
              onChanged: (String newValue) {
                setState(() {});
              },
              items: _currencies.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildGender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Giới tính",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        Column(
          children: List.generate(
            types.length,
            (index) => CheckboxListTile(
              title: Text(types[index]),
              value: isTypes[index],
              onChanged: (val) {
                setState(() {
                  isTypes[index] = val;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Column _buildColour() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Màu sắc",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black54,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: DirectSelectList<String>(
                    values: colours,
                    defaultItemIndex: 3,
                    itemBuilder: (String value) => getDropDownMenuItem(value),
                    focusedItemDecoration: _getDslDecoration(),
                    onItemSelectedListener: (item, index, context) {}),
              ),
              Icon(
                Icons.unfold_more,
                color: Colors.black38,
              ),
            ],
          ),
        ),
      ],
    );
  }

  _getDslDecoration() {
    return BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(width: 1, color: Colors.black12),
        top: BorderSide(width: 1, color: Colors.black12),
      ),
    );
  }

  DirectSelectItem<String> getDropDownMenuItem(String value) {
    return DirectSelectItem<String>(
        itemHeight: 56,
        value: value,
        itemBuilder: (context, value) {
          return Text(
            value,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
            ),
          );
        });
  }

  ElevatedButton _buildSubmitBtn() {
    return ElevatedButton(
      onPressed: () {},
      child: Text("Thêm"),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 18),
        primary: Colors.orangeAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    );
  }

  Column _buildPrice() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Giá gốc",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Origin",
                      hoverColor: Colors.black,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Giá bán",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Sale",
                      hoverColor: Colors.black,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProductDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Mô tả",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 5),
        Material(
          child: HtmlEditor(
            controller: htmlController,
            htmlEditorOptions: HtmlEditorOptions(
              hint: "Description",
            ),
            htmlToolbarOptions: HtmlToolbarOptions(
                toolbarPosition: ToolbarPosition.aboveEditor,
                toolbarType: ToolbarType.nativeGrid,
                defaultToolbarButtons: [
                  FontButtons(),
                ]),
            otherOptions: OtherOptions(
              height: 300,
            ),
          ),
        ),
      ],
    );
  }

  Column _buildProductName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tên sản phẩm",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            hintText: "Product name",
            hoverColor: Colors.black,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildProductCode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Mã sản phẩm",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            hintText: "Product code",
            hoverColor: Colors.black,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
