import 'package:fitness/common/widgets/ButtonWidget.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../utils/constants/AppDevicesUtils.dart';
import '../../../../utils/constants/AppString.dart';
import '../../../../utils/helpers/MyAppHelper.dart';
import '../../authentication_controllers/OtpScreenController.dart';
import '../change_password_screen/ChangePasswordScreen.dart';
import '../login_screen/widgets/LoginBottom.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, });



  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);
    OtpScreenController otpScreenController = Get.put(OtpScreenController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              const SizedBox(
                height: AppSizes.appBarHeight,
              ),
              Text(
                AppStrings.verification,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              SizedBox(
                height: AppDevicesUtils.getScreenWidth(context) * 0.5,
                width: AppDevicesUtils.getScreenWidth(context) * 0.4,
              ),
              Container(
                  alignment: Alignment.center,
                  child: Text(
                      '${AppStrings.enterVerification}}' ,
                  textAlign: TextAlign.center,)),
              const SizedBox(
                height: AppSizes.appBarHeight - 20,
              ),



          Pinput(
            length: 6,
            onChanged: (value) {
              otpScreenController.updatePin(value); // Update pin in controller
            },
            defaultPinTheme: PinTheme(
              width: 35,
              height: 35,
              textStyle:  TextStyle(
                fontSize: 16,
                color: dark ? AppColor.white :AppColor.white,
              ),
              decoration: BoxDecoration(
                color: otpScreenController.pinColor == AppColor.orangeLight ? AppColor.orangeColor :  AppColor.orangeColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            focusedPinTheme: PinTheme(
              width: 35,
              height: 35,
              textStyle: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              decoration: BoxDecoration(
                color: otpScreenController.pinColor == AppColor.orangeLight ? AppColor.orangeLight :  AppColor.orangeLight,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
                shape: BoxShape.circle
              ),
            ),
          ),


              const SizedBox(height: AppSizes.appBarHeight-20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                    width: double.infinity,
                    child: ButtonWidget(
                      dark: dark,
                      onPressed: () => Get.to(const ChangePasswordScreen()),
                      buttonText: AppStrings.verify,
                    )),
              ),
              const SizedBox(
                height: AppSizes.appBarHeight - 10,
              ),
              LoginBottom(
                dark: dark,
                buttonText: AppStrings.resend,
                textMain: AppStrings.donotReceive,
              )
            ],
          ),
        ),
      ),
    );
  }
}
