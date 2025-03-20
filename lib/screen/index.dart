import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hai_tegal_getx/controller/index_controller.dart';
import 'package:hai_tegal_getx/screen/menu/home_screen.dart';
import 'package:hai_tegal_getx/screen/menu/saved_screen.dart';
import 'package:line_icons/line_icons.dart';

import '../app_routes.dart';
import '../components/colors.dart';
import 'menu/account_screen.dart';
import 'menu/notification_screen.dart';

class Index extends GetView<IndexController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 0.08 * MediaQuery.of(context).size.height,
        child: BottomBarBubble(
          selectedIndex: controller.selectedIndex.value,
          color: WAPrimaryColor1,
          items: [
            BottomBarItem(
              iconData: LineIcons.home,
              label: 'Home',
              labelTextStyle: GoogleFonts.montserrat(fontSize: 14),
            ),
            BottomBarItem(
              iconData: LineIcons.bell,
              label: 'Notification',
              labelTextStyle: GoogleFonts.montserrat(fontSize: 14),
            ),
            BottomBarItem(
              iconData: LineIcons.bookmark,
              label: 'Saved',
              labelTextStyle: GoogleFonts.montserrat(fontSize: 14),
            ),
            BottomBarItem(
              iconData: LineIcons.user,
              label: 'Account',
              labelTextStyle: GoogleFonts.montserrat(fontSize: 14),
            ),
          ],
          onSelect: (index) {
            controller.changeIndex(index);
            // if (index == 0) {
            //   Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            // } else if (index == 1) {
            //   Navigator.pushNamedAndRemoveUntil(context, '/notifikasi', (route) => false);
            // } else if (index == 2) {
            //   loadAllSaved('');
            //   Navigator.pushNamedAndRemoveUntil(context, '/saved', (route) => false);
            // } else {
            //   Navigator.pushNamedAndRemoveUntil(context, '/account', (route) => false);
            // }
          },
        ),
      ),
      body: SafeArea(
        child:  Obx(() => IndexedStack(
          index: controller.selectedIndex.value,
          children: [
            HomeScreen(),
            NotificationScreen(),
            SavedScreen(),
            AccountScreen(),
          ],
        )),
      )
    );
  }
}
