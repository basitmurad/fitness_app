import 'package:fitness/screens/authentications/onboarding_screen/controller/OnboardingController.dart';
import 'package:flutter/cupertino.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../utils/constants/AppColor.dart';
import '../../../../utils/constants/AppDevicesUtils.dart';
import '../../../../utils/constants/AppSizes.dart';

class OnboardingDot extends StatelessWidget {
  const OnboardingDot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    return Positioned(

        bottom: AppDevicesUtils.getBottomNavigationHeight(),
        left: AppSizes.defaultSpace,
        child: SmoothPageIndicator(
          onDotClicked: controller.dotNavigatorClick,
          controller: controller.pageController, count: 3,
          effect: const ExpandingDotsEffect(

              dotColor: AppColor.grey,

              activeDotColor: AppColor.buttonPrimary, dotHeight: 6),));
  }}


