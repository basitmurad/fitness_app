import 'package:fitness/screens/authentications/controller/OnboardingScreenController.dart';
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
        bottom: AppDevicesUtils.getBottomNavigationHeight(),
        right: AppSizes.defaultSpace,
        child:
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent, shape: const CircleBorder()),
          onPressed: () => OnboardingController.instance.nextPage(),
          child: const Icon(Icons.navigate_next),
        ));






  }
}


