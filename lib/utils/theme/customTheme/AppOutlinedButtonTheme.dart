
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:flutter/material.dart';
class AppOutlinedButtonTheme{

  AppOutlinedButtonTheme._();

  static final lightTheme  = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColor.dark,
      side: const BorderSide(color: AppColor.borderPrimary),
      textStyle: const TextStyle(fontSize: 16, color: AppColor.black, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: AppSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColor.light,
      side: const BorderSide(color: AppColor.borderPrimary),
      textStyle: const TextStyle(fontSize: 16, color: AppColor.textWhite, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: AppSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.buttonRadius)),
    ),
  );



}