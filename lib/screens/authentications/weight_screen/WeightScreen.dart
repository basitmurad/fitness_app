// // import 'package:fitness/utils/helpers/MyAppHelper.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// //
// // import '../../../common/widgets/ButtonWidget.dart';
// // import '../../../utils/constants/AppColor.dart';
// // import '../../../utils/constants/AppSizes.dart';
// // import '../../../utils/constants/AppString.dart';
// // import '../height_screen/widgets/InputWidget.dart';
// // import '../height_screen/widgets/UnitWidget.dart';
// //
// // class WeightScreen extends StatelessWidget {
// //   const WeightScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //
// //     final dark = MyAppHelperFunctions.isDarkMode(context);
// //     return   Scaffold(
// //       resizeToAvoidBottomInset: true,
// //       bottomNavigationBar:
// //       Padding(
// //           padding: const EdgeInsets.only(bottom: 40),
// //           child: Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
// //             child: ButtonWidget(
// //               dark: dark,
// //               onPressed: () {
// //                 String message;
// //
// //
// //                 // Handle further actions after showing the Snackbar
// //               },
// //               buttonText: AppStrings.next,
// //
// //           ),
// //         ),
// //       ),
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           child: Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
// //             child: Center(
// //               child: Column(
// //                 children: [
// //                   const SizedBox(height: AppSizes.appBarHeight),
// //                   Text(
// //                     textAlign: TextAlign.center,
// //                     AppStrings.signUP,
// //                     style: Theme.of(context)
// //                         .textTheme
// //                         .bodyMedium!
// //                         .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
// //                   ),
// //                   const SizedBox(height: 79),
// //                   Text(
// //                     textAlign: TextAlign.center,
// //                     AppStrings.textHeight,
// //                     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
// //                         fontFamily: 'Poppins',
// //                         fontWeight: FontWeight.w500,
// //                         fontSize: 16),
// //                   ),
// //                   const SizedBox(height: AppSizes.appBarHeight - 20),
// //                   Container(
// //                     alignment: Alignment.center,
// //                     width: 110,
// //                     height: 45,
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(20),
// //                       border: Border.all(width: 1, color: Colors.transparent),
// //                     ),
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         GestureDetector(
// //                           child: UnitWidget(
// //                             dark: dark,
// //                             unitText: 'Kg',
// //                             rotationAngle: 3.15, color: Colors.blue, textColor: Colors.white,
// //                          // Default color
// //                           ),
// //                         ),
// //                         Container(
// //                           height: 35,
// //                           width: 1,
// //                           color: AppColor.grey,
// //                         ),
// //                         GestureDetector(
// //                           child:  UnitWidget(
// //                             unitText: 'Lbs',
// //                             dark: dark,
// //                             rotationAngle: 0,
// //                             color: dark
// //                                 ? AppColor.lightBlue // Color when selected
// //                                 : Colors.white,
// //                             textColor: dark
// //                                 ? Colors.white // Text color when selected
// //                                 : Colors.black, // Default color
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //
// //   }
// // }
// import 'package:fitness/screens/controller/WeightScreenController.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../common/widgets/ButtonWidget.dart';
// import '../../../utils/constants/AppColor.dart';
// import '../../../utils/constants/AppSizes.dart';
// import '../../../utils/constants/AppString.dart';
// import '../../../utils/helpers/MyAppHelper.dart';
// import '../height_screen/widgets/InputWidget.dart';
// import '../height_screen/widgets/UnitWidget.dart';
//
// class WeightScreen extends StatelessWidget {
//   WeightScreen({super.key});
//
//   final WeightScreenController weightController =
//   Get.put(WeightScreenController());
//
//   @override
//   Widget build(BuildContext context) {
//     final dark = MyAppHelperFunctions.isDarkMode(context);
//
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.only(bottom: 40),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//           child: Obx(() {
//             // Reactively update the ButtonWidget opacity
//             return Opacity(
//               opacity: weightController.opacity.value,
//               child: ButtonWidget(
//                 dark: dark,
//                 onPressed: () {
//                   // Handle further actions here
//                 },
//                 buttonText: AppStrings.next,
//               ),
//             );
//           }),
//         ),
//       ),
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
//                   const SizedBox(height: AppSizes.appBarHeight +32),
//                   Container(
//                     alignment: Alignment.center,
//                     width: 110,
//                     height: 45,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(width: 1, color: Colors.transparent),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Obx(() {
//                           // Update UnitWidget based on selected unit
//                           return GestureDetector(
//                             onTap: () => weightController.selectUnit('Kg'),
//                             child: Opacity(
//                               opacity: weightController.opacity.value,
//                               child: UnitWidget(
//                                 rotationAngle: 3.15,
//                                 dark: dark,
//                                 unitText: 'Kg',
//                                 color: weightController.isSelected('Kg')
//                                     ? AppColor.lightBlue // Color when selected
//                                     : Colors.white,
//                                 textColor: weightController.isSelected('Kg')
//                                     ? Colors.white // Text color when selected
//                                     : Colors.black,
//                               ),
//                             ),
//                           );
//                         }),
//                         Container(
//                           height: 35,
//                           width: 1,
//                           color: AppColor.grey,
//                         ),
//                         Obx(() {
//                           // Update UnitWidget based on selected unit
//                           return GestureDetector(
//                             onTap: () => weightController.selectUnit('Lbs'),
//                             child: Opacity(
//                               opacity: weightController.opacity.value,
//
//                               child: UnitWidget(
//                                 rotationAngle: 0,
//                                 dark: dark,
//                                 unitText: 'Lbs',
//                                 color: weightController.isSelected('Lbs')
//                                     ? AppColor.lightBlue // Color when selected
//                                     : Colors.white,
//                                 textColor: weightController.isSelected('Lbs')
//                                     ? Colors.white // Text color when selected
//                                     : Colors.black,
//                               ),
//                             ),
//                           );
//                         }),
//                       ],
//                     ),
//                   ),
//
//                   const SizedBox(height: AppSizes.appBarHeight +42),
//                   Obx(() {
//                     if (weightController.isSelected('Kg')) {
//                       return Opacity(
//                         opacity: weightController.opacity.value,
//                         child: InputWidget(
//                           dark: dark,
//                           focusNode: FocusNode(),
//                           editingController: weightController.kgController,
//                           opacity: weightController.opacity.value,
//                           ft: 'kg',
//                           onChanged: (String value) {},
//                         ),
//                       );
//                     } else if (weightController.isSelected('Lbs')) {
//                       return Opacity(
//                         opacity: weightController.opacity.value,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             InputWidget(
//                               dark: dark,
//                               focusNode: FocusNode(),
//                               editingController: weightController.lbsController,
//                               opacity: weightController.opacity.value,
//                               ft: 'Lbs',
//                               onChanged: (String value) {},
//                             ),
//                             const SizedBox(width: 10),
//                           ],
//                         ),
//                       );
//                     } else {
//                       return Container();
//                     }
//                   }),
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
import 'package:fitness/screens/authentications/target_weight_screen/TargetWeightScreen.dart';
import 'package:fitness/screens/controller/WeightScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/widgets/ButtonWidget.dart';
import '../../../utils/constants/AppColor.dart';
import '../../../utils/constants/AppSizes.dart';
import '../../../utils/constants/AppString.dart';
import '../../../utils/helpers/MyAppHelper.dart';
import '../height_screen/widgets/InputWidget.dart';
import '../height_screen/widgets/UnitWidget.dart';

class WeightScreen extends StatelessWidget {
  WeightScreen({super.key});

  final WeightScreenController weightController = Get.put(WeightScreenController());

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
          child: Obx(() {
            // Reactively update the ButtonWidget opacity
            return Opacity(
              opacity: weightController.opacity.value,
              child: ButtonWidget(
                dark: dark,
                onPressed: () {

                  Get.to(TargetWeightScreen());
                  // Handle further actions here
                },
                buttonText: AppStrings.next,
              ),
            );
          }),
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
                    AppStrings.textCurrentWeight,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  const SizedBox(height: AppSizes.appBarHeight +15),
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
                        Obx(() {
                          // Update UnitWidget based on selected unit
                          return GestureDetector(
                            onTap: () => weightController.selectUnit('Kg'),
                            child: Opacity(
                              opacity: weightController.opacity.value,
                              child: UnitWidget(
                                rotationAngle: 3.15,
                                dark: dark,
                                unitText: 'Kg',
                                color: weightController.isSelected('Kg')
                                    ? AppColor.lightBlue // Color when selected
                                    : Colors.white,
                                textColor: weightController.isSelected('Kg')
                                    ? Colors.white // Text color when selected
                                    : Colors.black,
                              ),
                            ),
                          );
                        }),
                        Container(
                          height: 35,
                          width: 1,
                          color: AppColor.grey,
                        ),
                        Obx(() {
                          // Update UnitWidget based on selected unit
                          return GestureDetector(
                            onTap: () => weightController.selectUnit('Lbs'),
                            child: Opacity(
                              opacity: weightController.opacity.value,
                              child: UnitWidget(
                                rotationAngle: 0,
                                dark: dark,
                                unitText: 'Lbs',
                                color: weightController.isSelected('Lbs')
                                    ? AppColor.lightBlue // Color when selected
                                    : Colors.white,
                                textColor: weightController.isSelected('Lbs')
                                    ? Colors.white // Text color when selected
                                    : Colors.black,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSizes.appBarHeight +35),
                  Obx(() {
                    if (weightController.isSelected('Kg')) {
                      return Opacity(
                        opacity: weightController.opacity.value,
                        child: InputWidget(
                          dark: dark,
                          focusNode: FocusNode(),
                          editingController: weightController.kgController,
                          opacity: weightController.opacity.value,
                          ft: 'kg',
                          onChanged: (String value) {},
                        ),
                      );
                    } else if (weightController.isSelected('Lbs')) {
                      return Opacity(
                        opacity: weightController.opacity.value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InputWidget(
                              dark: dark,
                              focusNode: FocusNode(),
                              editingController: weightController.lbsController,
                              opacity: weightController.opacity.value,
                              ft: 'Lbs',
                              onChanged: (String value) {},
                            ),
                            const SizedBox(width: 10),
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
