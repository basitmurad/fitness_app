
import 'package:flutter/material.dart';

import 'custumTheme/MyAppBarTheme.dart';
import 'custumTheme/MyAppBottomSheetTheme.dart';
import 'custumTheme/MyAppCheckBoxTheme.dart';
import 'custumTheme/MyAppChipTheme.dart';
import 'custumTheme/MyAppElevatedButtonTheme.dart';
import 'custumTheme/MyAppOutlinedButtonTheme.dart';
import 'custumTheme/MyAppTextFieldTheme.dart';
import 'custumTheme/MyAppTextTheme.dart';

class MyAppTheme {
  MyAppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      textTheme: MyAppTextTheme.lightTextTheme,
      chipTheme: MyAppChipTheme.lightTheme,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: MyAppBarTheme.lightTheme,
      elevatedButtonTheme: MyAppElevatedButtomTheme.lightTheme,
      outlinedButtonTheme: MyAppOutlinedButtonTheme.lightTheme,
      bottomSheetTheme: MyAppBottomSheetTheme.lightTheme,
      checkboxTheme: MyAppCheckBoxTheme.lightTheme,
      inputDecorationTheme: MyAppTextFieldTheme.lightTheme);
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      textTheme: MyAppTextTheme.darkTextTheme,
      chipTheme: MyAppChipTheme.darkTheme,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: MyAppBarTheme.darkTheme,
      elevatedButtonTheme: MyAppElevatedButtomTheme.darkTheme,
      outlinedButtonTheme: MyAppOutlinedButtonTheme.darkTheme,
      bottomSheetTheme: MyAppBottomSheetTheme.darkTheme,
      checkboxTheme: MyAppCheckBoxTheme.darkTheme,
      inputDecorationTheme: MyAppTextFieldTheme.darkTheme);
}
