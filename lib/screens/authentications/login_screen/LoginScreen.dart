import 'package:fitness/screens/authentications/login_screen/widgets/LoginDividerWidget.dart';
import 'package:fitness/screens/authentications/login_screen/widgets/LoginWidget.dart';
import 'package:fitness/screens/authentications/login_screen/widgets/SocialButton.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/constants/AppString.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {


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
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: AppSizes.spaceBtwSections),
                const LoginWidget(),
                const SizedBox(height: AppSizes.spaceBtwSections),
                const LoginDividerWidget(),
                const SizedBox(height: AppSizes.spaceBtwSections - 10),
                const SocialButton(),


              ],
            ),
          ),

        )

    );
  }
}
