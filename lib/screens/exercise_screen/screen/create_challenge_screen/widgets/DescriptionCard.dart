import 'package:flutter/material.dart';

import '../../../../../utils/constants/AppDevicesUtils.dart';

class DescriptionCard extends StatelessWidget {
  final String title;
  final String description;

  DescriptionCard({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDevicesUtils.getScreenWidth(context) * 0.9,
      height: 128,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color with opacity
            spreadRadius: 1, // Spread radius of the shadow
            blurRadius: 5, // Blur radius of the shadow
            offset: const Offset(0, 2), // Offset of the shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8), // Space between title and description
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
