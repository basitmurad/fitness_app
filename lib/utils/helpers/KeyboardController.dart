import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KeyboardController extends GetxController {
  static KeyboardController get instance => Get.find<KeyboardController>();

  final FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    // Optionally request focus on initialization if needed
    // Future.delayed(Duration(milliseconds: 1), () {
    //   FocusScope.of(Get.context!).requestFocus(focusNode);
    // });
  }

  void hideKeyboard() {
    FocusScope.of(Get.context!).unfocus();
  }

  @override
  void onClose() {
    focusNode.dispose();
    super.onClose();
  }
}
