import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController{

  var currentIndex = 0.obs; // Observable integer to hold the current index

  void setIndex(int index) {
    currentIndex.value = index; // Update the current index
  }

  final pageController = PageController();
  RxInt currentPageIndex = 0.obs;
  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

}