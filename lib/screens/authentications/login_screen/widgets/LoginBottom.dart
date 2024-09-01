import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/AppColor.dart';
import '../../signup_screen/SignUpScreen.dart';

class LoginBottom extends StatelessWidget {
  const LoginBottom({
    super.key,
    required this.dark, required this.buttonText, required this.textMain,
  });

  final bool dark;
  final String buttonText;
  final String textMain;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
      crossAxisAlignment: CrossAxisAlignment.center, // Center vertically
      children: [
        Text(
          textMain,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14 ,fontWeight: FontWeight.w400), // Customize text style as needed
        ),

        const SizedBox(width: 3,),
        GestureDetector(
          onTap: ()=>Get.to(const SignUpScreen()),
          child: Text(
            buttonText,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14,fontWeight: FontWeight.w700 ,color: dark ? AppColor.white : AppColor.lightBlue), // Customize button text style as needed
          ),
        ),
      ],
    );
  }
}
