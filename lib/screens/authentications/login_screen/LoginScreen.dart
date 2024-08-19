import 'package:fitness/screens/authentications/login_screen/widgets/LoginDividerWidget.dart';
import 'package:fitness/screens/authentications/login_screen/widgets/LoginWidget.dart';
import 'package:fitness/screens/authentications/login_screen/widgets/SocialButton.dart';
import 'package:fitness/screens/authentications/signup_screen/SignUpScreen.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/constants/AppString.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);


    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                 SizedBox(height: AppDevicesUtils.getAppBarHeight() +50),



                Text(


                  AppStrings.hello,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 32 ,fontWeight: FontWeight.w700 ,color: dark ? AppColor.white :AppColor.textColor ),
                  textAlign: TextAlign.start,
                ),


                Text(


                  AppStrings.fitnessTitan,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20 , fontWeight: FontWeight.w400,color: dark ?AppColor.white : AppColor.textColor),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: AppSizes.spaceBtwSections),
                 LoginWidget(dark: dark,),


                const SizedBox(height: AppSizes.spaceBtwSections +15),
                LoginDividerWidget(dark: dark),


                const SizedBox(height: AppSizes.spaceBtwSections  +10),
                const SocialButton(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
                  crossAxisAlignment: CrossAxisAlignment.center, // Center vertically
                  children: [
                    Text(
                      AppStrings.donothave,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14 ,fontWeight: FontWeight.w400), // Customize text style as needed
                    ),
                    const SizedBox(width: 10), // Space between text and button
                    TextButton(
                      onPressed: () => Get.to(const SignUpScreen()), // Handle button press
                      child: Text(
                        AppStrings.signUP,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14,fontWeight: FontWeight.w900 ,color: dark ? AppColor.white : AppColor.lightBlue), // Customize button text style as needed
                      ),
                    ),
                  ],
                )


                
              ],
            ),
          )
        )

    );
  }
}
