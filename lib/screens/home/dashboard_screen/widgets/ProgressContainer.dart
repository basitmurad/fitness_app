import 'package:flutter/cupertino.dart';

class ProgressContainer extends StatelessWidget {
  final String iconPath;
  final String label;
  final String value;

  ProgressContainer({required this.iconPath, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox( height: 8,),

        Image.asset(
          iconPath,
          width: 28, // Adjust the size as needed
          height: 28, // Adjust the size as needed
        ),
        SizedBox( height: 8,),

        Text(label),
        SizedBox( height: 4,),


        Text(value),
      ],
    );
  }
}
