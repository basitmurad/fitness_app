
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../utils/constants/AppColor.dart';
import '../../../../utils/constants/AppDevicesUtils.dart';
import '../../../../utils/constants/AppImagePaths.dart';
import '../../../../utils/helpers/MyAppHelper.dart';
import '../../../authentication_controllers/SelectGenderController.dart';
import 'CustomRadioButton.dart';

class GenderWidget extends StatelessWidget {
  const GenderWidget({
    super.key,
     this.imagePath,
    required this.checkBoxText,
    required this.isMaleWidget,
  });

  final String? imagePath;
  final String checkBoxText;
  final bool isMaleWidget;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = MyAppHelperFunctions.isDarkMode(context);
    final SelectGenderController controller =
    Get.put(SelectGenderController()); // Retrieve existing instance

    return GestureDetector(
      onTap: () {
        controller.selectGender(isMaleWidget ? 'male' : 'female');
      },
      child: Obx(() {
        final isSelected = isMaleWidget
            ? controller.selectedGender.value == 'male'
            : controller.selectedGender.value == 'female';

        final otherSelected =
            !isSelected && controller.selectedGender.value.isNotEmpty;
        return Stack(
          children: [
            Positioned(
              top: 80,
              left: 15,
              right: 25,
              bottom: 285,
              child: Obx(
                    () => Visibility(
                  visible: isMaleWidget
                      ? controller.selectedGender.value == 'male'
                      : controller.selectedGender.value == 'female',
                  child: Transform.rotate(
                    angle: 220,
                    child: Image.asset(
                      'assets/myicons/back.png',
                      height: 120,
                      width: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Opacity(
              opacity: otherSelected ? 0.3 : 1.0,
              child: Column(
                children: [
                  // Image.asset(
                  //   imagePath!,
                  //   height: AppDevicesUtils.getScreenWidth(context) * 1.2,
                  //   width: AppDevicesUtils.getScreenWidth(context) * 0.3,
                  // ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        checkBoxText,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: isDarkMode
                                ? AppColor.white
                                : AppColor.textColor),
                      ),
                      SizedBox(width: 8),
                      Obx(
                            () => CustomRadioButton(
                          isSelected: isMaleWidget
                              ? controller.selectedGender.value == 'male'
                              : controller.selectedGender.value == 'female',
                          onTap: () {
                            controller.selectGender(
                                isMaleWidget ? 'male' : 'female');
                          },
                          iconPath: isDarkMode
                              ? AppImagePaths.uncheckme
                              : AppImagePaths.uncheckme, // Unselected icon path
                          selectedIconPath: isDarkMode
                              ? AppImagePaths.checkDark
                              : AppImagePaths.checkLight, // Selected icon path
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
