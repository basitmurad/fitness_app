// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'package:fitness/screens/authentications/onboarding_screen/controller/OnboardingController.dart';
// import 'package:fitness/utils/constants/AppColor.dart';
// import 'package:fitness/utils/constants/AppDevicesUtils.dart';
// import 'package:fitness/utils/constants/AppSizes.dart';
// import 'package:fitness/utils/constants/AppImagePaths.dart';
// import 'package:fitness/utils/constants/AppString.dart';
//
// class OnboardingScreen extends StatelessWidget {
//   const OnboardingScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(OnboardingController());
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             top: 40,
//             child: Container(
//               width: AppDevicesUtils.screenWidth(),
//               height: AppDevicesUtils.getScreenHeight(),
//               alignment: Alignment.center,
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       alignment: Alignment.center,
//                       padding: const EdgeInsets.all(16),
//                       width: AppDevicesUtils.getScreenWidth(context) * 0.7,
//                       height: AppDevicesUtils.getScreenWidth(context) * 0.6566,
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: AppColor.infoq,
//                         image: DecorationImage(
//                           image: AssetImage(AppImagePaths.onboardingImage),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: AppSizes.spaceBtwSections),
//                     Text(
//                       'Welcome to Fitness',
//                       style: Theme.of(context).textTheme?.labelLarge?.copyWith(
//                         fontSize: 24,
//                         fontFamily: 'Poppins',
//                         fontWeight: FontWeight.w300,
//                       ),
//                     ),
//                     const SizedBox(height: AppSizes.inputFieldRadius),
//                     Text(
//                       AppStrings.connectCompelete,
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: AppSizes.spaceBtwSections + 40),
//                     SizedBox(
//                       width: AppDevicesUtils.getScreenWidth(context) * 0.87,
//                       height: AppDevicesUtils.getScreenWidth(context)* 0.15,
//                       child: ElevatedButton(
//                         onPressed: () {},
//                         child: const Text('Start Your Fitness Journey' ,style: TextStyle(fontWeight: FontWeight.w400),),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fitness/screens/authentications/onboarding_screen/controller/OnboardingController.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/constants/AppImagePaths.dart';
import 'package:fitness/utils/constants/AppString.dart';

import '../../../utils/helpers/MyAppHelper.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    final dark = MyAppHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            top: 40,
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
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.infoq,
                        image: const DecorationImage(
                          image: AssetImage(AppImagePaths.onboardingImage),

                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwSections),
                    Text(
                      'Welcome to Fitness',
                      style: Theme.of(context).textTheme?.labelLarge?.copyWith(
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: AppSizes.inputFieldRadius),
                    Text(
                      AppStrings.connectCompelete,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSizes.spaceBtwSections + 40),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 80, // Position the button from the bottom
            left: 12,
            right: 12,
            child: SizedBox(
              width: AppDevicesUtils.getScreenWidth(context) * 0.5,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                child:  Text('Start Your Fitness Journey ' ,style: Theme.of(context).textTheme.labelLarge!.copyWith(color: dark ? AppColor.white : AppColor.white, )) , ),
              ),
            ),

        ],
      ),
    );
  }
}
