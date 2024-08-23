import 'package:fitness/common/widgets/TextInputWidget.dart';
import 'package:fitness/screens/controller/NameScreenController.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/ButtonWidget.dart';
import '../../../utils/constants/AppSizes.dart';
import '../../../utils/constants/AppString.dart';

class NameScreen extends StatelessWidget {
  const NameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);

    NameScreenController nameScreenController = Get.put(NameScreenController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: AppSizes.appBarHeight,
              ),
              Text(
                textAlign: TextAlign.center,
                AppStrings.signUP,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              SizedBox(height: AppDevicesUtils.getScreenWidth(context) * 0.45,),

              const SizedBox(height: AppSizes.appBarHeight,),
              Text(
                textAlign: TextAlign.center,
                AppStrings.textName,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),

              const SizedBox(height: AppSizes.spaceBtwInputFields,),
              // Opacity for TextInputWidget
              Obx(() => Opacity(
                opacity: nameScreenController.isNameEntered.value ? 1.0 : 0.4,
                child: TextInputWidget(
                    focusNode: nameScreenController.focusNode, // Pass focus node

                    controller: nameScreenController.nameController,
                    dark: dark
                ),
              )),

              const SizedBox(height: AppSizes.spaceBtwInputFields +20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),

                // Opacity for ButtonWidget
                child: Obx(() => Opacity(
                  opacity: nameScreenController.isNameEntered.value ? 1.0 : 0.4,
                  child: ButtonWidget(
                    dark: dark,
                    onPressed: () {


                      nameScreenController.getName();
                    },
                    buttonText: AppStrings.next,
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
