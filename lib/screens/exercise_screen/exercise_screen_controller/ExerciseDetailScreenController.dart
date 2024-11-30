import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExerciseDetailScreenController extends GetxController  {
  var isClicked = false.obs;
  var timeInSeconds = 20.obs;
  var currentPage = 0.obs;
  RxInt currentDuration = 0.obs; // Create an observable duration

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
  void incrementTime1() {
    timeInSeconds.value += 20;
  }

  // Decrement time by 20 seconds, ensuring it doesn't go below 0
  void decrementTime1() {
    if (timeInSeconds.value > 20) { // Ensure we don't go below initial value
      timeInSeconds.value -= 20;
    }
  }


  void incrementTime(String exerciseType, String exerciseName) {
    currentDuration.value += 20; // Add 20 seconds
    updateDurationInFirebase(exerciseType, exerciseName, currentDuration.value);
  }

  // Function to decrement time
  void decrementTime(String exerciseType, String exerciseName) {
    if (currentDuration.value >= 20) { // Prevent negative time
      currentDuration.value -= 20; // Subtract 20 seconds
      updateDurationInFirebase(exerciseType, exerciseName, currentDuration.value);
    }
  }

  // Function to update the duration in Firebase
  Future<void> updateDurationInFirebase(String exerciseType, String exerciseName, int newDuration) async {
    final DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref('Exercise')
        .child(exerciseType)
        .child(exerciseName);

    try {
      await databaseReference.update({
        'durations': newDuration.toString(), // Save duration as string
      });
      print('Duration updated to: $newDuration seconds');
    } catch (error) {
      print("Error updating duration: $error");
    }
  }

}
