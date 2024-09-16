import 'package:fitness/screens/authentications/onboarding_screen/Onboarding.dart';
import 'package:fitness/screens/exercise_screen/exercise_start_screen/ExerciseProgressScreen.dart';
import 'package:fitness/screens/home/dashboard/Dashboard.dart';
import 'package:fitness/utils/helpers/KeyboardController.dart';
import 'package:fitness/utils/theme/MyAppTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  Get.put(KeyboardController());
  Get.config(
    enableLog: true, // Enable logging for debugging
  );
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: Colors.white, // Set your desired color
  //   statusBarIconBrightness: Brightness.light, // Set the icon color (light or dark)
  // ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        themeMode: ThemeMode.system,
        theme: MyAppTheme.lightTheme,
        darkTheme: MyAppTheme.darkTheme,
        debugShowCheckedModeBanner: false,// Us
        home:   const OnboardingScreen());

  }
}


