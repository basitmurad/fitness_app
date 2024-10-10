
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../common/snackbar/ShowSnackbar.dart';
import '../../utils/constants/AppColor.dart';
import '../authentications/date_birth_screen/DateOfBirthScreen.dart';
import '../shared_preferences/UserPreferences.dart';

class NameScreenController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final focusNodeFirstName = FocusNode();
  final focusNodeLastName = FocusNode();
  var isNameEntered = false.obs;

  @override
  void onInit() {
    super.onInit();

    firstNameController.addListener(_updateNameEnteredState);
    lastNameController.addListener(_updateNameEnteredState);

    // Add focus listener to the first name field
    focusNodeFirstName.addListener(() {
      if (!focusNodeFirstName.hasFocus) {
        FocusScope.of(Get.context!).requestFocus(focusNodeLastName);
      }
    });
  }

  void _updateNameEnteredState() {
    // Check if both first and last names are entered
    isNameEntered.value = firstNameController.text.isNotEmpty && lastNameController.text.isNotEmpty;
  }


  Future<void> getName(String gender, String password, String email) async {
    final String name = "${firstNameController.value.text} ${lastNameController.value.text}";

    if (name.isEmpty) {
      ShowSnackbar.showMessage(title: 'Error', message: 'Enter your name', backgroundColor: AppColor.error);
    } else {
      print('Navigating to DateOfBirthScreen with email: $email, gender: $gender');

      await UserPreferences.saveUserData(
        gender: gender,
        email: email,
        password: password,
        name: name, // To be filled later
        age: '', // To be filled later
        height: '', // To be filled later
        weight: '', // To be filled later
        targetWeight: '', // To be filled later
        mainGoal: '',
      );

      await _uploadGenderToFirebase(name);
      Get.to(() => DateOfBirthScreen(
        email: email,
        password: password,
        gender: gender,
        name: name,
      ));
    }
  }

  Future<void> _uploadGenderToFirebase(String name) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    try {
      await databaseReference.child('users/$userId').update({
        'name': name,
      });
      debugPrint('Name updated in Firebase: $name');
    } catch (e) {
      debugPrint('Error updating name: ${e.toString()}');
    }
  }
}
