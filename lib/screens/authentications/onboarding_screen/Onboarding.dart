import 'package:fitness/screens/authentications/onboarding_screen/controller/OnboardingController.dart';
import 'package:fitness/screens/authentications/onboarding_screen/widget/OnboardingDot.dart';
import 'package:fitness/screens/authentications/onboarding_screen/widget/OnboardingNext.dart';
import 'package:fitness/screens/authentications/onboarding_screen/widget/OnboardingSkip.dart';
import 'package:fitness/screens/authentications/onboarding_screen/widget/OnbooardingPages.dart';
import 'package:fitness/utils/constants/AppString.dart';
import 'package:fitness/utils/constants/ImagePaths.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePage,
            children: [
              OnbooardingPages(
                title: AppStrings.pic1TextHeader,
                subtitle: AppStrings.pic1TextDetail,
                imagePath: ImagePaths.forgetillustration,
              ),
              OnbooardingPages(
                title: AppStrings.pic2TextHeader,
                subtitle: AppStrings.pic2TextDetail,
                imagePath: ImagePaths.forgetillustration,
              ),
              OnbooardingPages(
                title: AppStrings.pic3TextHeader,
                subtitle: AppStrings.pic3TextDetail,
                imagePath: ImagePaths.pic1,
              ),
            ],
          ),
          const OnboardingSkip(),
          const OnboardingDot(),
          const OnboardingNext()
        ],
      ),
    );
  }
}
