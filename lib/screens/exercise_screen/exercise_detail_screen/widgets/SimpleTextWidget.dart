// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class SimpleTextWidget extends StatelessWidget {
//   final String text;
//   final FontWeight fontWeight;
//   final double fontSize;
//   final Color color;
//   final String fontFamily;
//   final TextAlign? align;
//   final double? lineSpacing;  // Add lineSpacing as an optional parameter
//
//
//   const SimpleTextWidget({
//     super.key,
//     required this.text,
//     required this.fontWeight ,
//
//     required this.fontSize ,
//
//     required this.color, required this.fontFamily, this.align, this.lineSpacing ,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//           color: color,
//           fontSize: fontSize,
//           fontFamily: fontFamily,
//           fontWeight: fontWeight),
//
//
//     );
//   }
// }
import 'package:flutter/material.dart';

class SimpleTextWidget extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  final String fontFamily;
  final TextAlign? align;
  final double? lineSpacing;  // Add lineSpacing as an optional parameter

  const SimpleTextWidget({
    super.key,
    required this.text,
    required this.fontWeight,
    required this.fontSize,
    required this.color,
    required this.fontFamily,
    this.align,
    this.lineSpacing,  // Initialize lineSpacing
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,  // Add alignment
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        height: lineSpacing,  // Apply line height (lineSpacing)
      ),
    );
  }
}
