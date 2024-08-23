import 'package:fitness/common/widgets/ButtonWidget.dart';
import 'package:fitness/screens/authentications/login_screen/widgets/LoginBottom.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../utils/constants/AppDevicesUtils.dart';
import '../../../utils/constants/AppString.dart';
import '../../../utils/helpers/MyAppHelper.dart';
import '../../controller/OtpScreenController.dart';
import '../change_password_screen/ChangePasswordScreen.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);
    OtpScreenController otpScreenController = Get.put(OtpScreenController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              const SizedBox(
                height: AppSizes.appBarHeight ,
              ),
              Text(
                textAlign: TextAlign.center,
          AppStrings.verification,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
        ),
              SizedBox(
                height: AppDevicesUtils.getScreenWidth(context) * 0.6,
                width: AppDevicesUtils.getScreenWidth(context) * 0.4,
              ),
              Container(
                  alignment: Alignment.center,
                  child: Text(AppStrings.enterVerification)),
              const SizedBox(
                height: AppSizes.appBarHeight -20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Obx(() {
                      return Container(
                        alignment: Alignment.center,
                        width: 55.0,
                        height: 55.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: otpScreenController.isFilled[index]
                              ? AppColor.lightBlue
                              : AppColor.lightBlue.withOpacity(
                                  0.7), // Change color based on filled state
                        ),
                        child: TextField(
                          controller: otpScreenController.controllers[index],
                          focusNode: otpScreenController.focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          // Limits input to one character
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            counterText: '', // Hides the counter text
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      );
                    }),
                  );
                }),
              ),
              const SizedBox(
                height: AppSizes.appBarHeight ,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                    width: double.infinity,
                    child: ButtonWidget(
                      dark: dark,
                      onPressed: ()=>Get.to(const ChangePasswordScreen()),
                      buttonText: AppStrings.verify,
                    )),
              ),
              const SizedBox(
                height: AppSizes.appBarHeight-10,
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

Widget buildOtpTextField() {
  OtpScreenController otpScreenController = Get.put(OtpScreenController());

  return Container(
    alignment: Alignment.center,
    width: 50,
    height: 50,
    decoration: const BoxDecoration(
      color: Colors.redAccent,
      shape: BoxShape.circle,
    ),
    child: Center(
      child: TextField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        maxLength: 1,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: const InputDecoration(
          counterText: "",
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          isCollapsed: true,
        ),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    ),
  );
}
