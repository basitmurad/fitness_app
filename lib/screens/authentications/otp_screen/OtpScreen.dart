import 'package:fitness/common/widgets/ButtonWidget.dart';
import 'package:fitness/screens/authentications/login_screen/widgets/LoginBottom.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/AppDevicesUtils.dart';
import '../../../utils/constants/AppString.dart';
import '../../../utils/helpers/MyAppHelper.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

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


              const SizedBox(
                height: AppSizes.appBarHeight + 20,
              )
          ,
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
              const SizedBox( height:  AppSizes.inputFieldRadius +2,),





              Padding(padding:
              const EdgeInsets.symmetric(horizontal: 24) ,
              child: ButtonWidget(dark: dark, onPressed: () { }, buttonText: AppStrings.verify, ),)
,
              LoginBottom(dark: dark, buttonText: AppStrings.signUP,)

            ],
          ),
        ),
      ),
    );
  }
}
