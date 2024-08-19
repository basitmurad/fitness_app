import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/constants/AppColor.dart';
import '../../../../utils/constants/AppString.dart';
import '../../signup_screen/SignUpScreen.dart';

class LoginBottom extends StatelessWidget {
  const LoginBottom({
    super.key,
    required this.dark, required this.buttonText,
  });

  final bool dark;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
      crossAxisAlignment: CrossAxisAlignment.center, // Center vertically
      children: [
        Text(
          AppStrings.donothave,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14 ,fontWeight: FontWeight.w400), // Customize text style as needed
        ),
        const SizedBox(width: 10), // Space between text and button
        TextButton(
          onPressed: () => Get.to(const SignUpScreen()), // Handle button press
          child: Text(
            buttonText,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14,fontWeight: FontWeight.w900 ,color: dark ? AppColor.white : AppColor.lightBlue), // Customize button text style as needed
          ),
        ),
      ],
    );
  }
}
