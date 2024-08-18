import 'package:flutter/material.dart';
class AppChipTheme
{
  static ChipThemeData lightTheme = ChipThemeData(
    disabledColor: Colors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: Colors.blue,
    padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
    checkmarkColor: Colors.red

  );
  static ChipThemeData darkTheme = const ChipThemeData(


      disabledColor: Colors.grey,
      labelStyle: TextStyle(color: Colors.white ),
      selectedColor: Colors.blue,
      padding: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
      checkmarkColor: Colors.white
  );

}