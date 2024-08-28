import 'package:fitness/common/widgets/TextInputWidget.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/ButtonWidget.dart';
import '../../../utils/constants/AppSizes.dart';
import '../../../utils/constants/AppString.dart';
import '../../authentication_controllers/NameScreenController.dart';
import '../../shared_preferences/UserPreferences.dart';

class NameScreen extends StatelessWidget {
  const NameScreen({super.key, required this.email, required this.password, required this.gender});

  final String email , password , gender;

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);
    _checkStoredData();

    NameScreenController nameScreenController = Get.put(NameScreenController());
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 110,
        padding: const EdgeInsets.only(bottom: 40),
        color: Colors.transparent,
        child: Obx(() => Opacity(
          opacity: nameScreenController.isNameEntered.value ? 1.0 : 0.4,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 28),
            child: ButtonWidget(
              dark: dark,
              onPressed: () {

                nameScreenController.getName(gender ,password ,email);
              },
              buttonText: AppStrings.next,
            ),
          ),
        )),
      ),
      resizeToAvoidBottomInset: true, // Helps resize the screen when the keyboard is displayed
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: AppSizes.appBarHeight -20),
                Text(
                  AppStrings.signUP,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(height: 79),
                Text(
                  AppStrings.textName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                SizedBox(height: AppDevicesUtils.getScreenWidth(context) * 0.5),
                Obx(() => Opacity(
                  opacity: nameScreenController.isNameEntered.value ? 1.0 : 0.4,
                  child: TextInputWidget(
                      hintText: 'First Name',
                      focusNode: nameScreenController.focusNode, // Pass focus node
                      controller: nameScreenController.nameController,
                      dark: dark
                  ),
                )),
                const SizedBox(height: 20),
              ],
            ),
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

