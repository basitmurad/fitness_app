import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../utils/constants/AppDevicesUtils.dart';
import '../../../../utils/constants/AppSizes.dart';

class OnboardingPages extends StatelessWidget {
  const OnboardingPages({
    super.key, required this.title, required this.subtitle, required this.imagePath,
  });

  final String title,subtitle, imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        children: [

          SizedBox(height: 70,),

          Image(
              height: AppDevicesUtils.screenWidth() * 0.8,
              width: AppDevicesUtils.screenWidth() * 0.6,
              image: AssetImage(imagePath)),

          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: AppSizes.spaceBtwItems,
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          )

        ],
      ),
    );
  }
}
