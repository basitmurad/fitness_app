// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:fitness/common/widgets/ButtonWidget.dart';
// import 'package:fitness/utils/constants/AppColor.dart';
// import 'package:fitness/utils/constants/AppDevicesUtils.dart';
// import 'package:fitness/utils/constants/AppSizes.dart';
// import 'package:fitness/utils/constants/AppString.dart';
// import 'package:fitness/utils/helpers/MyAppHelper.dart';
// import '../../authentication_controllers/SelectGenderController.dart';
// import '../../shared_preferences/UserPreferences.dart';
// import '../name_screen/NameScreen.dart';
//
// class SelectGenderScreen extends StatelessWidget {
//   const SelectGenderScreen(
//       {super.key, required this.email, required this.password});
//
//   final String email;
//   final String password;
//
//   @override
//   Widget build(BuildContext context) {
//     final dark = MyAppHelperFunctions.isDarkMode(context);
//     final SelectGenderController selectGenderController = Get.put(SelectGenderController());
//
//     _checkStoredData();
//
//     return Scaffold(
//       bottomNavigationBar: BottomAppBar(
//           height: 110,
//           padding: const EdgeInsets.only(bottom: 40),
//           color: Colors.transparent,
//           child:         Obx(() {
//             final opacity = selectGenderController.isGenderSelected.value ? 0.9 : 0.1;
//             return Opacity(
//               opacity: opacity,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 28),
//                 child: ButtonWidget(
//                   dark: dark,
//                   onPressed: opacity >= 0.9
//                       ? () async {
//
//
//
//                     final selectedGender = selectGenderController.selectedGender.value;
//                     await UserPreferences.saveUserData(
//                       email: email,
//                       password: password,
//                       gender: selectedGender,
//                       name: '', // Pass an empty string or handle name as needed
//                       age: 0, // Provide default values or handle them as needed
//                       height: '',
//                       weight: '',
//                       targetWeight: '',
//                       mainGoal: '',
//                     );
//                     // Navigate to NameScreen
//                     Get.to(() => NameScreen(email: email, password: password, gender: selectedGender,));
//
//                   }
//                       : (){
//                     MyAppHelperFunctions.showSnackBar('Select Gender');
//                   }, // Disable button when opacity < 0.9
//                   buttonText: AppStrings.next,
//                 ),
//               ),
//             );
//           }),
//
//
//
//       ),    body: SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const SizedBox(
//                   height: AppSizes.appBarHeight - 20,
//                 ),
//                 Text(
//                   AppStrings.signUP,
//                   textAlign: TextAlign.center,
//                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       fontWeight: FontWeight.w700, fontSize: 16),
//                 ),
//                 const SizedBox(
//                   height: AppSizes.spaceBtwItems + 30,
//                 ),
//                 SizedBox(
//                   height: AppDevicesUtils.getScreenHeight() * 0.25,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           selectGenderController.selectGender('Female');
//                         },
//                         child: Obx(() => AnimatedOpacity(
//                           opacity: selectGenderController.selectedGender.value == 'Female' ? 1.0 : 0.4,
//                           duration: const Duration(milliseconds: 300),
//                           child: Container(
//                             height: 117,
//                             width: 167,
//                             decoration: BoxDecoration(
//                               color: selectGenderController.selectedGender.value == 'Female' ? AppColor.orangeColor : Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.2),
//                                   spreadRadius: 2,
//                                   blurRadius: 5,
//                                   offset: const Offset(2, 4),
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'Female',
//                                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                                       color: selectGenderController.selectedGender.value == 'Female' ? Colors.white : dark ? AppColor.white : AppColor.black,
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                                 const SizedBox(width: 4),
//                                 Icon(
//                                   Icons.female,
//                                   size: 44,
//                                   color: selectGenderController.selectedGender.value == 'Female' ? Colors.white : dark ? AppColor.white : AppColor.black,
//                                 )
//                               ],
//                             ),
//                           ),
//                         )),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           selectGenderController.selectGender('Male');
//                         },
//                         child: Obx(() => AnimatedOpacity(
//                           opacity: selectGenderController.selectedGender.value == 'Male' ? 1.0 : 0.4,
//                           duration: const Duration(milliseconds: 300),
//                           child: Container(
//                             height: 117,
//                             width: 167,
//                             decoration: BoxDecoration(
//                               color: selectGenderController.selectedGender.value == 'Male' ? AppColor.orangeColor : Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.2),
//                                   spreadRadius: 2,
//                                   blurRadius: 5,
//                                   offset: const Offset(2, 4),
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'Male',
//                                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                                       color: selectGenderController.selectedGender.value == 'Male' ? Colors.white : dark ? AppColor.white : AppColor.black,
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                                 const SizedBox(width: 4),
//                                 Icon(
//                                   Icons.male,
//                                   size: 44,
//                                   color: selectGenderController.selectedGender.value == 'Male' ? Colors.white : dark ? AppColor.white : AppColor.black,
//                                 )
//                               ],
//                             ),
//                           ),
//                         )),
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _checkStoredData() async {
//     try {
//       final userData = await UserPreferences.getUserData();
//
//       if (userData.isEmpty) {
//         debugPrint('No user data found.');
//       } else {
//         debugPrint('User data found:');
//         debugPrint('Email: ${userData[UserPreferences.emailKey]}');
//         debugPrint('Password: ${userData[UserPreferences.passwordKey]}');
//         debugPrint('Gender: ${userData[UserPreferences.genderKey]}');
//         debugPrint('Name: ${userData[UserPreferences.nameKey]}');
//         debugPrint('Age: ${userData[UserPreferences.ageKey]}');
//         debugPrint('Height: ${userData[UserPreferences.heightKey]}');
//         debugPrint('Weight: ${userData[UserPreferences.weightKey]}');
//         debugPrint('Target Weight: ${userData[UserPreferences.targetWeightKey]}');
//         debugPrint('Main Goal: ${userData[UserPreferences.mainGoalKey]}');
//       }
//     } catch (e) {
//       debugPrint('Error retrieving user data: ${e.toString()}');
//     }
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitness/common/widgets/ButtonWidget.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/constants/AppString.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import '../../authentication_controllers/SelectGenderController.dart';
import '../../shared_preferences/UserPreferences.dart';
import '../name_screen/NameScreen.dart';
import 'package:firebase_database/firebase_database.dart';

class SelectGenderScreen extends StatelessWidget {
  const SelectGenderScreen({super.key, required this.email, required this.password});

  final String email;
  final String password;

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);
    final SelectGenderController selectGenderController = Get.put(SelectGenderController());

    _checkStoredData();

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 110,
        padding: const EdgeInsets.only(bottom: 40),
        color: Colors.transparent,
        child: Obx(() {
          final opacity = selectGenderController.isGenderSelected.value ? 0.9 : 0.1;
          return Opacity(
            opacity: opacity,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 28),
              child: ButtonWidget(
                dark: dark,
                onPressed: opacity >= 0.9
                    ? () async {
                  final selectedGender = selectGenderController.selectedGender.value;
                  await UserPreferences.saveUserData(
                    email: email,
                    password: password,
                    gender: selectedGender,
                    name: '',
                    age: 0,
                    height: '',
                    weight: '',
                    targetWeight: '',
                    mainGoal: '',
                  );

                  // Upload gender to Firebase Realtime Database
                  await _uploadGenderToFirebase(selectedGender);

                  // Navigate to NameScreen
                  Get.to(() => NameScreen(email: email, password: password, gender: selectedGender));
                }
                    : () {
                  MyAppHelperFunctions.showSnackBar('Select Gender');
                },
                buttonText: AppStrings.next,
              ),
            ),
          );
        }),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSizes.appBarHeight - 20),
                Text(
                  AppStrings.signUP,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(height: AppSizes.spaceBtwItems + 30),
                SizedBox(height: AppDevicesUtils.getScreenHeight() * 0.25),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          selectGenderController.selectGender('Female');
                        },
                        child: Obx(() => AnimatedOpacity(
                          opacity: selectGenderController.selectedGender.value == 'Female' ? 1.0 : 0.4,
                          duration: const Duration(milliseconds: 300),
                          child: Container(
                            height: 117,
                            width: 167,
                            decoration: BoxDecoration(
                              color: selectGenderController.selectedGender.value == 'Female' ? AppColor.orangeColor : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(2, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Female',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: selectGenderController.selectedGender.value == 'Female' ? Colors.white : dark ? AppColor.white : AppColor.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.female,
                                  size: 44,
                                  color: selectGenderController.selectedGender.value == 'Female' ? Colors.white : dark ? AppColor.white : AppColor.black,
                                ),
                              ],
                            ),
                          ),
                        )),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          selectGenderController.selectGender('Male');
                        },
                        child: Obx(() => AnimatedOpacity(
                          opacity: selectGenderController.selectedGender.value == 'Male' ? 1.0 : 0.4,
                          duration: const Duration(milliseconds: 300),
                          child: Container(
                            height: 117,
                            width: 167,
                            decoration: BoxDecoration(
                              color: selectGenderController.selectedGender.value == 'Male' ? AppColor.orangeColor : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(2, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Male',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: selectGenderController.selectedGender.value == 'Male' ? Colors.white : dark ? AppColor.white : AppColor.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.male,
                                  size: 44,
                                  color: selectGenderController.selectedGender.value == 'Male' ? Colors.white : dark ? AppColor.white : AppColor.black,
                                ),
                              ],
                            ),
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
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


  Future<void> _uploadGenderToFirebase(String selectedGender) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    try {
      await databaseReference.child('users/$userId').update({
        'gender': selectedGender,
      });
      debugPrint('Gender updated in Firebase: $selectedGender');
    } catch (e) {
      debugPrint('Error updating gender: ${e.toString()}');
    }
  }
}
