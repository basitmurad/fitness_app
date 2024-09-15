import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExerciseDetailScreenController extends GetxController  {
  var isClicked = false.obs;

  void toggleClick() {
    isClicked.value = !isClicked.value;
  }

  var currentPage = 0.obs;
  final PageController pageController = PageController();

  void goToPage(int page) {
    pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    currentPage.value = page;
  }

  void onPageChanged(int page) {
    currentPage.value = page;
  }

}
