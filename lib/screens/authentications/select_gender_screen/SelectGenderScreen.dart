import 'package:fitness/common/snackbar/ShowSnackbar.dart';
import 'package:fitness/common/widgets/ButtonWidget.dart';
import 'package:fitness/screens/authentications/name_screen/NameScreen.dart';
import 'package:fitness/screens/authentications/select_gender_screen/widgets/GenderWidget.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/AppDevicesUtils.dart';
import '../../../utils/constants/AppImagePaths.dart';
import '../../../utils/constants/AppSizes.dart';
import '../../../utils/constants/AppString.dart';
import '../../../utils/helpers/MyAppHelper.dart';
import '../../authentication_controllers/SelectGenderController.dart';
import '../../shared_preferences/UserPreferences.dart';

class SelectGenderScreen extends StatelessWidget {
  const SelectGenderScreen(
      {super.key, required this.email, required this.password});

  final String email;

  final String password;

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);
    _checkStoredData();

    SelectGenderController selectGenderController =
        Get.put(SelectGenderController());
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 110,
        padding: const EdgeInsets.only(bottom: 40),
        color: Colors.transparent,
        child: Obx(() => Opacity(
              opacity: selectGenderController.selectedGender.value.isEmpty
                  ? 0.4
                  : 1.0,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 40, right: 40, top: 11, bottom: 11),
                // Systematic padding
                child: ButtonWidget(
                  dark: dark,
                  onPressed: () async {
                    if (selectGenderController
                        .selectedGender.value.isNotEmpty) {
                      await UserPreferences.saveUserData(
                        gender: selectGenderController.selectedGender.value,
                        email: email,
                        password: password,
                        name: '',
                        // To be filled later
                        age: 0,
                        // To be filled later
                        height: '',
                        // To be filled later
                        weight: '',
                        // To be filled later
                        targetWeight: '',
                        // To be filled later
                        mainGoal: '',
                      );

                      Get.to(NameScreen(
                        email: email,
                        password: password,
                        gender: selectGenderController.selectedGender.value,
                      ));
                    } else {
                      ShowSnackbar.showMessage(
                          title: 'Failed',
                          message: 'Please select you gender',
                          backgroundColor: AppColor.error);
                    }
                    selectGenderController.selectedGender.value;
                    // Define your onPressed logic here
                  },
                  buttonText: AppStrings.next,
                ),
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: AppSizes.appBarHeight - 20,
                ),
                Text(
                  AppStrings.signUP,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(
                  height: AppSizes.spaceBtwItems + 30,
                ),
                Container(
                  height: AppDevicesUtils.getScreenWidth(context) * 1.4,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: GenderWidget(
                            checkBoxText: AppStrings.male,
                            isMaleWidget: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Container(
                          child: GenderWidget(
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
