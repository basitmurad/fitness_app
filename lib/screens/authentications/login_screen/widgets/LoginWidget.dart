
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


          const SizedBox(
            height: AppSizes.spaceBtwInputFields,
          ),

          Container(
            margin: const EdgeInsets.only(right: 0),
            alignment: Alignment.bottomRight,
            child: TextButton(
                onPressed: () {
                  Get.to(() => ForgetPassword());
                },
                child: Text(AppStrings.forgetPassword,
                    textAlign: TextAlign.end,

                    style: Theme.of(context).textTheme.labelMedium )),
          ),

          const SizedBox(
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
              width: double.infinity,

              child: OutlinedButton(
                  onPressed: () =>Get.to(() => const SignUpScreen()),
                  child:  Text(AppStrings.createAccountText))),
        ],
      )),
    );
  }
}
