import 'package:fitness/screens/authentications/controller/SelectGenderController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/AppColor.dart';
import '../../../utils/constants/AppDevicesUtils.dart';
import '../../../utils/constants/AppImagePaths.dart';
import '../../../utils/constants/AppSizes.dart';
import '../../../utils/constants/AppString.dart';
import '../../../utils/helpers/MyAppHelper.dart';

class SelectGenderScreen extends StatelessWidget {
  const SelectGenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              SizedBox(
                height: AppSizes.appBarHeight,
              ),
              Text(
                AppStrings.signUP,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              SizedBox(
                height: AppSizes.spaceBtwItems + 30,
              ),
              // Container or SizedBox to constrain the height
              Container(
                height: AppDevicesUtils.getScreenWidth(context) * 1.4,
                // Provide a specific height
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: GenderWidget(
                        imagePath: AppImagePaths.male,
                        checkBoxText: AppStrings.male,
                      ),
                    ),
                    // SizedBox(width: 8), // Space between widgets
                    // Expanded(
                    //   child: GenderWidget(
                    //     imagePath: AppImagePaths.female,
                    //     checkBoxText: AppStrings.female,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GenderWidget extends StatelessWidget {
  const GenderWidget({
    super.key,
    required this.imagePath,
    required this.checkBoxText,
  });

  final String imagePath;
  final String checkBoxText;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = MyAppHelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          imagePath,
          height: AppDevicesUtils.getScreenWidth(context) * 1.2,
          // Adjusted height
          fit: BoxFit.cover,
        ),
        SizedBox(height: 16), // Space between image and checkbox
        Row(
          children: [
            Text(
              checkBoxText,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: isDarkMode ? AppColor.white : AppColor.textColor),
            ), // Checkbox text
            SizedBox(
              width: 8,
            ),
            CustomCheckbox(
              checkIconPath: AppImagePaths.check, // Path to checked icon
              uncheckIconPath: AppImagePaths.uncheck, // Path to unchecked icon

              isDarkMode: false, // Set based on your theme logic
            ),
          ],
        ),
      ],
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  final String checkIconPath;
  final String uncheckIconPath;
  final bool isDarkMode;

  CustomCheckbox({
    required this.checkIconPath,
    required this.uncheckIconPath,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final SelectGenderController controller = Get.put(SelectGenderController());
    final Color iconColor = isDarkMode ? AppColor.white : AppColor.textColor;

    return Obx(
      () => Row(
        children: [
          GestureDetector(
            onTap: () {
              controller.toggleCheckbox();
            },
            child: Image.asset(
              height: 17,
              width: 17,
              controller.isChecked.value ? checkIconPath : uncheckIconPath,
              color: iconColor, // Apply color based on the theme


            ),
          ),
        ],
      ),
    );
  }
}
