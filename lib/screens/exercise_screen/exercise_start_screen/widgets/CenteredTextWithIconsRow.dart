import 'package:flutter/material.dart';

class CenteredTextWithIconsRow extends StatelessWidget {
  final String text;
  final String text1;
  final String leftIcon;
  final String rightIcon;
  final Color textColor;

  const CenteredTextWithIconsRow({
    super.key,
    required this.text,
    required this.leftIcon,
    required this.rightIcon, required this.text1, required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,// Align vertically in the center
      children: [

        Transform.rotate(
          angle: 0,
          child: Image(height: 28 ,
          width: 28,
          image: AssetImage(leftIcon)),
        ),
        const SizedBox(width: 25,),

        Text(
          text,
          style:  TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: textColor,
            fontFamily: 'Poppins'
          ),
        ),

        Text(
          text1,
          style:  TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: textColor,
              fontFamily: 'Poppins'

          ),
        ),
        const SizedBox(width: 25,),
        Transform.rotate(
          angle: 3.1,
          child: Image(height: 28 ,
              width: 28,
              image: AssetImage(leftIcon)),
        ),
      ],
    );
  }
}