import 'package:get/get.dart';

class SignUpController extends GetxController {
  var selectedGender = ''.obs;

    void setGender(String value) {
    selectedGender.value = value;
  }
}