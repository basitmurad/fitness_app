// import 'package:fitness/screens/authentications/height_screen/widgets/InputWidget.dart';
// import 'package:fitness/screens/authentications/height_screen/widgets/UnitWidget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:fitness/common/widgets/ButtonWidget.dart';
// import 'package:fitness/screens/controller/HeightScreenController.dart';
// import 'package:fitness/utils/constants/AppColor.dart';
// import 'package:fitness/utils/constants/AppSizes.dart';
// import 'package:fitness/utils/helpers/MyAppHelper.dart';
//
// import '../../../utils/constants/AppString.dart';
//
// class HeightScreen extends StatelessWidget {
//   const HeightScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final dark = MyAppHelperFunctions.isDarkMode(context);
//     final HeightScreenController heightScreenController =
//         Get.put(HeightScreenController());
//
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       bottomNavigationBar: Obx(
//             () => Padding(
//           padding: const EdgeInsets.only(bottom: 40),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//             child: Opacity(
//               opacity: heightScreenController.opacity.value,
//               child: ButtonWidget(
//                 dark: dark,
//                 onPressed: () {
//                   // Handle the button press
//                 },
//                 buttonText: AppStrings.next,
//               ),
//             ),
//           ),
//         ),
//       ),
//
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//             child: Center(
//               child: Column(
//                 children: [
//                   const SizedBox(height: AppSizes.appBarHeight),
//                   Text(
//                     textAlign: TextAlign.center,
//                     AppStrings.signUP,
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyMedium!
//                         .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
//                   ),
//                   const SizedBox(height: 79),
//                   Text(
//                     textAlign: TextAlign.center,
//                     AppStrings.textHeight,
//                     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                         fontFamily: 'Poppins',
//                         fontWeight: FontWeight.w500,
//                         fontSize: 16),
//                   ),
//                   const SizedBox(height: AppSizes.appBarHeight - 20),
//                   Container(
//                     alignment: Alignment.center,
//                     width: 110,
//                     height: 45,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         border:
//                             Border.all(width: 1, color: Colors.transparent)),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         GestureDetector(
//                           onTap: () => heightScreenController.selectUnit('Cm'),
//                           child: Obx(() => Opacity(
//                               opacity: heightScreenController.opacity.value,
//
//                             child: UnitWidget(
//                                   dark: dark,
//                                   unitText: 'Cm',
//                                   rotationAngle: 3.15,
//                                   color: heightScreenController.isSelected('Cm')
//                                       ? AppColor.lightBlue // Color when selected
//                                       : Colors.white,
//                                   textColor: heightScreenController
//                                           .isSelected('Cm')
//                                       ? Colors.white // Text color when selected
//                                       : Colors.black, //// Default color
//                                 ),
//                           )),
//                         ),
//                         Container(
//                           height: 35,
//                           width: 1,
//                           color: AppColor.grey,
//                         ),
//                         GestureDetector(
//                           onTap: () => heightScreenController.selectUnit('Ft'),
//                           child: Obx(() => UnitWidget(
//                                 unitText: 'Ft',
//                                 dark: dark,
//                                 rotationAngle: 0,
//                                 color: heightScreenController.isSelected('Ft')
//                                     ? AppColor.lightBlue // Color when selected
//                                     : Colors.white,
//                                 textColor: heightScreenController
//                                         .isSelected('Ft')
//                                     ? Colors.white // Text color when selected
//                                     : Colors.black, //// Default color
//                               )),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: AppSizes.appBarHeight),
//                   Obx(() {
//                     if (heightScreenController.isSelected('Cm')) {
//                       return InputWidget(
//                         dark: dark,
//                         focusNode: FocusNode(),
//                         editingController: TextEditingController(),
//                         opacity: 1.0,
//                         ft: 'cm', onChanged: (String ) {  }, // Full opacity for selected unit
//                       );
//                     } else if (heightScreenController.isSelected('Ft')) {
//                       return Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           InputWidget(
//                             dark: dark,
//                             focusNode: FocusNode(),
//                             editingController: TextEditingController(),
//                             opacity: 1.0,
//                             ft: 'ft', onChanged: (String ) {  }, // Full opacity for feet
//                           ),
//                           const SizedBox(width: 10),
//                           InputWidget(
//                             dark: dark,
//                             focusNode: FocusNode(),
//                             editingController: TextEditingController(),
//                             opacity: 1.0,
//                             ft: 'inch', onChanged: (String ) {  },// Full opacity for inches
//                           ),
//                         ],
//                       );
//                     } else {
//                       return Container();
//                     }
//                   }),
//
//                   const SizedBox(height: AppSizes.appBarHeight + 30),
//
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
import 'package:fitness/screens/authentications/height_screen/widgets/InputWidget.dart';
import 'package:fitness/screens/authentications/height_screen/widgets/UnitWidget.dart';
import 'package:fitness/screens/authentications/weight_screen/WeightScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitness/common/widgets/ButtonWidget.dart';
import 'package:fitness/screens/controller/HeightScreenController.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';

import '../../../utils/constants/AppString.dart';

class HeightScreen extends StatelessWidget {
  const HeightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);
    final HeightScreenController heightScreenController = Get.put(HeightScreenController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Obx(
            () => Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Opacity(
              opacity: heightScreenController.opacity.value,
              child: ButtonWidget(
                dark: dark,
                onPressed: () {
                  String message;

                  // Validate the input and show a Snackbar with the value
                  if (heightScreenController.isSelected('Cm')) {
                    if (heightScreenController.cmController.text.isNotEmpty) {
                      message = "Your height: ${heightScreenController.cmController.text} cm";
                      MyAppHelperFunctions.showSnackBar(message);
                      Get.to(WeightScreen());
                    } else {
                      MyAppHelperFunctions.showSnackBar("Please enter your height in cm");
                    }
                  } else if (heightScreenController.isSelected('Ft')) {
                    if (heightScreenController.ftController.text.isNotEmpty && heightScreenController.inchController.text.isNotEmpty) {
                      message = "Your height: ${heightScreenController.ftController.text} ft ${heightScreenController.inchController.text} inch";
                      MyAppHelperFunctions.showSnackBar(message);
                    } else {
                      MyAppHelperFunctions.showSnackBar("Please enter your height in feet and inches");
                    }
                  }
                  // Handle further actions after showing the Snackbar
                },
                buttonText: AppStrings.next,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: AppSizes.appBarHeight),
                  Text(
                    textAlign: TextAlign.center,
                    AppStrings.signUP,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  const SizedBox(height: 79),
                  Text(
                    textAlign: TextAlign.center,
                    AppStrings.textHeight,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  const SizedBox(height: AppSizes.appBarHeight - 20),
                  Container(
                    alignment: Alignment.center,
                    width: 110,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.transparent),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => heightScreenController.selectUnit('Cm'),
                          child: Obx(() => Opacity(
                            opacity: heightScreenController.opacity.value,
                            child: UnitWidget(
                              dark: dark,
                              unitText: 'Cm',
                              rotationAngle: 3.15,
                              color: heightScreenController.isSelected('Cm')
                                  ? AppColor.lightBlue // Color when selected
                                  : Colors.white,
                              textColor: heightScreenController.isSelected('Cm')
                                  ? Colors.white // Text color when selected
                                  : Colors.black, // Default color
                            ),
                          )),
                        ),
                        
                        Container(
                          margin: EdgeInsets.all(2),
                          height: 35,
                          width: 1  ,
                          color: dark ? AppColor.white : AppColor.black.withOpacity(0.2),
                        ),
                        GestureDetector(
                          onTap: () => heightScreenController.selectUnit('Ft'),
                          child: Obx(() => Opacity(
                            opacity: heightScreenController.opacity.value,
                            child: UnitWidget(
                              unitText: 'Ft',
                              dark: dark,
                              rotationAngle: 0,
                              color: heightScreenController.isSelected('Ft')
                                  ? AppColor.lightBlue // Color when selected
                                  : Colors.white,
                              textColor: heightScreenController.isSelected('Ft')
                                  ? Colors.white // Text color when selected
                                  : Colors.black, // Default color
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSizes.appBarHeight),
                  Obx(() {
                    if (heightScreenController.isSelected('Cm')) {
                      return Opacity(
                        opacity: heightScreenController.opacity.value,
                        child: InputWidget(
                          dark: dark,
                          focusNode: FocusNode(),
                          editingController: heightScreenController.cmController,
                          opacity: heightScreenController.opacity.value,
                          ft: 'cm',
                          onChanged: (String value) {},
                        ),
                      );
                    } else if (heightScreenController.isSelected('Ft')) {
                      return Opacity(
                        opacity: heightScreenController.opacity.value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InputWidget(
                              dark: dark,
                              focusNode: FocusNode(),
                              editingController: heightScreenController.ftController,
                              opacity: heightScreenController.opacity.value,
                              ft: 'ft',
                              onChanged: (String value) {},
                            ),
                            const SizedBox(width: 10),
                            InputWidget(
                              dark: dark,
                              focusNode: FocusNode(),
                              editingController: heightScreenController.inchController,
                              opacity: heightScreenController.opacity.value,
                              ft: 'inch',
                              onChanged: (String value) {},
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
                  const SizedBox(height: AppSizes.appBarHeight + 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


