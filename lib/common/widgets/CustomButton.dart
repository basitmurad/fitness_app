import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key, required this.height1, required this.buttontext, required this.backColor, required this.textColor,  this.dark,
  });

  final double height1;  // Corrected the type from 'Double' to 'double'
  final String buttontext;

  final Color backColor;
  final Color textColor;
  final bool? dark;
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

          SizedBox(height: 5,),
          Text(
            buttontext,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(
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
