import 'package:fitness/screens/authentications/login_screen/widgets/LoginDividerWidget.dart';
import 'package:fitness/screens/authentications/login_screen/widgets/LoginWidget.dart';
import 'package:fitness/screens/authentications/login_screen/widgets/SocialButton.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: AppSizes.spaceBtwSections + 10),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.fitness_center,
                    size: 100,
                    color: Colors.blueAccent,
                  ),
                ),



                const SizedBox(height: AppSizes.spaceBtwSections),
                Text(
                  AppStrings.accountText,
                  style:  TextStyle(
                    color: dark ? Colors.white : Colors.black,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),


                const SizedBox(height: AppSizes.spaceBtwSections),
                const LoginWidget(),


                const SizedBox(height: AppSizes.spaceBtwSections),
                 LoginDividerWidget(dark: dark),


                const SizedBox(height: AppSizes.spaceBtwSections - 10),
                const SocialButton(),

                const SizedBox(height: 20,)



                
              ],
            ),
          )
        )

    );
  }
}
