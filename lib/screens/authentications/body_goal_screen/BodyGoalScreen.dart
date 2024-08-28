import 'package:fitness/screens/authentications/body_focus_screen/BodyFocusScreen.dart';
import 'package:fitness/screens/authentications/body_goal_screen/widgets/buildCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/widgets/ButtonWidget.dart';
import '../../../utils/constants/AppImagePaths.dart';
import '../../../utils/constants/AppSizes.dart';
import '../../../utils/constants/AppString.dart';
import '../../../utils/helpers/MyAppHelper.dart';
import '../../authentication_controllers/BodyGoalScreenController.dart';
import '../../shared_preferences/UserPreferences.dart';

List<Map<String, dynamic>> cardDetails = [
  {"imagePath": AppImagePaths.lossWeight, "text": "Loss Weight"},
  {"imagePath": AppImagePaths.buildMuscle, "text": "Build Muscle"},
  {"imagePath": AppImagePaths.keepFit, "text": "Keep Fit"},
];

class BodyGoalScreen extends StatelessWidget {
  const BodyGoalScreen({super.key, required this.email, required this.password, required this.gender, required this.name, required this.height, required this.currentWeight, required this.targetWeight, required this.year});
  final String email , password , gender , name , height  ,currentWeight ,targetWeight;
  final int year;
  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);
    final BodyGoalScreenController controller = Get.put(BodyGoalScreenController());
    _checkStoredData();
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
          child: Obx(() {
            return Opacity(
              opacity: controller.isSelected.value ? 0.9 : 0.1,
              child: ButtonWidget(
                dark: dark,
                onPressed: () async {

                  if(controller.selectedIndex ==-1){
                    MyAppHelperFunctions.showSnackBar('Please select anyone');
                  }
                  else{
                    String goal =   controller.getSelectedGoalText();
                    await UserPreferences.saveUserData(
                      email: email,
                      password: password,
                      gender: gender,
                      name: name,
                      age: year, // Set age based on the selected year
                      height: height, // To be filled later
                      weight: currentWeight, // To be filled later
                      targetWeight: targetWeight, // To be filled later
                      mainGoal: goal,
                    );
                    Get.to( BodyFocusScreen(email: email, password: password, gender: gender, name: name, height: height, currentWeight: currentWeight, targetWeight: targetWeight, year: year, goal: goal,));

                    MyAppHelperFunctions.showSnackBar('${controller.selectedIndex.value}');
                  }

                  // Handle button press
                },
                buttonText: AppStrings.next,
              ),
            );
          }),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: AppSizes.appBarHeight),
                Text(
                  textAlign: TextAlign.center,
                  AppStrings.textGoal,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                SizedBox(height: AppSizes.appBarHeight + 10),
                SizedBox(
                  height: 600,
                  child: ListView.builder(
                    itemCount: cardDetails.length,
                    itemBuilder: (context, index) {
                      return Obx(() {
                        return buildCard(
                          imagePath: cardDetails[index]['imagePath'],
                          text: cardDetails[index]['text'],
                          dark: dark,
                          onTap: () {
                            controller.selectCard(index);
                          },
                          isSelected: controller.selectedIndex.value == index,
                        );
                      });
                    },
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

