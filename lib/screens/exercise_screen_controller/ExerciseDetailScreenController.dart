import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExerciseDetailScreenController extends GetxController  {
  var isClicked = false.obs;
  var timeInSeconds = 20.obs;
  var currentPage = 0.obs;

  void toggleClick() {
    isClicked.value = !isClicked.value;
  }

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






  // Format the time as MM:SS
  String get formattedTime {
    int minutes = (timeInSeconds.value / 60).floor();
    int seconds = timeInSeconds.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // Increment time by 20 seconds
  void incrementTime() {
    timeInSeconds.value += 20;
  }

  // Decrement time by 20 seconds, ensuring it doesn't go below 0
  void decrementTime() {
    if (timeInSeconds.value > 20) { // Ensure we don't go below initial value
      timeInSeconds.value -= 20;
    }
  }


}
