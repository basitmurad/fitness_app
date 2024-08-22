import 'package:get/get.dart';

class SelectGenderController extends GetxController{
  var isChecked = false.obs;

  void toggleCheckbox() {
    isChecked.value = !isChecked.value;
  }
}