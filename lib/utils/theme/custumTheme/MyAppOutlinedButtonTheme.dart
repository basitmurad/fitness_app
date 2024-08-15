
import 'package:fitness/utils/appcolor/AppColor.dart';
import 'package:fitness/utils/constants/sizes/AppSizes.dart';
import 'package:flutter/material.dart';
class MyAppOutlinedButtonTheme{

  MyAppOutlinedButtonTheme._();

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

  // static final lightTheme = OutlinedButtonThemeData(
  //
  //     style: ElevatedButton.styleFrom(
  //         elevation: 0,
  //         foregroundColor: MyAppColors.dark ,
  //
  //         side: BorderSide(color: MyAppColors.borderPrimary),
  //         padding: EdgeInsets.symmetric(vertical: 18),
  //         textStyle: TextStyle(fontSize: 16, color: Colors.black , fontWeight: FontWeight.w700),
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
  //     )
  // );
  // static final darkTheme = OutlinedButtonThemeData(
  //
  //     style: ElevatedButton.styleFrom(
  //         elevation: 0,
  //         foregroundColor: Colors.white ,
  //
  //         side: BorderSide(color: Colors.blueAccent),
  //         padding: EdgeInsets.symmetric(vertical: 18),
  //         textStyle: TextStyle(fontSize: 16, color: Colors.white  , fontWeight: FontWeight.w700),
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
  //     )
  //
  // );

}