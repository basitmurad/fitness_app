import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class WeightScreenController extends GetxController{
  var isKgSelected = false.obs;
  var isLbsSelected = false.obs;
  var selectedUnit = 'Kg'.obs; // Default selected unit
  // Controllers for text fields
  final TextEditingController kgController = TextEditingController();
  final TextEditingController lbsController = TextEditingController();
  var opacity = 0.1.obs; // Initial opacity set to 0.1


  // Reactive variable for opacity
  var unitOpacity = 0.1.obs;

  void selectUnit(String unit) {
    selectedUnit.value = unit;
    opacity.value = 0.9; // Change opacity to 0.4 when a unit is selected

    if (unit == 'Kg') {
      // Clear Lbs value when selecting Kg
      lbsController.clear();
    } else if (unit == 'Lbs') {
      // Clear Kg value when selecting Lbs
      kgController.clear();
    }
  }

  bool isSelected(String unit) {
    return selectedUnit.value == unit;
  }




}