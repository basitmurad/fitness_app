import 'package:flutter/material.dart';
class MyAppBarTheme{

  MyAppBarTheme._();

  static  const lightTheme = AppBarTheme(

    elevation: 0,
    centerTitle: false,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    scrolledUnderElevation: 0,
    iconTheme: IconThemeData(color: Colors.black ,size: 24),
    actionsIconTheme: IconThemeData(color: Colors.black, size: 24)  ,
    titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.black)
  );
  static  const darkTheme = AppBarTheme(



      elevation: 0,
      centerTitle: false,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: Colors.black ,size: 24),
      actionsIconTheme: IconThemeData(color: Colors.white, size: 24)  ,
      titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.white)
  );
}