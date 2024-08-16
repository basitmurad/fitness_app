import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/AppDevicesUtils.dart';
import '../../../../utils/constants/AppSizes.dart';

class OnboardingSkip extends StatelessWidget {
  const OnboardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: AppDevicesUtils.getAppBarHeight(),
        right: AppSizes.defaultSpace,

        child: TextButton(onPressed: (){}, child: Text('Skip'),));
  }
}
