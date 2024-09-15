import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/AppDevicesUtils.dart';

class InstructionWidget extends StatelessWidget {
  const InstructionWidget({
    super.key, required this.imageUrl,
  });
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
          width: AppDevicesUtils.getScreenWidth(context) * 0.95,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), // Adjust this value to control the curvature
            boxShadow: const [
              BoxShadow(
                color: Colors.transparent, // Shadow color
                spreadRadius: 1, // Spread radius
                blurRadius: 2, // Blur radius
                offset: Offset(0, 1), // Shadow offset
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20), // Ensure the child is clipped to the same radius
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context); // Use Navigator to go back
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
