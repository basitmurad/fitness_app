import 'package:fitness/screens/authentications/body_goal_screen/BodyGoalScreen.dart';
import 'package:fitness/screens/authentications/height_screen/HeightScreen.dart';
import 'package:fitness/screens/authentications/login_screen/LoginScreen.dart';
import 'package:fitness/screens/authentications/name_screen/NameScreen.dart';
import 'package:fitness/screens/authentications/onboarding_screen/Onboarding.dart';
import 'package:fitness/screens/authentications/select_gender_screen/SelectGenderScreen.dart';
import 'package:fitness/screens/authentications/target_weight_screen/TargetWeightScreen.dart';
import 'package:fitness/screens/authentications/weight_screen/WeightScreen.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:fitness/utils/helpers/KeyboardController.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';

import 'package:fitness/utils/theme/MyAppTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  Get.put(KeyboardController());

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white, // Set your desired color
    statusBarIconBrightness: Brightness.light, // Set the icon color (light or dark)
  ));
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
        home:   BodyGoalScreen());

  }
}


