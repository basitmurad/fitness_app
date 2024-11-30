import 'package:fitness/screens/authentication_screens/screens/login_screen/widgets/LoginBottom.dart';
import 'package:fitness/screens/authentication_screens/screens/login_screen/widgets/LoginDividerWidget.dart';
import 'package:fitness/screens/authentication_screens/screens/login_screen/widgets/LoginWidget.dart';
import 'package:fitness/screens/authentication_screens/screens/login_screen/widgets/SocialButton.dart';
import 'package:fitness/screens/authentication_screens/screens/login_screen/widgets/TitleTextWidget.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/constants/AppString.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);

    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: AppDevicesUtils.getAppBarHeight() + 60),

          TitleTextWidget(dark: dark),

          const SizedBox(height: AppSizes.spaceBtwSections),
          LoginWidget(
            dark: dark,
          ),
          const SizedBox(height: AppSizes.spaceBtwSections + 15),
          LoginDividerWidget(dark: dark),
          const SizedBox(
            height: AppSizes.inputFieldRadius + 5,
          ),
          const SocialButton(),
          const SizedBox(
            height: AppSizes.spaceBtwSections + 25,
          ),
          LoginBottom(
            dark: dark,
            buttonText: AppStrings.signUP,
            textMain: AppStrings.donothave,
          ),

          const SizedBox(
            height: AppSizes.spaceBtwSections + 25,
          ),
        ],
      ),
    )));
  }
}

