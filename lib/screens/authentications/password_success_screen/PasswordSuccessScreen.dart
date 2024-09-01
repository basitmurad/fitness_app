import 'package:fitness/screens/authentications/login_screen/LoginScreen.dart';
import 'package:fitness/utils/constants/AppImagePaths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/widgets/ButtonWidget.dart';
import '../../../utils/constants/AppDevicesUtils.dart';
import '../../../utils/constants/AppSizes.dart';
import '../../../utils/constants/AppString.dart';
import '../../../utils/helpers/MyAppHelper.dart';

class PasswordSuccessScreen extends StatelessWidget {
  const PasswordSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);

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
                AppStrings.updatedPassword,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              SizedBox(
                height: AppDevicesUtils.getScreenWidth(context) * 0.6,
                width: AppDevicesUtils.getScreenWidth(context) * 0.4,
              ),
              


              const Image(
                  height: 60,
                  width: 60,
                  image: AssetImage(AppImagePaths.successImage)),


              const SizedBox(height: AppSizes.spaceBtwInputFields+16,),

              Text(
                  textAlign: TextAlign.center,
                  AppStrings.passwordChangeText),

              const SizedBox(height: AppSizes.spaceBtwInputFields+24,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 52),
                child: SizedBox(
                    width: double.infinity,
                    child: ButtonWidget(
                      dark: dark,
                      onPressed: ()=>Get.to(const LoginScreen()),
                      buttonText: AppStrings.sigIn,
                    )),
              ),

            ],
          ),
        ),
      ),
    ));
  }
}
