import 'package:fitness/screens/authentications/body_focus_screen/BodyFocusScreen.dart';
import 'package:fitness/screens/authentications/body_goal_screen/widgets/buildCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/widgets/ButtonWidget.dart';
import '../../../utils/constants/AppImagePaths.dart';
import '../../../utils/constants/AppSizes.dart';
import '../../../utils/constants/AppString.dart';
import '../../../utils/helpers/MyAppHelper.dart';
import '../../controller/BodyGoalScreenController.dart';

List<Map<String, dynamic>> cardDetails = [
  {"imagePath": AppImagePaths.lossWeight, "text": "Loss Weight"},
  {"imagePath": AppImagePaths.buildMuscle, "text": "Build Muscle"},
  {"imagePath": AppImagePaths.keepFit, "text": "Keep Fit"},
];

class BodyGoalScreen extends StatelessWidget {
  const BodyGoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);
    final BodyGoalScreenController controller = Get.put(BodyGoalScreenController());

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
                onPressed: () {
                  Get.to(BodyFocusScreen());
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


