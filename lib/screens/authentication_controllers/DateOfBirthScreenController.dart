import 'package:get/get.dart';

class DateOfBirthScreenController extends GetxController {
  var selectedIndex = Rx<int?>(null);

  // Method to select an item
  void selectItem(int index) {
    selectedIndex.value = index;
  }
}
