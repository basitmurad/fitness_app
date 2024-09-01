import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class SelectGenderController extends GetxController {
  var isMaleChecked = false.obs;
  var isFemaleChecked = false.obs;
  RxBool isMaleSelected = false.obs;
  RxBool isFemaleSelected = false.obs;
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

  bool get isGenderSelected => isMaleSelected.value || isFemaleSelected.value;

  void selectMale() {
    isMaleSelected.value = true;
    isFemaleSelected.value = false;
  }

  void selectFemale() {
    isMaleSelected.value = false;
    isFemaleSelected.value = true;
  }


}
