import 'package:flutter/material.dart';
class MyAppTextFieldTheme{

  MyAppTextFieldTheme._();

  static InputDecorationTheme lightTheme = InputDecorationTheme(

      errorMaxLines:  3,
      prefixIconColor: Colors.grey,
      suffixIconColor: Colors.grey,
      labelStyle: TextStyle().copyWith(fontSize: 14,color: Colors.black),
      hintStyle: TextStyle().copyWith(fontSize: 14,color: Colors.black),
      errorStyle: TextStyle().copyWith(fontStyle: FontStyle.normal),
      floatingLabelStyle: TextStyle().copyWith(color: Colors.black.withOpacity(0.8)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(width: 1,color: Colors.grey)
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(width: 1,color: Colors.grey)
      ),
      focusedBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(width: 1,color: Colors.black12)
      ),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(width: 1,color: Colors.red)
      ),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(width: 1,color: Colors.yellow)
      )

  );
  static InputDecorationTheme darkTheme = InputDecorationTheme(



      errorMaxLines:  3,
      prefixIconColor: Colors.white,
      suffixIconColor: Colors.white,
      labelStyle: TextStyle().copyWith(fontSize: 14,color: Colors.white),
      hintStyle: TextStyle().copyWith(fontSize: 14,color: Colors.white),
      errorStyle: TextStyle().copyWith(fontStyle: FontStyle.normal),
      floatingLabelStyle: TextStyle().copyWith(color: Colors.white.withOpacity(0.8)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(width: 1,color: Colors.white)
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(width: 1,color: Colors.white)
      ),
      focusedBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(width: 1,color: Colors.white)
      ),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(width: 1,color: Colors.red)
      ),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(width: 1,color: Colors.yellow)
      )



  );

}