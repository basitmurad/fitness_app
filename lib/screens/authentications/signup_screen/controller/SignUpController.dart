import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final textGender = TextEditingController();
  var selectedGender = ''.obs;
  var isPasswordVisible = true.obs;

  void setGender(String value) {
    selectedGender.value = value;
  }

  void checkValidation() {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setMessage('Failed', 'Check all field',Colors.redAccent);
    }

    if(!EmailValidator.validate(email)){
      setMessage('Failed', 'Enter a valid email',Colors.redAccent);
      return;
    }


    final result = validatePassword(password);
    if(result !=null){

      setMessage('Failed', result ,Colors.redAccent);

    }





    signUp();


  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  void signUp() {

    setMessage('Success', 'Successfully creating account' ,Colors.blue);

  }

  void withEmailPPassword() {}

  void withGoogle() {}

  void setMessage(String title, String message , Color backgroundColor ) {
    Get.snackbar(
        title, // Title of the Snackbar
        message, // Message
        snackPosition: SnackPosition.BOTTOM, // Position of the Snackbar
        backgroundColor: backgroundColor, // Background color
        colorText: Colors.white, // Text color
        duration: const Duration(seconds: 2));
  }


  String? validatePassword(String password) {
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Password must contain at least one digit';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return 'Password must contain at least one special character';
    }
    return null; // Password is valid
  }


  @override
  void dispose() {

    super.dispose();
    emailController.dispose();
    passwordController.dispose();

  }
}
