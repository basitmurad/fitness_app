import 'package:get/get.dart';

class BodyFocusScreenController extends GetxController {
  var selectedCardIndices = RxList<int>();
  bool get anyCardSelected => selectedCardIndices.isNotEmpty;

  // Method to toggle card selection
  void toggleCardSelection(int index) {
    if (selectedCardIndices.contains(index)) {
      selectedCardIndices.remove(index);
    } else {
      selectedCardIndices.add(index);
    }
  }

  // Method to check if a card is selected
  bool isCardSelected(int index) {
    return selectedCardIndices.contains(index);
  }

}
