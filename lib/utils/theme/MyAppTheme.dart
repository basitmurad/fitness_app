import 'package:fitness/utils/constants/AppColor.dart';
import 'package:flutter/material.dart';
import 'customTheme/AppBarTheme.dart';
import 'customTheme/AppBottomSheetTheme.dart';
import 'customTheme/AppCheckBoxTheme.dart';
import 'customTheme/AppChipTheme.dart';
import 'customTheme/AppElevatedButtonTheme.dart';
import 'customTheme/AppOutlinedButtonTheme.dart';
import 'customTheme/AppTextFieldTheme.dart';
import 'customTheme/AppTextTheme.dart';

class MyAppTheme {
  MyAppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      primaryColor: AppColor.orangeColor,
      textTheme: AppTextTheme.lightTextTheme,
      chipTheme: AppChipTheme.lightTheme,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: MyAppBarTheme.lightTheme,
      elevatedButtonTheme: AppElevatedButtonTheme.lightTheme,
      outlinedButtonTheme: AppOutlinedButtonTheme.lightTheme,
      bottomSheetTheme: AppBottomSheetTheme.lightTheme,
      checkboxTheme: AppCheckBoxTheme.lightTheme,
      inputDecorationTheme: AppTextFieldTheme.lightTheme);
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      primaryColor: AppColor.orangeColor,
      textTheme: AppTextTheme.darkTextTheme,
      chipTheme: AppChipTheme.darkTheme,
      scaffoldBackgroundColor: AppColor.dark4,
      appBarTheme: MyAppBarTheme.darkTheme,
      elevatedButtonTheme: AppElevatedButtonTheme.darkTheme,
      outlinedButtonTheme: AppOutlinedButtonTheme.darkTheme,
      bottomSheetTheme: AppBottomSheetTheme.darkTheme,
      checkboxTheme: AppCheckBoxTheme.darkTheme,
      inputDecorationTheme: AppTextFieldTheme.darkTheme);
}
