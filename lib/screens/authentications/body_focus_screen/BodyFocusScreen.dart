import 'package:fitness/screens/authentications/body_focus_screen/widget/ImageWidgetBody.dart';
import 'package:fitness/screens/authentications/body_focus_screen/widget/SelectableCard.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/ButtonWidget.dart';
import '../../../utils/constants/AppImagePaths.dart';
import '../../../utils/constants/AppSizes.dart';
import '../../../utils/constants/AppString.dart';
import '../../../utils/helpers/MyAppHelper.dart';
import '../../controller/BodyFocusScreenController.dart';

class BodyFocusScreen extends StatelessWidget {
  const BodyFocusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);

    final cardLabels = [
      'Full Body',
      'Arm',
      'Chest',
      'Abs',
      'Legs',
    ];
    // Initialize the controller
    final BodyFocusScreenController controller =
        Get.put(BodyFocusScreenController());

    return Scaffold(
      bottomNavigationBar: Obx(() {
        // Determine opacity based on whether any card is selected
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
                  // Handle button press
                },
                buttonText: AppStrings.next,
              ),
            ),
          ),
        );
      }),      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSizes.appBarHeight),
              Text(
                textAlign: TextAlign.center,
                AppStrings.textFocus,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                    const Expanded(
                      child: ImageWidgetBody(imageUrl: AppImagePaths.maleBody),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
