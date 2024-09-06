import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButtonWithIcon extends StatelessWidget {
  const CustomButtonWithIcon({
    super.key,
    required this.height1,
    required this.buttontext,
    required this.backColor,
    required this.textColor,
    required this.iconData,
  });

  final double height1; // Corrected the type from 'Double' to 'double'
  final String buttontext;

  final Color backColor;
  final Color textColor;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: height1,
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: Row(
     crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 10, color: Colors.white,
          ),
          SizedBox(
            width: 3,
          ),
          Text(
            buttontext,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                  color: textColor,
                ),
          ),
        ],
      ),
    );
  }
}
