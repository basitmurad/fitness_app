import 'package:fitness/utils/constants/AppColor.dart';
import 'package:flutter/material.dart';
class AppElevatedButtonTheme
{

  AppElevatedButtonTheme._();

  static final lightTheme= ElevatedButtonThemeData(

    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white ,
      backgroundColor: Color(0xFFFE7A03),
      disabledBackgroundColor: Colors.grey,
        disabledForegroundColor: Colors.grey,
      side: const BorderSide(color: AppColor.orangeColor),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(fontSize: 16, color: Colors.white , fontWeight: FontWeight.w700),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
    )



  );
  static final darkTheme= ElevatedButtonThemeData(

      style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white ,
          backgroundColor: AppColor.orangeColor,
          disabledBackgroundColor: Colors.grey,
          disabledForegroundColor: Colors.grey,
          side: const BorderSide(color: AppColor.orangeColor),
          padding: const EdgeInsets.symmetric(vertical: 18),
          textStyle: const TextStyle(fontSize: 16, color: Colors.white , fontWeight: FontWeight.w700),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
      )



  );
}