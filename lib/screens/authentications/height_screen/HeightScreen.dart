import 'package:fitness/screens/authentications/height_screen/widgets/InputWidget.dart';
import 'package:fitness/screens/authentications/height_screen/widgets/UnitWidget.dart';
import 'package:fitness/screens/authentications/weight_screen/WeightScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitness/common/widgets/ButtonWidget.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';

import '../../../utils/constants/AppString.dart';
import '../../authentication_controllers/HeightScreenController.dart';
import '../../shared_preferences/UserPreferences.dart';

class HeightScreen extends StatelessWidget {
  const HeightScreen({super.key, required this.email, required this.password, required this.gender, required this.name, required this.year, });

  final String email , password , gender , name ;
  final int year;

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);
    final HeightScreenController heightScreenController = Get.put(HeightScreenController());
    _checkStoredData();

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
                onPressed: () async {
                  String message;

                  // Validate the input and show a Snackbar with the value
                  if (heightScreenController.isSelected('Cm')) {
                    final cmText = heightScreenController.cmController.text;

                    // Check if cmText is empty or not a valid number
                    if (cmText.isNotEmpty && double.tryParse(cmText) != null) {
                      message = "Your height: $cmText cm";
                      MyAppHelperFunctions.showSnackBar(message);
                      await UserPreferences.saveUserData(
                        email: email,
                        password: password,
                        gender: gender,
                        name: name,
                        age: year, // Set age based on the selected year
                        height: cmText+ "cm", // To be filled later
                        weight: '', // To be filled later
                        targetWeight: '', // To be filled later
                        mainGoal: '',
                      );

                      Get.to(WeightScreen(
                        email: email,
                        password: password,
                        gender: gender,
                        name: name,
                        year: year, height: cmText +"ft",
                      ));
                    } else {
                      MyAppHelperFunctions.showSnackBar("Please enter a valid height in cm");
                    }
                  } else if (heightScreenController.isSelected('Ft')) {
                    final ftText = heightScreenController.ftController.text;
                    final inchText = heightScreenController.inchController.text;

                    // Check if ftText and inchText are not empty and are valid numbers
                    if (ftText.isNotEmpty &&
                        inchText.isNotEmpty &&
                        double.tryParse(ftText) != null &&
                        double.tryParse(inchText) != null) {
                      message = "Your height: $ftText ft $inchText inch";
                      MyAppHelperFunctions.showSnackBar(message);
                      await UserPreferences.saveUserData(
                        email: email,
                        password: password,
                        gender: gender,
                        name: name,
                        age: year, // Set age based on the selected year
                        height: ftText +"ft"  +" "+ inchText +"inch", // To be filled later
                        weight: '', // To be filled later
                        targetWeight: '', // To be filled later
                        mainGoal: '',
                      );
                      Get.to(WeightScreen(
                        email: email,
                        password: password,
                        gender: gender,
                        name: name,
                        year: year, height: ftText +"ft"+ inchText +"inch",
                      ));
                    } else {
                      MyAppHelperFunctions.showSnackBar("Please enter valid height in feet and inches");
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: AppSizes.appBarHeight -20),
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

