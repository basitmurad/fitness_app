import 'package:fitness/screens/authentications/body_goal_screen/BodyGoalScreen.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../common/widgets/ButtonWidget.dart';
import '../../../utils/constants/AppColor.dart';
import '../../../utils/constants/AppSizes.dart';
import '../../../utils/constants/AppString.dart';
import '../../authentication_controllers/TargetWeightScreenController.dart';
import '../height_screen/widgets/InputWidget.dart';
import '../height_screen/widgets/UnitWidget.dart';

class TargetWeightScreen extends StatelessWidget {
   TargetWeightScreen({super.key});
  TargetWeightScreenController targetWeightScreenController  =Get.put(TargetWeightScreenController());

  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
          child: Obx(() {
            // Reactively update the ButtonWidget opacity
            return Opacity(
              opacity: targetWeightScreenController.opacity.value,
              child: ButtonWidget(
                dark: dark,
                onPressed: () {

                  Get.to(BodyGoalScreen());
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
                    AppStrings.textTargetWeight,
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
                            onTap: () => targetWeightScreenController.selectUnit('Kg'),
                            child: Opacity(
                              opacity: targetWeightScreenController.opacity.value,
                              child: UnitWidget(
                                rotationAngle: 3.15,
                                dark: dark,
                                unitText: 'Kg',
                                color: targetWeightScreenController.isSelected('Kg')
                                    ? AppColor.lightBlue // Color when selected
                                    : Colors.white,
                                textColor: targetWeightScreenController.isSelected('Kg')
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
                            onTap: () => targetWeightScreenController.selectUnit('Lbs'),
                            child: Opacity(
                              opacity: targetWeightScreenController.opacity.value,
                              child: UnitWidget(
                                rotationAngle: 0,
                                dark: dark,
                                unitText: 'Lbs',
                                color: targetWeightScreenController.isSelected('Lbs')
                                    ? AppColor.lightBlue // Color when selected
                                    : Colors.white,
                                textColor: targetWeightScreenController.isSelected('Lbs')
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
                    if (targetWeightScreenController.isSelected('Kg')) {
                      return Opacity(
                        opacity: targetWeightScreenController.opacity.value,
                        child: InputWidget(
                          dark: dark,
                          focusNode: FocusNode(),
                          editingController: targetWeightScreenController.kgController,
                          opacity: targetWeightScreenController.opacity.value,
                          ft: 'kg',
                          onChanged: (String value) {},
                        ),
                      );
                    } else if (targetWeightScreenController.isSelected('Lbs')) {
                      return Opacity(
                        opacity: targetWeightScreenController.opacity.value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InputWidget(
                              dark: dark,
                              focusNode: FocusNode(),
                              editingController: targetWeightScreenController.lbsController,
                              opacity: targetWeightScreenController.opacity.value,
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
