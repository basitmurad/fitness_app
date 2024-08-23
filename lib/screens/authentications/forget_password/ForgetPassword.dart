import 'package:fitness/common/widgets/ButtonWidget.dart';
import 'package:fitness/common/widgets/TextInputWidget.dart';
import 'package:fitness/screens/authentications/login_screen/widgets/LoginBottom.dart';
import 'package:fitness/screens/authentications/login_screen/widgets/LoginDividerWidget.dart';
import 'package:fitness/screens/authentications/login_screen/widgets/SocialButton.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/constants/AppString.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/helpers/MyAppHelper.dart';
import '../../controller/ForgetScreenController.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});

  ForgetController forgetController = Get.put(ForgetController());

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);
    ForgetController forgetController = Get.put(ForgetController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
        
              children: [
                const SizedBox(
                  height: AppSizes.appBarHeight ,
                ),
                Text(
                  textAlign: TextAlign.center,
                  AppStrings.forgetPassword,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                SizedBox(
                  height: AppDevicesUtils.getScreenWidth(context) * 0.69,
                  width: AppDevicesUtils.getScreenWidth(context) * 0.4,
                ),
        
                Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(AppStrings.enterEmail ,style: Theme.of(context).textTheme.bodySmall?.copyWith(color: dark ? AppColor.white : AppColor.textColor ,fontWeight: FontWeight.w600 , fontFamily: "Poppins"),)),
                const SizedBox( height:  AppSizes.inputFieldRadius +2,),

        
                TextInputWidget(controller: forgetController.emailController ,prefixIcon: const Icon(Iconsax.direct) ,hintText: AppStrings.emailText, dark: dark,

              headerFontFamily: 'Poppins',
                headerFontWeight: FontWeight.w600,),
        
        
               const SizedBox( height:  AppSizes.spaceBtwSections,),
               Padding(
        
                  padding: const EdgeInsets.symmetric(horizontal: 48 ,),
                  child: ButtonWidget(dark: dark,  onPressed: () {
                    forgetController.forgetPassword();
                  }, buttonText: AppStrings.send,),
                ),    
              
                const SizedBox(height: AppSizes.appBarHeight -10,),
                LoginDividerWidget(dark: dark),

                const SizedBox(height: AppSizes.inputFieldRadius+5,),
                const SocialButton(),

                const SizedBox(height: AppSizes.spaceBtwSections+35,),
                LoginBottom(dark: dark, buttonText: AppStrings.signUP, textMain: AppStrings.donothave, )

              ],





              
            ),
          ),
        ),
      ),
    );
  }
}
