import 'package:fitness/screens/authentications/forget_password/ResetPassword.dart';
import 'package:fitness/screens/authentications/forget_password/controller/ForgetController.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/constants/AppString.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/AppImagePaths.dart';

class ForgetPassword extends StatelessWidget {
   ForgetPassword({super.key});

  ForgetController forgetController = Get.put(ForgetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16 ,vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: AppDevicesUtils.getScreenWidth(context) * 0.4,
              width: AppDevicesUtils.getScreenWidth(context) * 0.4,
              child: Image.asset(AppImagePaths.forgetillustration),
            ),
            const SizedBox(
              height: AppSizes.spaceBtwSections,
            ),
            TextFormField(
              decoration:  InputDecoration(
                label: Text(AppStrings.emailText),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.black)),
                hintText: AppStrings.email,
                suffixIcon: const Icon(Iconsax.direct),
              ),
            ),
            const SizedBox(
              height: AppSizes.spaceBtwSections,
            ),

            SizedBox(
              width: AppDevicesUtils.getScreenWidth(context) * 0.8,
              child: ElevatedButton(onPressed: (){

                Get.to(() => const ResetPassword());

              }, child:  Text(AppStrings.submit),),
            )

          ],
        ),
      ),
    );
  }
}
