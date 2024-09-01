import 'package:flutter/material.dart';

class UnitWidget extends StatelessWidget {
  const UnitWidget({
    super.key,
    required this.dark,
    required this.unitText,
    this.rotationAngle = 0.0,
    required this.color, // Color passed from parent
    required this.textColor, // Text color passed from parent
  });

  final String unitText;
  final bool dark;
  final double rotationAngle;
  final Color color;
  final Color textColor; // New text color property

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotationAngle,
      child: Container(
        width: 48,
        height: 40,
        decoration: BoxDecoration(
          color: color, // Use the passed color
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: Center(
          child: Transform.rotate(
            angle: -rotationAngle,
            child: Text(
              unitText,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: textColor), // Use the passed text color
            ),
          ),
        ),
      ),
    );
  }
}
