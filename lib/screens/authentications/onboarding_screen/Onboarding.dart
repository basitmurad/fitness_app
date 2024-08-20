import 'package:fitness/screens/authentications/login_screen/LoginScreen.dart';
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
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            top: 40,
            right: 5,
            child: Container(
              width: AppDevicesUtils.screenWidth(),
              height: AppDevicesUtils.getScreenHeight(),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16),
                      width: AppDevicesUtils.getScreenWidth(context) * 0.7,
                      height: AppDevicesUtils.getScreenWidth(context) * 0.6566,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.infoq,
                        image: DecorationImage(
                          image: AssetImage(AppImagePaths.onboardingImage),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwSections),
                    Text(

                      AppStrings.welcomeText,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: AppSizes.inputFieldRadius),
                    Text(
                      AppStrings.connectComplete,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14 ,),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwSections + 40),
                  ],
                ),
              ),
            ),
          ),
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
    );
  }
}


