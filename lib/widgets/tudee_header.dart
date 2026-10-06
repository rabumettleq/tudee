import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TudeeHeader extends StatelessWidget implements PreferredSizeWidget {
  const TudeeHeader({super.key});

  @override
  Size get preferredSize => Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF49BAF2),
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 48,
      titleSpacing: 16,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xFF49BAF2),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      title: Text(
        'Tudee',
        style: TextStyle(
          fontFamily: 'CherryBomb',
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Color(0xDEFFFFFF),
        ),
      ),
    );
  }
}