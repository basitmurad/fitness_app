import 'package:fitness/utils/constants/AppColor.dart';
import 'package:flutter/material.dart';
class AppTextTheme{

  AppTextTheme._();

  static TextTheme lightTextTheme= TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 32.0, fontWeight: FontWeight.bold, color: AppColor.dark),
    headlineMedium: const TextStyle().copyWith(fontSize: 24.0, fontWeight: FontWeight.w600, color: AppColor.dark),
    headlineSmall: const TextStyle().copyWith(fontSize: 18.0, fontWeight: FontWeight.w600, color: AppColor.dark),

    titleLarge: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w600, color: AppColor.dark),
    titleMedium: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w500, color: AppColor.dark),
    titleSmall: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w400, color: AppColor.dark),

    bodyLarge: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w500, color: AppColor.dark),
    bodyMedium: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.normal, color: AppColor.dark),
    bodySmall: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w500, color: AppColor.dark.withOpacity(0.5)),

    labelLarge: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: AppColor.dark),
    labelMedium: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: AppColor.dark.withOpacity(0.5)),



  );
  static TextTheme darkTextTheme= TextTheme(

    headlineMedium: const TextStyle().copyWith(fontSize: 24.0,   fontWeight: FontWeight.w600, color: AppColor.light),
    headlineSmall: const TextStyle().copyWith(fontSize: 18.0,   fontWeight: FontWeight.w600, color: AppColor.light),
    titleLarge: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w600, color: AppColor.light),
    titleMedium: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w500, color: AppColor.light),
    titleSmall: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w400, color: AppColor.light),
    bodyLarge: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w500, color: AppColor.light),
    bodyMedium: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.normal, color: AppColor.light),
    bodySmall: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w500, color: AppColor.light.withOpacity(0.5)),
    labelLarge: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: AppColor.light),
    labelMedium: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: AppColor.light.withOpacity(0.5)),


  );

}