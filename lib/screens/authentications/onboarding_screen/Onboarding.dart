import 'package:fitness/screens/authentications/login_screen/LoginScreen.dart';
import 'package:fitness/screens/authentications/onboarding_screen/widget/ImageWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitness/screens/authentications/controller/OnboardingScreenController.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/constants/AppImagePaths.dart';
import 'package:fitness/utils/constants/AppString.dart';
import '../../../common/widgets/ButtonWidget.dart';
import '../../../utils/helpers/MyAppHelper.dart';
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    final dark = MyAppHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ImageWidget(),
            Positioned(
              bottom: 80, // Position the button from the bottom
              left: 0,
              right: 6, // Align the button horizontally centered
              child:
              Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 16.0), // Add padding to the left and right
                child: ButtonWidget(dark: dark  , onPressed: () {Get.offAll(const LoginScreen());}, buttonText: AppStrings.startfitess,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



