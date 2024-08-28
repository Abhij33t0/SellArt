import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final bool isTheme;
  final int selectedIndex;
  final Function(int) onItemTap;

   CustomBottomNavigationBar({
    super.key,
    required this.isTheme,
    required this.selectedIndex,
    required this.onItemTap,
  });
  final AppColor apk = AppColor();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: apk.secondaryColor,
          // borderRadius:
          // const BorderRadius.vertical(top: Radius.elliptical(40, 20))
         ),
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomNavigationItem(Icons.add_business, "Shop", 0),
          _buildBottomNavigationItem(
              CupertinoIcons.profile_circled, "Upload", 1),
          _buildBottomNavigationItem(Icons.settings, "Settings", 2),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationItem(IconData icon, String title, int index) {
    return IconButton(
        onPressed: () {
          onItemTap(index);
        },
        icon: Column(
          children: [
            Icon(icon, color: apk.primaryColor),
            Text(
              title,
              style: TextStyle(color: apk.primaryColor),
            ),
          ],
        ));
  }
}
