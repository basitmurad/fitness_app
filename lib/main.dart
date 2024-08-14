import 'package:fitness/screens/authentications/login_screen/LoginScreen.dart';
import 'package:fitness/utils/constants/theme/MyAppTextFieldTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: LoginScreen());
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //
    //   ),
    //   // theme: ThemeData(
    //   //
    //   //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //   //   useMaterial3: true,
    //   // ),
    //   home: const LoginScreen()
    // );
  }
}


