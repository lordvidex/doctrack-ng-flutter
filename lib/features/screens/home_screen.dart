import 'package:final_year/features/controllers/home.dart';
import 'package:final_year/features/screens/national_profile.dart';
import 'package:final_year/features/screens/profile.dart';
import 'package:final_year/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'document_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  buildBottomNavigationMenu(context, controller) {
    return Obx(() => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          showSelectedLabels: true,
          onTap: controller.changeTabIndex,
          currentIndex: controller.tabIndex.value,
          backgroundColor: const Color.fromARGB(255, 21, 99, 1),
          unselectedItemColor: Colors.white.withOpacity(0.5),
          selectedItemColor: Colors.white,
          unselectedLabelStyle: unselectedLabelStyle,
          selectedLabelStyle: selectedLabelStyle,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(bottom: 7),
                child: Icon(
                  Icons.search,
                  size: 20.0,
                ),
              ),
              label: 'Workflows',
              backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(bottom: 7),
                child: Icon(
                  Icons.edit_document,
                  size: 20.0,
                ),
              ),
              label: 'My Documents',
              backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
            ),
          ],
        )));
  }

  @override
  Widget build(BuildContext context) {
    final HomeController controller =
        Get.put(HomeController(), permanent: true);
    return Scaffold(
        bottomNavigationBar: buildBottomNavigationMenu(context, controller),
        body: Obx(() =>
            IndexedStack(index: controller.tabIndex.value, children: const [
              WorkflowsScreen(),
              DocumentsScreen(),
            ])));
  }
}
