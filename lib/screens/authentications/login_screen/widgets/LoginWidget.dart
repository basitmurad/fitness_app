
import 'package:fitness/screens/authentications/signup_screen/SignUpScreen.dart';
import 'package:fitness/utils/constants/AppString.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/AppDevicesUtils.dart';
import '../../../../utils/constants/AppSizes.dart';
import '../../forget_password/ForgetPassword.dart';
import '../controller/LoginController.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10
      ),
      child: Form(
          child: Column(
        children: [


          TextFormField(
            controller: controller.emailController,
            decoration: InputDecoration(
                suffixIcon: Icon(Iconsax.direct),
                labelText: AppStrings.emailText),
          ),
          SizedBox(
            height: AppSizes.inputFieldRadius,
          ),

          Obx(() {
            return TextFormField(
              controller: controller.passwordController,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      color: Colors.grey,
                      controller.isPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                  labelText: AppStrings.password),
            );
          }),



          SizedBox(height: AppSizes.inputFieldRadius,),
          SizedBox(

            width: AppDevicesUtils.getScreenWidth(context)*0.9,
            child: GestureDetector(

                onTap: controller.navigateToForgetPassword,
              child: const Text('Forget Password' ,
              textAlign: TextAlign.end,),

            ),
          )

          ,const SizedBox(
            height: AppSizes.spaceBtwSections,
          ),

          SizedBox(
              width: AppDevicesUtils.getScreenWidth(context) * 0.8,
              child: ElevatedButton(
                  onPressed: () {
                    AppDevicesUtils.hideKeyboard(context);
                    controller.login();
                  },
                  child: Text(
                    'Login',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: Colors.black),
                  ))),

          const SizedBox(
            height: AppSizes.spaceBtwInputFields,
          ),
          SizedBox(
              width: AppDevicesUtils.getScreenWidth(context)*0.8,

              child: OutlinedButton(
                  onPressed: () =>Get.to(() => const SignUpScreen()),
                  child:  Text(AppStrings.createAccountText))),

          SizedBox(height: AppSizes.inputFieldRadius,)
        ],
      )),
    );
  }
}
