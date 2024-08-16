import 'package:fitness/screens/authentications/onboarding_screen/controller/OnboardingController.dart';
import 'package:fitness/screens/authentications/onboarding_screen/widget/OnboardingSkip.dart';
import 'package:fitness/screens/authentications/onboarding_screen/widget/OnbooardingPages.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:fitness/utils/constants/AppString.dart';
import 'package:fitness/utils/constants/ImagePaths.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../utils/constants/AppSizes.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
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
          )
          ,

          OnboardingSkip(),

      Positioned(
          bottom: AppDevicesUtils.getBottomNavigationHeight() ,
          right: AppSizes.defaultSpace,
          child: ElevatedButton(

            style: ElevatedButton.styleFrom(

                shape: CircleBorder() ),
            onPressed: (){


            }, child: Icon(Icons.navigate_next),))
        ],
      ),
    );
  }
}

// Container(
//
//   margin: EdgeInsets.only(right: 20),
//   alignment: Alignment.center,
//   width: 55.0, // Width of the oval
//   height: 25.0, // Height of the oval
//   decoration: BoxDecoration(
//     color: Colors.white, // Background color
//     borderRadius: BorderRadius.circular(30.0), // Border radius for oval shape
//     border: Border.all(
//       color: Colors.grey, // Stroke color
//       width:1.5, // Stroke width
//     ),
//   ),
//   child: Center(
//     child: Text(
//       'Skip',
//       style: TextStyle(
//         fontSize: 12.0, // Text size
//         color: Colors.black, // Text color
//       ),
//     ),
//   ),
// ),
// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//     // Left Button
//     Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Container(
//         width: 60.0,
//         height: 25.0,
//         decoration: BoxDecoration(
//           color: Colors.blue,
//           borderRadius: BorderRadius.circular(25.0),
//         ),
//         child: const Center(
//           child: Text(
//             'back',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//     ),
//     // Right Button
//     Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Container(
//         width: 60.0,
//         height: 25.0,
//         decoration: BoxDecoration(
//           color: Colors.red,
//           borderRadius: BorderRadius.circular(25.0),
//         ),
//         child: const Center(
//           child: Text(
//             'Skip',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//     ),
//   ],
// ),
