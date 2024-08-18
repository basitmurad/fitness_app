import 'package:fitness/screens/authentications/onboarding_screen/controller/OnboardingController.dart';
import 'package:fitness/screens/authentications/onboarding_screen/widget/OnboardingDot.dart';
import 'package:fitness/screens/authentications/onboarding_screen/widget/OnboardingNext.dart';
import 'package:fitness/screens/authentications/onboarding_screen/widget/OnboardingSkip.dart';
import 'package:fitness/screens/authentications/onboarding_screen/widget/OnboardingPages.dart';
import 'package:fitness/utils/constants/AppString.dart';
import 'package:fitness/utils/constants/AppImagePaths.dart';
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
        alignment: Alignment.center,
        children: [

          SizedBox(
            height: 60,
          ),
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePage,
            children: [
              OnboardingPages(
                title: AppStrings.pic1TextHeader,
                subtitle: AppStrings.pic1TextDetail,
                imagePath: AppImagePaths.forgetillustration,
              ),
              OnboardingPages(
                title: AppStrings.pic2TextHeader,
                subtitle: AppStrings.pic2TextDetail,
                imagePath: AppImagePaths.forgetillustration,
              ),
              OnboardingPages(
                title: AppStrings.pic3TextHeader,
                subtitle: AppStrings.pic3TextDetail,
                imagePath: AppImagePaths.pic1,
              ),
            ],
          ),
          const OnboardingSkip(),
          const OnboardingDot(),
          const OnboardingNext(),



        ],
      ),
    );
  }
}
