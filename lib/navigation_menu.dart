import 'package:fitness/screens/home/dashboard/Dashboard.dart';
import 'package:fitness/screens/home/profile/UserProfileScreen.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = MyAppHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          backgroundColor: darkMode ? AppColor.black : Colors.white,
          indicatorColor: darkMode
              ? AppColor.white.withOpacity(0.1)
              : AppColor.black.withOpacity(0.1),
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Iconsax.search_favorite), label: 'Search'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Social'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const Dashboard(),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.green,
    ),
    const UserProfileScreen(),
  ];
}
