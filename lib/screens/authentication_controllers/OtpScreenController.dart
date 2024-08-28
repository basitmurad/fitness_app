import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class OtpScreenController extends GetxController {
  final List<TextEditingController> controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());
  final RxList<String> otp = List.generate(4, (_) => '').obs;
  final RxList<bool> isFilled = List.generate(4, (_) => false).obs;

  @override
  void onInit() {
    super.onInit();
    for (int i = 0; i < controllers.length; i++) {
      controllers[i].addListener(() {
        if (controllers[i].text.length == 1) {
          otp[i] = controllers[i].text;
          isFilled[i] = true;
          if (i < controllers.length - 1) {
            FocusScope.of(Get.context!).requestFocus(focusNodes[i + 1]);
          }
        } else if (controllers[i].text.isEmpty) {
          otp[i] = '';
          isFilled[i] = false;
          if (i > 0) {
            FocusScope.of(Get.context!).requestFocus(focusNodes[i - 1]);
          }
        }
      });
    }
  }

  @override
  void onClose() {
    controllers.forEach((controller) => controller.dispose());
    focusNodes.forEach((focusNode) => focusNode.dispose());
    super.onClose();
  }

  var pin = ''.obs;

  void updatePin(String value) {
    pin.value = value;
  }
}
