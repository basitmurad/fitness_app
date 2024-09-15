import 'package:get/get.dart';

class ExerciseProgressController extends GetxController {
  // Observable variable to manage button visibility
  var isStartButtonVisible = true.obs;

  void toggleButton() {
    isStartButtonVisible.value = !isStartButtonVisible.value;
  }
}
