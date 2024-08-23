import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/AppColor.dart';
import '../../../../utils/constants/AppDevicesUtils.dart';
import '../../../../utils/constants/AppImagePaths.dart';
import '../../../../utils/constants/AppSizes.dart';
import '../../../../utils/constants/AppString.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
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
                    image: AssetImage(AppImagePaths.onboardingImage1),
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
    );
  }
}
