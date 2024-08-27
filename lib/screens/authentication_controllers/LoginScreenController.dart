import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../navigation_menu.dart';
import '../authentications/forget_password/ForgetPassword.dart';

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

    if(!isValidEmail(email)){
      setMessage('Failed', 'Enter a valid email', Colors.redAccent);
      emailController.text = "";
      return;
    }
    // if (!EmailValidator.validate(email)) {
    //
    //   setMessage('Failed', 'Enter a valid email', Colors.redAccent);
    //   return;
    // }

    final result = validatePassword(password);
    if (result != null) {
      setMessage('Failed', 'Enter a valid password', Colors.redAccent);
      passwordController.text = "";
      return;
    }


    // setMessage('Success', 'Successfully login ', Colors.blue);

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
  bool isValidEmail(String email) {
    final regex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return regex.hasMatch(email);
  }
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void loginToAccount(String email , String password){

    setMessage('Success', 'Successfully login ', Colors.blue);
    Get.to(() => const NavigationMenu()); // Correct navigation


  }

  void setMessage(String title, String message, Color backgroundColor) {
    Get.snackbar(
      title, // Title of the Snackbar
      message, // Message
      snackPosition: SnackPosition.BOTTOM, // Adjust the position as needed
      backgroundColor: backgroundColor, // Background color
      colorText: Colors.white, // Text color
      margin: const EdgeInsets.symmetric(vertical: 20 ,horizontal: 20), // Margin around the Snackbar
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Padding inside the Snackbar
      borderRadius: 8, // Optional: Rounds the corners of the Snackbar
      duration: const Duration(seconds: 1),
    );
  }


  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void navigateToForgetPassword() {
    Get.to(() => ForgetPassword());
  }


}
