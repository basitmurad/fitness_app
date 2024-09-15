import 'package:fitness/common/snackbar/ShowSnackbar.dart';
import 'package:fitness/screens/authentications/date_birth_screen/DateOfBirthScreen.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../shared_preferences/UserPreferences.dart';

class NameScreenController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final focusNode = FocusNode(); // Added focus node
  var isNameEntered = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Listener for the text controller
    firstNameController.addListener(() {
      isNameEntered.value = firstNameController.text.isNotEmpty;
    });
    lastNameController.addListener(() {
      isNameEntered.value = lastNameController.text.isNotEmpty;
    });

    // Listener for focus changes
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        isNameEntered.value = true; // Ensure opacity is normal when focused
      }
    });
  }

  @override
  void onClose() {
    lastNameController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  Future<void> getName( String gender , String password  ,String email) async {
    final String name = "${firstNameController.value.text} ${lastNameController.value.text}" ;

    if (name.isEmpty) {
      ShowSnackbar.showMessage(title: 'Error', message: 'Enter your name', backgroundColor: AppColor.error);
    }
    else{

      print('Navigating to DateOfBirthScreen with email: $email, gender: $gender');

      await UserPreferences.saveUserData(
        gender: gender,
        email: email,
        password: password,
        name: name, // To be filled later
        age: 0, // To be filled later
        height: '', // To be filled later
        weight: '', // To be filled later
        targetWeight: '', // To be filled later
        mainGoal: '',
      );
      Get.to(()=>DateOfBirthScreen(
        email: email,
        password: password,
        gender: gender,
        name: name,
      ));

    }



  }
}
