import 'package:fitness/common/widgets/TextInputWidget.dart';
import 'package:fitness/screens/authentications/forget_password/ForgetPassword.dart';
import 'package:fitness/screens/authentications/login_screen/widgets/LoginDividerWidget.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/constants/AppString.dart';
import 'package:fitness/utils/helpers/KeyboardController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../common/widgets/ButtonWidget.dart';
import '../../controller/LoginScreenController.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    super.key,
    this.dark,
  });

  final dark;

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          const SizedBox(
            height: AppSizes.inputFieldRadius - 9,
          ),
          TextInputWidget(
            controller: controller.emailController,
            prefixIcon: const Icon(Icons.email),
            isPassword: false,
            headerFontWeight: FontWeight.w700,
            headerFontFamily: 'Manrope',
            hintText: AppStrings.enterEmail1, dark: dark, headerText: AppStrings.password,// Not a password field
          ),
          const SizedBox(height: AppSizes.inputFieldRadius + 3),

          const SizedBox(height: AppSizes.inputFieldRadius - 9),
          Obx(() => TextInputWidget(
                controller: controller.passwordController,
                prefixIcon: const Icon(Icons.lock),
                isPassword: true,
                hintText: AppStrings.entrePassword,
                // Password field
            headerFontWeight: FontWeight.w700,
                headerFontFamily: 'Manrope',
                obscureText: controller.isPasswordVisible.value,
                onObscureTextChanged: controller.togglePasswordVisibility, dark: dark, headerText: AppStrings.passwordNew,
              )),
          const SizedBox(height: AppSizes.inputFieldRadius),


          GestureDetector(
            onTap: (){

              Get.to(ForgetPassword());
              KeyboardController.instance.hideKeyboard(); // Hide keyboard before navigation

            },
            child: Container(
              alignment: Alignment.bottomRight,
              child: Text(
                AppStrings.forgetPassword,
                textAlign: TextAlign
                    .right, // Align text to the right within the container
              ),
            ),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwSections + 10,
          ),

          Padding(

            padding: const EdgeInsets.symmetric(horizontal: 0 ,),
            child: ButtonWidget(dark: dark, onPressed: () {  }, buttonText: AppStrings.sigIn,),
          ),
          
        ],
      ),
    );
  }
}
