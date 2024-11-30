
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeightScreenController extends GetxController {
  // Reactive variables for unit selection
  var isCmSelected = false.obs;
  var isFtSelected = false.obs;
  var selectedUnit = 'Cm'.obs; // Default selected unit
  var cmValue = ''.obs;
  var ftValue = ''.obs;
  var inchValue = ''.obs;
  var opacity = 0.4.obs; // Initial opacity set to 0.1

  // Controllers for text fields
  final TextEditingController cmController = TextEditingController();
  final TextEditingController ftController = TextEditingController();
  final TextEditingController inchController = TextEditingController();

  // Reactive variable for opacity
  var unitOpacity = 0.4.obs;

  void selectUnit(String unit) {
    selectedUnit.value = unit;
    opacity.value = 0.9; // Change opacity to 0.4 when a unit is selected
  }

  bool isSelected(String unit) {
    return selectedUnit.value == unit;
  }

  void updateCmValue(String value) {
    cmValue.value = value;
  }

  void updateFtValue(String value) {
    ftValue.value = value;
  }

  void updateInchValue(String value) {
    inchValue.value = value;
  }

  @override
  void onClose() {
    // Dispose controllers when not in use
    cmController.dispose();
    ftController.dispose();
    inchController.dispose();
    super.onClose();
  }
}
