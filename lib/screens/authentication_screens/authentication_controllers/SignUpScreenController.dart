import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/email_verification_screen/EmailVerificationScreen.dart';

class SignUpController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  var selectedGender = ''.obs;
  var isPasswordVisible = true.obs;
  var isConfirmPasswordVisible = true.obs;
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var submitValid = false.obs;

  void checkValidation() {
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    final name = nameController.text;

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty  || name.isEmpty) {
      setMessage('Failed', 'Please fill in all fields', Colors.redAccent);
      return;
    }

    if (!EmailValidator.validate(email)) {
      setMessage('Failed', 'Enter a valid email', Colors.redAccent);
      return;
    }

    final result = validatePassword(password);
    if (result != null) {
      setMessage('Failed', result, Colors.redAccent);
      return;
    }

    if (password != confirmPassword) {
      setMessage('Failed', 'Passwords do not match', Colors.redAccent);
      return;
    }

    // Proceed to sign up
    signUp();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }
  Future<void> signUp() async {
    print('Data is being saved');

    // Show progress dialog
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      // Create user with email and password
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Send verification email
      await userCredential.user!.sendEmailVerification();
      print('Verification email sent');

      // Notify user about the email sent
      setMessage('Success', 'Verification email sent. Please check your inbox.', Colors.blue);

      // Navigate to the EmailVerificationScreen after successful email sending
      Get.to(EmailVerificationScreen(
        email: emailController.text,
        password: passwordController.text, name: '',
      ));
      print('Navigated to EmailVerificationScreen');

    } catch (e) {
      // Show error message if any exception occurs
      setMessage('Error', e.toString(), Colors.redAccent);
      print('Error: ${e.toString()}');
    } finally {
      // Dismiss the progress dialog
      Get.back();
    }
  }




  void setMessage(String title, String message, Color backgroundColor) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
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
    nameController.dispose();
    super.dispose();
  }
}
