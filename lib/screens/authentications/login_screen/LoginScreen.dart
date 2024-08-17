import 'package:fitness/screens/authentications/login_screen/widgets/LoginDividerWidget.dart';
import 'package:fitness/screens/authentications/login_screen/widgets/LoginWidget.dart';
import 'package:fitness/screens/authentications/login_screen/widgets/SocialButton.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/constants/AppImagePaths.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [

            Image.asset(
                height: screenHeight,
                width: screenWidth,
                fit: BoxFit.cover,
                AppImagePaths.gymPic),

            Positioned(
              top: 10,
              left: 10,
              bottom: 10,
              right: 10,

              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: AppSizes.spaceBtwSections + 10),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Icon(
                        Icons.fitness_center,
                        size: 100,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwSections ),

                    // Welcome Textx
                    const Text(
                      'Connect, Compete,\nand Conquer Your Fitness Goals Together.',
                      style: TextStyle(
                        color: Colors.white,
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


                    const SizedBox(height: AppSizes.spaceBtwSections -10,),

                    const SocialButton(),
              ],
                 ),
                ),

            )
          ],
        ),

      ),
    );
  }
}

