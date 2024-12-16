import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/screens/home/screen/dashboard_screen/Dashboard.dart';
import 'package:fitness/screens/home/screen/search_screen/SearchAndSuggestionScreen.dart';
import 'package:fitness/screens/home/screen/social/suggest/SocialScreen.dart';
import 'package:fitness/screens/profile/user_profile_main/UserProfileScreen.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key, this.user});
  final User? user;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = MyAppHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
            () => NavigationBar(
          height: 60,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          backgroundColor: darkMode ? AppColor.black : Colors.white,
          indicatorColor: darkMode
              ? AppColor.white.withOpacity(0.1)
              : AppColor.black.withOpacity(0.1),
          onDestinationSelected: (index) {
            // Check index bounds before assigning
            if (index >= 0 && index < controller.screens.length) {
              controller.selectedIndex.value = index;
            }
          },
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home, size: 20), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.search_favorite, size: 20), label: 'Search'),
            NavigationDestination(icon: Icon(Iconsax.shop, size: 20), label: 'Social'),
            NavigationDestination(icon: Icon(Iconsax.user, size: 20), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final List<Widget> screens = [
    const Dashboard(),
    const SearchAndSuggestionScreen(),
     SocialScreen(),
    const UserProfileScreen(),
  ];
}
