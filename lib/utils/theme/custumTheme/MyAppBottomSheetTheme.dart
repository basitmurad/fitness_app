import 'package:flutter/material.dart';
class MyAppBottomSheetTheme{

  MyAppBottomSheetTheme._();

  static BottomSheetThemeData lightTheme = BottomSheetThemeData(

    showDragHandle: true,
    backgroundColor: Colors.white,
    modalBackgroundColor: Colors.white,

    constraints: BoxConstraints(maxWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );
  static BottomSheetThemeData darkTheme = BottomSheetThemeData(

    showDragHandle: true,
    backgroundColor: Colors.black,
    modalBackgroundColor: Colors.black,

    constraints: BoxConstraints(maxWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

  );

}