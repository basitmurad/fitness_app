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
      bottomNavigationBar: BottomAppBar(
        height: 110,
        padding: const EdgeInsets.only(bottom: 40),
        color: Colors.transparent,
        child: Obx(() => Opacity(
          opacity: nameScreenController.isNameEntered.value ? 1.0 : 0.4,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 28),
            child: ButtonWidget(
              dark: dark,
              onPressed: () {
                nameScreenController.getName();
              },
              buttonText: AppStrings.next,
            ),
          ),
        )),
      ),
      resizeToAvoidBottomInset: true, // Helps resize the screen when the keyboard is displayed
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: AppSizes.appBarHeight),
                Text(
                  AppStrings.signUP,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(height: 79),
                Text(
                  AppStrings.textName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                SizedBox(height: AppDevicesUtils.getScreenWidth(context) * 0.5),
                Obx(() => Opacity(
                  opacity: nameScreenController.isNameEntered.value ? 1.0 : 0.4,
                  child: TextInputWidget(
                      hintText: 'First Name',
                      focusNode: nameScreenController.focusNode, // Pass focus node
                      controller: nameScreenController.nameController,
                      dark: dark
                  ),
                )),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
