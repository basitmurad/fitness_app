// import 'package:fitness/screens/authentications/body_focus_screen/widget/ImageWidgetBody.dart';
// import 'package:fitness/screens/authentications/body_focus_screen/widget/SelectableCard.dart';
// import 'package:fitness/screens/authentications/select_exercise_screen/SelectExerciseScreen.dart';
// import 'package:fitness/utils/constants/AppDevicesUtils.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../common/widgets/ButtonWidget.dart';
// import '../../../utils/constants/AppImagePaths.dart';
// import '../../../utils/constants/AppSizes.dart';
// import '../../../utils/constants/AppString.dart';
// import '../../../utils/helpers/MyAppHelper.dart';
// import '../../authentication_controllers/BodyFocusScreenController.dart';
// import '../../shared_preferences/UserPreferences.dart';
//
// class BodyFocusScreen extends StatelessWidget {
//   const BodyFocusScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final dark = MyAppHelperFunctions.isDarkMode(context);
//
//     final cardLabels = [
//       'Full Body',
//       'Arm',
//       'Chest',
//       'Abs',
//       'Legs',
//     ];
//
//
//     // Initialize the controller
//     final BodyFocusScreenController controller =
//         Get.put(BodyFocusScreenController());
//
//     return Scaffold(
//       bottomNavigationBar: Obx(() {
//         // Determine opacity based on whether any card is selected
//         final opacity = controller.anyCardSelected ? 0.9 : 0.1;
//         return Opacity(
//           opacity: opacity,
//           child: Padding(
//             padding: const EdgeInsets.only(bottom: 40),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
//               child: ButtonWidget(
//                 dark: dark,
//                 onPressed: () {
//
//                   Get.to(SelectExerciseScreen());
//                   // Handle button press
//                 },
//                 buttonText: AppStrings.next,
//               ),
//             ),
//           ),
//         );
//       }),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(height: AppSizes.appBarHeight),
//               Text(
//                 textAlign: TextAlign.center,
//                 AppStrings.textFocus,
//                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 16,
//                     ),
//               ),
//               const SizedBox(height: AppSizes.appBarHeight + 20),
//               SizedBox(
//                 height: AppDevicesUtils.getScreenHeight() * 0.5,
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Obx(() {
//                         return Container(
//                           margin: EdgeInsets.only(top: 50),
//                           height: 500,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: List.generate(5, (index) {
//                               return SelectableCard(
//                                 selected: controller.isCardSelected(index),
//                                 onTap: () =>
//                                     controller.toggleCardSelection(index),
//                                 label: cardLabels[index],
//                               );
//                             }),
//                           ),
//                         );
//                       }),
//                     ),
//                     const SizedBox(width: 1),
//                      Expanded(
//                       child: ImageWidgetBody(imageUrl: AppImagePaths.femaleBody),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// Future<String> _getUserGender() async {
//   try {
//     final userData = await UserPreferences.getUserData();
//     return userData[UserPreferences.genderKey] ?? 'unknown';
//   } catch (e) {
//     debugPrint('Error retrieving user gender: ${e.toString()}');
//     return 'unknown';
//   }
// }
//
// void _checkStoredData() async {
//   try {
//     final userData = await UserPreferences.getUserData();
//
//     if (userData.isEmpty) {
//       debugPrint('No user data found.');
//     } else {
//       debugPrint('User data found:');
//       debugPrint('Email: ${userData[UserPreferences.emailKey]}');
//       debugPrint('Password: ${userData[UserPreferences.passwordKey]}');
//       debugPrint('Gender: ${userData[UserPreferences.genderKey]}');
//       debugPrint('Name: ${userData[UserPreferences.nameKey]}');
//       debugPrint('Age: ${userData[UserPreferences.ageKey]}');
//       debugPrint('Height: ${userData[UserPreferences.heightKey]}');
//       debugPrint('Weight: ${userData[UserPreferences.weightKey]}');
//       debugPrint('Target Weight: ${userData[UserPreferences.targetWeightKey]}');
//       debugPrint('Main Goal: ${userData[UserPreferences.mainGoalKey]}');
//     }
//   } catch (e) {
//     debugPrint('Error retrieving user data: ${e.toString()}');
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/ButtonWidget.dart';
import '../../../utils/constants/AppDevicesUtils.dart';
import '../../../utils/constants/AppImagePaths.dart';
import '../../../utils/constants/AppSizes.dart';
import '../../../utils/constants/AppString.dart';
import '../../../utils/helpers/MyAppHelper.dart';
import '../../authentication_controllers/BodyFocusScreenController.dart';
import '../../shared_preferences/UserPreferences.dart';
import '../select_exercise_screen/SelectExerciseScreen.dart';
import 'widget/ImageWidgetBody.dart';
import 'widget/SelectableCard.dart';

class BodyFocusScreen extends StatelessWidget {
  const BodyFocusScreen({super.key, required this.email, required this.password, required this.gender, required this.name, required this.height, required this.currentWeight, required this.targetWeight, required this.year, required this.goal});
  final String email , password , gender , name , height  ,currentWeight ,targetWeight ,goal;
  final int year;
  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);
    final String imageUrl = gender.toLowerCase() == 'female'
        ? AppImagePaths.femaleBody
        : AppImagePaths.maleBody;
    final cardLabels = ['Full Body', 'Arm', 'Chest', 'Abs', 'Legs'];

    // Initialize the controller
    final BodyFocusScreenController controller = Get.put(
        BodyFocusScreenController());
    _checkStoredData();

    return Scaffold(
      bottomNavigationBar: Obx(() {
        final opacity = controller.anyCardSelected ? 0.9 : 0.1;
        return Opacity(
          opacity: opacity,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
              child: ButtonWidget(
                dark: dark,
                onPressed: () {
                  if (controller.anyCardSelected) {
                    Get.to(SelectExerciseScreen());
                  } else {
                    MyAppHelperFunctions.showSnackBar(
                        'Please select a body focus.');
                  }
                },
                buttonText: AppStrings.next,
              ),
            ),
          ),
        );
      }),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSizes.appBarHeight),
              Text(
                textAlign: TextAlign.center,
                AppStrings.textFocus,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: AppSizes.appBarHeight + 20),
              SizedBox(
                height: AppDevicesUtils.getScreenHeight() * 0.5,
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(() {
                        return Container(
                          margin: EdgeInsets.only(top: 50),
                          height: 500,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              return SelectableCard(
                                selected: controller.isCardSelected(index),
                                onTap: () =>
                                    controller.toggleCardSelection(index),
                                label: cardLabels[index],
                              );
                            }),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(width: 1),
                    Expanded(
                      child: ImageWidgetBody(imageUrl: imageUrl),
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

void _checkStoredData() async {
  try {
    final userData = await UserPreferences.getUserData();

    if (userData.isEmpty) {
      debugPrint('No user data found.');
    } else {
      debugPrint('User data found:');
      debugPrint('Email: ${userData[UserPreferences.emailKey]}');
      debugPrint('Password: ${userData[UserPreferences.passwordKey]}');
      debugPrint('Gender: ${userData[UserPreferences.genderKey]}');
      debugPrint('Name: ${userData[UserPreferences.nameKey]}');
      debugPrint('Age: ${userData[UserPreferences.ageKey]}');
      debugPrint('Height: ${userData[UserPreferences.heightKey]}');
      debugPrint('Weight: ${userData[UserPreferences.weightKey]}');
      debugPrint('Target Weight: ${userData[UserPreferences.targetWeightKey]}');
      debugPrint('Main Goal: ${userData[UserPreferences.mainGoalKey]}');
    }
  } catch (e) {
    debugPrint('Error retrieving user data: ${e.toString()}');
  }
}

