import 'package:get/get.dart';


class SelectGenderController extends GetxController {
  RxString selectedGender = ''.obs;
  RxBool isGenderSelected = false.obs;

  void selectGender(String gender) {
    selectedGender.value = gender;
    isGenderSelected.value = true;
  }


}
