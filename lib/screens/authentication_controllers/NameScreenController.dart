import 'package:fitness/common/snackbar/ShowSnackbar.dart';
import 'package:fitness/screens/authentications/date_birth_screen/DateOfBirthScreen.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NameScreenController extends GetxController {
  final nameController = TextEditingController();
  final focusNode = FocusNode(); // Added focus node
  var isNameEntered = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Listener for the text controller
    nameController.addListener(() {
      isNameEntered.value = nameController.text.isNotEmpty;
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
    nameController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  void getName() {
    final String name = nameController.text;

    if (name.isEmpty) {
      ShowSnackbar.showMessage(title: 'Error', message: 'Enter your name', backgroundColor: AppColor.error);
    }
    else{
      Get.to(DateOfBirthScreen());

    }



  }
}
