import 'package:fitness/screens/authentications/onboarding_screen/controller/OnboardingController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/AppDevicesUtils.dart';
import '../../../../utils/constants/AppSizes.dart';

class OnboardingNext extends StatelessWidget {
  const OnboardingNext({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: AppDevicesUtils.getBottomNavigationHeight() ,
        right: AppSizes.defaultSpace,
        child: ElevatedButton(

          style: ElevatedButton.styleFrom(

              shape: CircleBorder() ),
          onPressed: () =>OnboardingController.instance.nextPage(), child: Icon(Icons.navigate_next),));
  }
}
