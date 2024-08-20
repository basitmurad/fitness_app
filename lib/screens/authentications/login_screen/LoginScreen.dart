import 'package:fitness/screens/authentications/login_screen/widgets/LoginBottom.dart';
import 'package:fitness/screens/authentications/login_screen/widgets/LoginDividerWidget.dart';
import 'package:fitness/screens/authentications/login_screen/widgets/LoginWidget.dart';
import 'package:fitness/screens/authentications/login_screen/widgets/SocialButton.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/constants/AppString.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/material.dart';


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
                 SizedBox(height: AppDevicesUtils.getAppBarHeight() +80),



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
                SizedBox(height: AppSizes.inputFieldRadius+5,),
                const SocialButton(),

                SizedBox(height: AppSizes.spaceBtwSections+25,),


                LoginBottom(dark: dark, buttonText: AppStrings.signUP, textMain: AppStrings.donothave,)


                
              ],
            ),
          )
        )

    );
  }
}

