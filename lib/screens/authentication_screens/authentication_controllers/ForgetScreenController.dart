import 'package:email_auth/email_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/common/snackbar/ShowSnackbar.dart';
import 'package:fitness/screens/authentication_screens/screens/login_screen/LoginScreen.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/otp_screen/OtpScreen.dart';

class ForgetController extends GetxController{

  final emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<void> sendPasswordResetEmail(BuildContext context) async {
    final String email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your email address.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset email sent! Please check your inbox. '),
          backgroundColor: Colors.green,
        ),

      );
      Get.offAll(LoginScreen());
    } catch (e) {
      String errorMessage;

      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'invalid-email':
            errorMessage = 'The email address is not valid.';
            break;
          case 'user-not-found':
            errorMessage = 'No user found with this email.';
            break;
          default:
            errorMessage = 'An error occurred. Please try again later.';
        }
      } else {
        errorMessage = 'An unexpected error occurred.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> forgetPassword(BuildContext context) async {
    final email = emailController.text.trim(); // Trim whitespace for better validation

    // Check if email is empty
    if (email.isEmpty) {
      ShowSnackbar.showMessage(
        title: 'Invalid Email',
        message: 'Please enter a correct email',
        backgroundColor: AppColor.error,
      );
      return;
    }

    // Validate email format
    if (!EmailValidator.validate(email)) {
      ShowSnackbar.showMessage(
        title: 'Invalid Email',
        message: 'Please enter a correct email',
        backgroundColor: AppColor.error,
      );
      return;
    }

    try {
      // Show the progress dialog
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent dismissing by tapping outside
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text(
                  'Processing...',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          );
        },
      );

      // Reference to the Firebase Realtime Database
      final DatabaseReference databaseRef = FirebaseDatabase.instance.ref('users');

      // Fetch the snapshot of the user node
      final DataSnapshot snapshot = await databaseRef.get();

      // Dismiss the progress dialog
      Navigator.of(context).pop();

      if (snapshot.exists) {
        // Loop through the children to find if the email exists
        bool emailExists = false;
        for (var user in snapshot.children) {
          if (user.child('email').value == email) {
            emailExists = true;
            break;
          }
        }

        if (emailExists) {
          ShowSnackbar.showMessage(
            title: 'Email Found',
            message: 'Password reset instructions have been sent to your email.',
            backgroundColor: AppColor.success,
          );
          // TODO: Send password reset instructions
        } else {
          ShowSnackbar.showMessage(
            title: 'Email Not Found',
            message: 'The email entered does not exist in our database.',
            backgroundColor: AppColor.warning,
          );
        }
      } else {
        ShowSnackbar.showMessage(
          title: 'No Users Found',
          message: 'The database contains no users.',
          backgroundColor: AppColor.error,
        );
      }
    } catch (error) {
      // Dismiss the progress dialog in case of error
      Navigator.of(context).pop();

      ShowSnackbar.showMessage(
        title: 'Error',
        message: 'An error occurred: $error',
        backgroundColor: AppColor.error,
      );
      print("Message$error");
    }
  }



  // Future<void> forgetPassword() async {
  //   final email = emailController.text;
  //   if (email.isEmpty) {
  //
  //     ShowSnackbar.showMessage(title: 'Invalid Email', message: 'Please enter a correct email', backgroundColor: AppColor.error);
  //     return;
  //   }
  //     if (!EmailValidator.validate(email)) {
  //       ShowSnackbar.showMessage(title: 'Invalid Email', message: 'Please enter a correct email', backgroundColor: AppColor.error);
  //     return;
  //   }
  //
  //
  //
  // }

  void SendOtp() async{
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
}