import 'package:email_validator/email_validator.dart';
import 'package:fitness/screens/authentications/select_gender_screen/SelectGenderScreen.dart';
import 'package:fitness/utils/helpers/KeyboardController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final textGender = TextEditingController();
  var selectedGender = ''.obs;
  var isPasswordVisible = true.obs;
  var isConfirmPasswordVisible = true.obs;

  void setGender(String value) {
    selectedGender.value = value;
  }

  void checkValidation() {
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    // Check if fields are empty
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      setMessage('Failed', 'Please fill in all fields', Colors.redAccent);
      return;
    }

    // Validate email
    if (!EmailValidator.validate(email)) {
      setMessage('Failed', 'Enter a valid email', Colors.redAccent);
      return;
    }

    // Validate password
    final result = validatePassword(password);
    if (result != null) {
      setMessage('Failed', result, Colors.redAccent);
      return;
    }

    // Check if passwords match
    if (password != confirmPassword) {
      setMessage('Failed', 'Passwords do not match', Colors.redAccent);
      return;
    }

    // If everything is valid, proceed to sign up
    signUp();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void signUp() {
    // Implement your sign-up logic here
    setMessage('Success', 'Account successfully created', Colors.blue);
    Get.to(SelectGenderScreen());
    KeyboardController.instance.hideKeyboard();
  }

  void setMessage(String title, String message, Color backgroundColor) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      duration: const Duration(seconds: 1),
      margin: const EdgeInsets.all(16), // Adjust the margin as needed

    );
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
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
