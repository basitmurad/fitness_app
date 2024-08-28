import 'package:get/get.dart';

import '../authentications/body_goal_screen/BodyGoalScreen.dart';

class BodyGoalScreenController extends GetxController {
  var selectedIndex = (-1).obs; // Initialize with -1 meaning no card is selected
  var isSelected = false.obs; // To track if any card is selected

  void selectCard(int index) {
    selectedIndex.value = index; // Update the selected card index
    isSelected.value = true; // Mark that a card is selected
  }

  String getSelectedGoalText() {
    if (selectedIndex.value == -1) return '';
    return cardDetails[selectedIndex.value]['text'];
  }

}
