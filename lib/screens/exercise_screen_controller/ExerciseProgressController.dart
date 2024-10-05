import 'package:get/get.dart';

class ExerciseProgressController extends GetxController {
  // Observable variable to manage button visibility
  var isStartButtonVisible = true.obs;

  // Index of the current exercise
  var currentIndex = 0.obs;

  // Observable list of exercises
  // List<Map<String, String>> exerciseList;

  // Constructor to initialize the exercise list
  // ExerciseProgressController(this.exerciseList);

  // Toggle button visibility
  void toggleButton() {
    isStartButtonVisible.value = !isStartButtonVisible.value;
  }



  // Total number of exercises
  // int get totalExercises => exerciseList.length;

  // Increment the current index
  // void incrementIndex() {
  //   currentIndex.value = (currentIndex.value + 1) % totalExercises;
  // }
  //
  // // Decrement the current index
  // void decrementIndex() {
  //   currentIndex.value = (currentIndex.value - 1 + totalExercises) % totalExercises;
  // }
}
