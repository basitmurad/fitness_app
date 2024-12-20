import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KeyboardController extends GetxController {
  static KeyboardController get instance => Get.find<KeyboardController>();

  final FocusNode focusNode = FocusNode();


  void hideKeyboard() {
    FocusScope.of(Get.context!).unfocus();
  }

  @override
  void onClose() {
    focusNode.dispose();
    super.onClose();
  }
}
