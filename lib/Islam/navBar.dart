import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wa_business/Islam/Utility/appColors.dart';

import 'VideosScreen/channels.dart';
import 'home.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});


  @override
  Widget build(BuildContext context) {
    final cont = Get.put(control());
    return Scaffold(
      bottomNavigationBar: Obx(()=>NavigationBar(
          height: 60,
          elevation: 20,
          // labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          indicatorColor: Color(0xFF71D48F).withOpacity(0.2),
          shadowColor: Colors.black,
          backgroundColor: Colors.white,
          selectedIndex: cont.selectedIndex.value,
          onDestinationSelected: (i) => cont.selectedIndex.value = i,
          destinations: [
            NavigationDestination(icon: Icon(Icons.menu_book,color: cont.selectedIndex.value == 0? AppColors.primaryColor:Colors.black), label: 'Hadith'),
            NavigationDestination(icon: Icon(Icons.home, color: cont.selectedIndex.value == 1? AppColors.primaryColor:Colors.black  ,), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.video_collection, color: cont.selectedIndex.value == 2? AppColors.primaryColor:Colors.black), label: 'Videos'),
            NavigationDestination(icon: Icon(Icons.mosque, color: cont.selectedIndex.value == 2? AppColors.primaryColor:Colors.black), label: 'Videos'),
          ]
      ),),
      body: Obx(()=>cont.screens[cont.selectedIndex.value]),
    );
  }
}

class control extends GetxController{
  final RxInt selectedIndex = 1.obs;

  final screens = [Container(color: Colors.red,),HomePage(),VideoHomePage()];
}
