import 'package:fitness/common/widgets/TextInputWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/ButtonWidget.dart';
import '../../../../utils/constants/AppDevicesUtils.dart';
import '../../../../utils/constants/AppSizes.dart';
import '../../../../utils/constants/AppString.dart';
import '../../../../utils/helpers/MyAppHelper.dart';
import '../../authentication_controllers/ChangePasswordScreenController.dart';
import '../password_success_screen/PasswordSuccessScreen.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);
    ChangePasswordScreenController changePasswordScreenController =
        Get.put(ChangePasswordScreenController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: AppSizes.appBarHeight,
                ),
                Text(
                  textAlign: TextAlign.center,
                  AppStrings.createNewPassword,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                SizedBox(
                  height: AppDevicesUtils.getScreenWidth(context) * 0.5,
                  width: AppDevicesUtils.getScreenWidth(context) * 0.4,
                ),
                const SizedBox(height: AppSizes.inputFieldRadius - 9),
                Obx(() => TextInputWidget(
                      controller:
                          changePasswordScreenController.passwordController,
                      prefixIcon: const Icon(Icons.lock),
                      isPassword: true,
                      // Password field
                      dark: dark,

                      headerText: AppStrings.password,
                      headerFontWeight: FontWeight.w700,
                      headerFontFamily: 'Poppins',
                      hintText: AppStrings.entrePassword,
                      obscureText: changePasswordScreenController
                          .isPasswordVisible.value,
                      onObscureTextChanged: changePasswordScreenController
                          .togglePasswordVisibility,
                    )),
                const SizedBox(
                  height: AppSizes.inputFieldRadius + 8,
                ),
                const SizedBox(height: AppSizes.inputFieldRadius - 9),
                Obx(() => TextInputWidget(
                      controller: changePasswordScreenController
                          .confirmPasswordController,
                      prefixIcon: const Icon(Icons.lock),
                      isPassword: true,
                      hintText: AppStrings.entrePassword,
                      dark: dark,
                      headerText: AppStrings.passwordConfirm,
                      headerFontFamily: 'Poppins',
                      headerFontWeight: FontWeight.w700,
                      // Password field
                      obscureText: changePasswordScreenController
                          .isPasswordVisible1.value,
                      onObscureTextChanged: changePasswordScreenController
                          .togglePasswordVisibility1,
                    )),
                const SizedBox(
                  height: AppSizes.appBarHeight - 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 52),
                  child: SizedBox(
                      width: double.infinity,
                      child: ButtonWidget(
                        dark: dark,
                        onPressed: () => Get.to(const PasswordSuccessScreen()),
                        buttonText: AppStrings.submit,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
