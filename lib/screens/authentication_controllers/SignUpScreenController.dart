import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/screens/authentications/email_verification_screen/EmailVerificationScreen.dart';
import 'package:fitness/screens/modelClass/UserData%20.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shared_preferences/UserPreferences.dart';

class SignUpController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
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

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
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
      await UserPreferences.saveUserData(
        email: emailController.text,
        password: passwordController.text,
        gender: '',
        name: '',
        age: '',
        height: '',
        weight: '',
        targetWeight: '',
        mainGoal: '',
      );

      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Send verification email
      await userCredential.user!.sendEmailVerification();
      UserData userData = UserData(
              email: emailController.text,
              name: '',
              gender: '',
              age: '',
              height: '',
              weight: '',
              targetWeight: '',
            );

            // Upload user data to Firebase Realtime Database
            await databaseReference.child('users/${userCredential.user!.uid}').set(userData.toJson());

      // Notify user
      setMessage('Success', 'Verification email sent. Please check your inbox.', Colors.blue);
      Get.to(EmailVerificationScreen(email: emailController.text, password: passwordController.text));
    } catch (e) {
      setMessage('Error', e.toString(), Colors.redAccent);
      print('Error: ${e.toString()}');
    } finally {
      Get.back(); // Dismiss the progress dialog
    }
  }


  // Future<void> signUp() async {
  //   print('Data is being saved');
  //
  //   // Show progress dialog
  //   Get.dialog(
  //     const Center(child: CircularProgressIndicator()),
  //     barrierDismissible: false, // Prevent dismissing the dialog by tapping outside
  //   );
  //
  //   try {
  //     await UserPreferences.saveUserData(
  //       email: emailController.text,
  //       password: passwordController.text,
  //       gender: '',
  //       name: '',
  //       age: 0,
  //       height: '',
  //       weight: '',
  //       targetWeight: '',
  //       mainGoal: '',
  //     );
  //
  //     UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
  //       email: emailController.text,
  //       password: passwordController.text,
  //     );
  //
  //     // Send verification email
  //     await userCredential.user!.sendEmailVerification();
  //     UserData userData = UserData(
  //       email: emailController.text,
  //       name: '',
  //       gender: '',
  //       age: '',
  //       height: '',
  //       weight: '',
  //       targetWeight: '',
  //     );
  //
  //     // Upload user data to Firebase Realtime Database
  //     await databaseReference.child('users/${userCredential.user!.uid}').set(userData.toJson());
  //
  //     // Notify user
  //     setMessage('Success', 'Verification email sent. Please check your inbox.', Colors.blue);
  //     Get.to(EmailVerificationScreen(email: emailController.text, password: passwordController.text));
  //   } catch (e) {
  //     setMessage('Error', e.toString(), Colors.redAccent);
  //     print('Error: ${e.toString()}');
  //   } finally {
  //     Get.back(); // Dismiss the progress dialog
  //   }
  // }

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
    super.dispose();
  }
}
