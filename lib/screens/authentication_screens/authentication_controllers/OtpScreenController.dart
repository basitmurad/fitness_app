import 'package:fitness/utils/constants/AppColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class OtpScreenController extends GetxController {

  var pin = ''.obs;

  // Method to update the pin code
  void updatePin(String value) {
    pin.value = value;
  }

  // Compute color based on whether the pin is empty or not
  Color get pinColor => pin.isNotEmpty ? AppColor.lightBlue.withOpacity(0.8) : AppColor.lightBlue;


}
