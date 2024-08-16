import 'package:fitness/screens/authentications/login_screen/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  final pageController = PageController();

  RxInt currentIndex = 0.obs;

  void updatePage(int index) {
    currentIndex.value = index;
  }

  void nextPage() {
    if (currentIndex == 2) {
      Get.offAll(const LoginScreen());
    } else {
      int page = currentIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  void skipPage(){
Get.offAll(const LoginScreen());
  }
}
