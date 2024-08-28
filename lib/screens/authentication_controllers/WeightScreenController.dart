import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../utils/helpers/MyAppHelper.dart';

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

  // bool validateWeight(   String email ,String password , String gender ,String name ,String height
  //  ,int year) {
  //   if (isSelected('Kg')) {
  //     final weight = double.tryParse(kgController.text);
  //     if (weight == null || weight <= 0) {
  //       MyAppHelperFunctions.showSnackBar("Please enter a valid weight in kg.");
  //       return false;
  //     }
  //   } else if (isSelected('Lbs')) {
  //     final weight = double.tryParse(lbsController.text);
  //     if (weight == null || weight <= 0) {
  //       MyAppHelperFunctions.showSnackBar("Please enter a valid weight in lbs.");
  //       return false;
  //     }
  //   }
  //   return true;
  // }

  bool validateWeight(String email, String password, String gender, String name, String height, int year) {
    if (isSelected('Kg')) {
      final weight = double.tryParse(kgController.text);
      if (weight == null || weight <= 0) {
        MyAppHelperFunctions.showSnackBar("Please enter a valid weight in kg.");
        return false;
      }
    } else if (isSelected('Lbs')) {
      final weight = double.tryParse(lbsController.text);
      if (weight == null || weight <= 0) {
        MyAppHelperFunctions.showSnackBar("Please enter a valid weight in lbs.");
        return false;
      }
    }
    return true;
  }

}