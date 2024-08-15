import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ForgetController extends GetxController{

  final emailController = TextEditingController();




  void FogetPassord(){
    final email = emailController.text;
    if (email.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill in all fields.");
      return;
    }

    if (!EmailValidator.validate(email)) {
      Fluttertoast.showToast(msg: "Please enter a valid email address.");
      return;
    }



    Fluttertoast.showToast(msg: "Login Successfully");



  }
}