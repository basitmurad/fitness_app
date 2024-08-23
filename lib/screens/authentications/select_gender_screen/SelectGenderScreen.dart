import 'package:fitness/screens/authentications/controller/SelectGenderController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/AppColor.dart';
import '../../../utils/constants/AppDevicesUtils.dart';
import '../../../utils/constants/AppImagePaths.dart';
import '../../../utils/constants/AppSizes.dart';
import '../../../utils/constants/AppString.dart';
import '../../../utils/helpers/MyAppHelper.dart';

class SelectGenderScreen extends StatelessWidget {
  const SelectGenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              SizedBox(
                height: AppSizes.appBarHeight,
              ),
              Text(
                AppStrings.signUP,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              SizedBox(
                height: AppSizes.spaceBtwItems + 30,
              ),
              Container(
                height: AppDevicesUtils.getScreenWidth(context) * 1.4,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: GenderWidget(
                          imagePath: AppImagePaths.male,
                          checkBoxText: AppStrings.male,
                          isMaleWidget: true,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Container(
                        child: GenderWidget(
                          imagePath: AppImagePaths.female,
                          checkBoxText: AppStrings.female,
                          isMaleWidget: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class GenderWidget extends StatelessWidget {
  const GenderWidget({
    super.key,
    required this.imagePath,
    required this.checkBoxText,
    required this.isMaleWidget,
  });

  final String imagePath;
  final String checkBoxText;
  final bool isMaleWidget;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = MyAppHelperFunctions.isDarkMode(context);
    final SelectGenderController controller =
    Get.put(SelectGenderController()); // Retrieve existing instance

    return Stack(
      children: [
        // Background image with rotation
        Positioned(
          top: 80,
          left: 15,
          right: 25,
          bottom: 285,
          child: Obx(
                () => Visibility(
              visible: isMaleWidget ? controller.selectedGender.value == 'male' : controller.selectedGender.value == 'female',
              child: Transform.rotate(
                angle: 220,
                child: Image.asset(
                  'assets/myicons/back.png',
                  height: 120,
                  width: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        // Gender content
        Column(
          children: [
            Image.asset(
              imagePath,
              height: AppDevicesUtils.getScreenWidth(context) * 1,
              width: AppDevicesUtils.getScreenWidth(context) * 0.3,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  checkBoxText,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: isDarkMode ? AppColor.white : AppColor.textColor),
                ),
                Obx(
                      () => CustomRadioButton(
                    isSelected: isMaleWidget
                        ? controller.selectedGender.value == 'male'
                        : controller.selectedGender.value == 'female',
                    onTap: () {
                      controller.selectGender(isMaleWidget ? 'male' : 'female');
                    },
                    iconPath: isDarkMode
                        ? AppImagePaths.uncheckme
                        : AppImagePaths.uncheckme, // Unselected icon path
                    selectedIconPath: isDarkMode
                        ? AppImagePaths.checkDark
                        : AppImagePaths.checkLight, // Selected icon path
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class CustomRadioButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String iconPath;
  final String selectedIconPath;

  CustomRadioButton({
    required this.isSelected,
    required this.onTap,
    required this.iconPath,
    required this.selectedIconPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        isSelected ? selectedIconPath : iconPath,
        height: 17, // Adjust size as needed
        width: 17,  // Adjust size as needed
        fit: BoxFit.cover, // Adjust fit as needed
      ),
    );
  }
}


// class GenderWidget extends StatelessWidget {
//   const GenderWidget({
//     super.key,
//     required this.imagePath,
//     required this.checkBoxText,
//     required this.isMaleWidget, // Add this parameter to determine which radio button to toggle
//   });
//
//   final String imagePath;
//   final String checkBoxText;
//   final bool isMaleWidget;
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isDarkMode = MyAppHelperFunctions.isDarkMode(context);
//     final SelectGenderController controller =
//     Get.put(SelectGenderController()); // Retrieve existing instance
//
//     return Stack(
//       children: [
//         // Background image with rotation
//         Positioned(
//           top: 65,
//           left: 15,
//           right: 25,
//           bottom: 285,
//           child: Obx(
//                 () => Visibility(
//               visible: isMaleWidget ? controller.selectedGender.value == 'male' : controller.selectedGender.value == 'female',
//               child: Transform.rotate(
//                 angle: 0.009, // Rotate the image by 0.2 radians (approx. 11.5 degrees)
//                 child: Image.asset(
//                   'assets/myicons/back.png',
//                   height: 120,
//                   width: 90,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         // Gender content
//         Column(
//           children: [
//             Image.asset(
//               imagePath,
//               height: AppDevicesUtils.getScreenWidth(context) * 1,
//               width: AppDevicesUtils.getScreenWidth(context) * 0.3,
//             ),
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     checkBoxText,
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 16,
//                         color: isDarkMode ? AppColor.white : AppColor.textColor),
//                   ),
//                 ),
//                 Obx(
//                       () => Radio(
//                     value: isMaleWidget ? 'male' : 'female',
//                     groupValue: controller.selectedGender.value,
//                     onChanged: (String? value) {
//                       controller.selectGender(value!);
//                     },
//                     activeColor: isDarkMode ? Colors.white : Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }


// class GenderWidget extends StatelessWidget {
//   const GenderWidget({
//     super.key,
//     required this.imagePath,
//     required this.checkBoxText,
//     required this.isMaleWidget, // Add this parameter to determine which radio button to toggle
//   });
//
//   final String imagePath;
//   final String checkBoxText;
//   final bool isMaleWidget;
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isDarkMode = MyAppHelperFunctions.isDarkMode(context);
//     final SelectGenderController controller =
//     Get.put(SelectGenderController()); // Retrieve existing instance
//
//     return Stack(
//       children: [
//         // Background image
//         Positioned(
//           top: 80,
//           left: 15,
//           right: 25,
//           bottom: 285,
//           child: Obx(
//                 () => Visibility(
//               visible: isMaleWidget ? controller.selectedGender.value == 'male' : controller.selectedGender.value == 'female',
//               child: Image.asset(
//                 'assets/myicons/back.png',
//                 height: 120,
//                 width: 90,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         ),
//         // Gender content
//         Column(
//           children: [
//             Image.asset(
//               imagePath,
//               height: AppDevicesUtils.getScreenWidth(context) * 1,
//               width: AppDevicesUtils.getScreenWidth(context) * 0.3,
//             ),
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     checkBoxText,
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 16,
//                         color: isDarkMode ? AppColor.white : AppColor.textColor),
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Obx(
//                       () => Radio(
//                     value: isMaleWidget ? 'male' : 'female',
//                     groupValue: controller.selectedGender.value,
//                     onChanged: (String? value) {
//                       controller.selectGender(value!);
//                     },
//                     activeColor: isDarkMode ? Colors.white : Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
// class GenderWidget extends StatelessWidget {
//   const GenderWidget({
//     super.key,
//     required this.imagePath,
//     required this.checkBoxText,
//     required this.isMaleWidget, // Add this parameter to determine which checkbox to toggle
//   });
//
//   final String imagePath;
//   final String checkBoxText;
//   final bool isMaleWidget;
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isDarkMode = MyAppHelperFunctions.isDarkMode(context);
//     final SelectGenderController controller =
//     Get.put(SelectGenderController()); // Retrieve existing instance
//
//     return Stack(
//       children: [
//         // Background image
//         Positioned(
//           top: 80,
//           left: 5,
//           right: 15,
//           bottom: 270,
//           child: Obx(
//                 () => Visibility(
//               visible: isMaleWidget ? controller.isMaleChecked.value : controller.isFemaleChecked.value,
//               child: Image.asset(
//
//                 height: 120,
//                 width: 90,
//
//                 'assets/myicons/back.png',
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         ),
//         // Gender content
//         Column(
//           children: [
//             Image.asset(
//               imagePath,
//               height: AppDevicesUtils.getScreenWidth(context) * 1,
//               width: AppDevicesUtils.getScreenWidth(context) * 0.3,
//             ),
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     checkBoxText,
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 16,
//                         color: isDarkMode ? AppColor.white : AppColor.textColor),
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Obx(
//                       () => Checkbox(
//                     value: isMaleWidget
//                         ? controller.isMaleChecked.value
//                         : controller.isFemaleChecked.value,
//                     onChanged: (bool? value) {
//                       if (isMaleWidget) {
//                         controller.toggleMaleCheckbox();
//                       } else {
//                         controller.toggleFemaleCheckbox();
//                       }
//                     },
//                     activeColor: isDarkMode ? Colors.white : Colors.black,
//                     checkColor: isDarkMode ? Colors.black : Colors.white,
//                     side: BorderSide(
//                       color: isDarkMode ? Colors.white : Colors.black,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class GenderWidget extends StatelessWidget {
//   const GenderWidget({
//     super.key,
//     required this.imagePath,
//     required this.checkBoxText,
//     required this.isMaleWidget, // Add this parameter to determine which checkbox to toggle
//   });
//
//   final String imagePath;
//   final String checkBoxText;
//   final bool isMaleWidget;
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isDarkMode = MyAppHelperFunctions.isDarkMode(context);
//     final SelectGenderController controller =
//         Get.put(SelectGenderController()); // Retrieve existing instance
//
//     return Stack(
//       children :[ Column(
//         children: [
//
//           Positioned.fill(
//               top: 10,
//               bottom: 10,
//               left: 10,
//               right: 10,
//
//
//               child: Image(
//
//                 image: AssetImage('assets/myicons/back.png'),)),
//           Container(
//             margin: EdgeInsets.all(8),
//             child: Column(
//               children: [
//                 Image.asset(
//                   imagePath,
//                   height: AppDevicesUtils.getScreenWidth(context) * 1,
//                   width: AppDevicesUtils.getScreenWidth(context) * 0.3,
//                 ),
//                 SizedBox(height: 16),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         checkBoxText,
//                         textAlign: TextAlign.center,
//                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 16,
//                             color: isDarkMode ? AppColor.white : AppColor.textColor),
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                     Obx(
//                       () => Checkbox(
//                         value: isMaleWidget
//                             ? controller.isMaleChecked.value
//                             : controller.isFemaleChecked.value,
//                         onChanged: (bool? value) {
//                           if (isMaleWidget) {
//                             controller.toggleMaleCheckbox();
//                           } else {
//                             controller.toggleFemaleCheckbox();
//                           }
//                         },
//                         activeColor: isDarkMode ? Colors.white : Colors.black,
//                         checkColor: isDarkMode ? Colors.black : Colors.white,
//                         side: BorderSide(
//                           color: isDarkMode ? Colors.white : Colors.black,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ]
//     );
//   }
// }

// class CustomCheckbox extends StatelessWidget {
//   final String checkIconPath;
//   final bool isDarkMode;
//
//   CustomCheckbox({
//     required this.checkIconPath,
//     required this.isDarkMode,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // final SelectGenderController controller = Get.put(SelectGenderController());
//     final SelectGenderController controller = Get.find();
//
//     return Obx(
//           () => GestureDetector(
//         onTap: () {
//           controller.toggleCheckbox();
//         },
//         child: Image.asset(
//           controller.isChecked.value
//               ? (isDarkMode ? 'assets/myicons/iconwblack.png' : 'assets/myicons/iconwblack.png') // Checked icon based on theme
//               : (isDarkMode ? 'assets/myicons/iconwblack.png' : 'assets/myicons/iconwblack.png'), // Unchecked icon based on theme
//           // You can modify this to show a different icon if unchecked
//           height: 15,
//           width: 15,
//           fit: BoxFit.contain, // Ensure the image fits within the container
//         ),
//       ),
//     );
//   }
// }
