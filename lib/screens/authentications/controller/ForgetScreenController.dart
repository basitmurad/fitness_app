import 'package:email_validator/email_validator.dart';
import 'package:fitness/screens/authentications/otp_screen/OtpScreen.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/helpers/KeyboardController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ForgetController extends GetxController{

  final emailController = TextEditingController();




  void forgetPassword(){
    final email = emailController.text;
    if (email.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill in all fields.");
      return;
    }
      if (!EmailValidator.validate(email)) {
      Fluttertoast.showToast(msg: "Please enter a valid email address.");
      return;
    }


    // Hide the keyboard
    // KeyboardController.instance.hideKeyboard();

    // Show the Snackbar message
    setMessage("Success", "Code sent successfully to $email", AppColor.lightBlue.withOpacity(0.7));

    Get.to(() =>  OtpScreen());


    // Delay navigation to ensure Snackbar is shown before navigating







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