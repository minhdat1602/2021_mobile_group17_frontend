import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AdminAppBar extends StatelessWidget with PreferredSizeWidget {
  const AdminAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF212332),
          brightness: Brightness.dark,
        ),
        backgroundColor: Color(0xFF212332),
        primaryColor: Color(0xFF2697FF),
        accentColor: Color(0xFF2A2D3E),
      ),
      child: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: "Tìm kiếm",
            hintStyle: TextStyle(color: Colors.white70),
            fillColor: Color(0xFF2A2D3E),
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            suffixIcon: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(16 * 0.75),
                margin: EdgeInsets.symmetric(horizontal: 16 / 2),
                decoration: BoxDecoration(
                  color: Color(0xFF2A2D3E),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset("assets/icons/Search.svg"),
              ),
            ),
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16 / 2,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16 / 2),
                  child: Text("Angelina Joli"),
                ),
                Icon(Icons.keyboard_arrow_down),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
