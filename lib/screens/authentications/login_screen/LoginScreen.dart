import 'package:fitness/screens/authentications/login_screen/widgets/LoginDividerWidget.dart';
import 'package:fitness/screens/authentications/login_screen/widgets/LoginWidget.dart';
import 'package:fitness/screens/authentications/signup_screen/SignUpScreen.dart';
import 'package:fitness/utils/constants/sizes/AppSizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/device/AppDevicesUtils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: AppSizes.spaceBtwSections + 30),
               Container(
                 alignment: Alignment.topLeft,
                child: Icon(
                  Icons.fitness_center,
                  size: 100,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections+10),

              // Welcome Textx
              const Text(
                'Connect, Compete,\nand Conquer Your Fitness Goals Together.',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: AppSizes.appBarHeight ),

              const LoginWidget(),

              const SizedBox(height: AppSizes.spaceBtwSections),
              const LoginDividerWidget(),

              const SizedBox(height: AppSizes.appBarHeight + 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Create An Account ?',
                    style: TextStyle(fontSize: 14),
                  ),
                  TextButton(
                    onPressed: () {

                      Get.to(()=>const SignUpScreen());
                      // Handle sign-up action
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
