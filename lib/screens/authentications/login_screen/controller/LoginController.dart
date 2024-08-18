import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isPasswordVisible = true.obs;

  void login() {
    final email = emailController.text;
    final password = passwordController.text;

    // Validate email and password
    if (email.isEmpty || password.isEmpty) {
      setMessage('Failed', 'Fields are empty', Colors.redAccent);
      return;
    }

    if (!EmailValidator.validate(email)) {

      setMessage('Failed', 'Enter a valid email', Colors.redAccent);
      return;
    }

    final result = validatePassword(password);
    if (result != null) {
      setMessage('Failed', 'Enter a valid password', Colors.redAccent);
      return;
    }


    loginToAccount(email, password);
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

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void loginToAccount(String email , String password){

    setMessage('Success', 'Successfully login ', Colors.blue);


  }

  void setMessage(String title, String message , Color backgroundColor ) {
    Get.snackbar(
        title, // Title of the Snackbar
        message, // Message
        snackPosition: SnackPosition.BOTTOM, // Position of the Snackbar
        backgroundColor: backgroundColor, // Background color
        colorText: Colors.white, // Text color
        duration: const Duration(seconds: 2));
  }


  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
