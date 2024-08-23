import 'package:fitness/screens/authentications/login_screen/LoginScreen.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/constants/AppString.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../common/widgets/ButtonWidget.dart';
import '../../../common/widgets/TextInputWidget.dart';
import '../../../utils/constants/AppDevicesUtils.dart';
import '../../../utils/helpers/KeyboardController.dart';
import '../../../utils/helpers/MyAppHelper.dart';
import '../../controller/SignUpScreenController.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);
    SignUpController signUpController = Get.put(SignUpController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(


            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: AppSizes.appBarHeight ,
              ),
              Text(
                textAlign: TextAlign.center,
                AppStrings.signUP,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              SizedBox(
                height: AppDevicesUtils.getScreenWidth(context) * 0.3,
                width: AppDevicesUtils.getScreenWidth(context) * 0.4,
              ),



              const SizedBox(
                height: AppSizes.inputFieldRadius - 6,
              ),
              TextInputWidget(
                controller: signUpController.emailController,
                prefixIcon: const Icon(Icons.email),
                isPassword: false,
                headerFontFamily: 'Poppins',
                headerFontWeight: FontWeight.w700,
                hintText: AppStrings.enterEmail1, dark: dark, headerText: AppStrings.emailText,// Not a password field
              ),

              const SizedBox(height: AppSizes.inputFieldRadius + 3),

              const SizedBox(height: AppSizes.inputFieldRadius - 6),
              Obx(() => TextInputWidget(
                controller: signUpController.passwordController,
                prefixIcon: const Icon(Icons.lock),
                isPassword: true,
                hintText: AppStrings.entrePassword,
                // Password field
                  headerFontFamily: 'Poppins',
                  headerFontWeight: FontWeight.w700,
                obscureText: signUpController.isPasswordVisible.value,
                onObscureTextChanged: signUpController.togglePasswordVisibility,
                  dark: dark, headerText: AppStrings.password
              )),

              const SizedBox(height: AppSizes.inputFieldRadius + 3),

              const SizedBox(height: AppSizes.inputFieldRadius - 6),
              Obx(() => TextInputWidget(
                dark: dark, headerText: AppStrings.passwordConfirm,
                controller: signUpController.confirmPasswordController,
                prefixIcon: const Icon(Icons.lock),
                isPassword: true,
                hintText: AppStrings.entrePassword,
                // Password field
                headerFontFamily: 'Poppins',
                headerFontWeight: FontWeight.w700,
                obscureText: signUpController.isConfirmPasswordVisible.value,
                onObscureTextChanged: signUpController.toggleConfirmPasswordVisibility,
              )),

              const SizedBox(height: AppSizes.sm,),

              GestureDetector(
                onTap: (){

                  Get.to(const LoginScreen());
                  KeyboardController.instance.hideKeyboard(); // Hide keyboard before navigation

                },
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    AppStrings.alreadyHaveAccount,
                    textAlign: TextAlign
                        .right, // Align text to the right within the container
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections+20),



              Padding(


                padding: const EdgeInsets.symmetric(horizontal: 8 ,),
                child: ButtonWidget(dark: dark, onPressed: () {signUpController.checkValidation();}, buttonText: AppStrings.signUP,),
              ),

            ],
          ),
        ),
      ),
    );
  }

}
