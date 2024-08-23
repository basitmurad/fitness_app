import 'package:get/get.dart';

class SelectGenderController extends GetxController {
  var isMaleChecked = false.obs;
  var isFemaleChecked = false.obs;

  void toggleMaleCheckbox() {
    isMaleChecked.value = !isMaleChecked.value;
  }

  void toggleFemaleCheckbox() {
    isFemaleChecked.value = !isFemaleChecked.value;
  }
  var selectedGender = ''.obs; // Observable to store the selected gender

  void selectGender(String gender) {
    selectedGender.value = gender;
  }
}
