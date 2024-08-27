import 'package:fitness/screens/authentications/body_focus_screen/BodyFocusScreen.dart';
import 'package:fitness/screens/authentications/select_exercise_screen/widgets/buildCardItem.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../common/widgets/ButtonWidget.dart';
import '../../../utils/constants/AppImagePaths.dart';
import '../../../utils/constants/AppSizes.dart';
import '../../../utils/constants/AppString.dart';
import '../../authentication_controllers/SelectExerciseScreenController.dart';
List<Map<String, dynamic>> exercise = [
  {"imagePath": AppImagePaths.noequipmentImage, "text": "No equipment"},
  {"imagePath": AppImagePaths.nojummping, "text": "No jummping"},
  {"imagePath": AppImagePaths.none, "text": "None"},
];
class SelectExerciseScreen extends StatelessWidget {
  const SelectExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);
    SelectExerciseScreenController screenController = Get.put(SelectExerciseScreenController());
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
          child: Obx(() {
            return Opacity(
              opacity: screenController.isSelected.value ? 0.9 : 0.1,
              child: ButtonWidget(
                dark: dark,
                onPressed: () {

                  Get.to(BodyFocusScreen());
                  // Get.to(BodyFocusScreen());
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: AppSizes.appBarHeight -20),
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
                    itemCount: exercise.length,
                    itemBuilder: (context, index) {
                      return Obx(() {
                        return buildCardItem(
                          imagePath: exercise[index]['imagePath'],
                          text: exercise[index]['text'],
                          dark: dark,
                          onTap: () {
                            screenController.selectCard(index);
                          },
                          isSelected: screenController.selectedIndex.value == index,
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
