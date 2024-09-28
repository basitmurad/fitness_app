import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/CircularImage.dart';

class ImageWidget1 extends StatelessWidget {
  const ImageWidget1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Circular Image with inner shadow effect
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularImage(
                imageUrl:
                'https://images.unsplash.com/photo-1727324358652-e82abf20aad2?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                size: 100,
              ),
              // Inner shadow simulation using a gradient
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.black.withOpacity(0.5),
                      // Dark center for inner shadow effect
                      Colors.transparent,
                      // Fades to transparent
                    ],
                    stops: [0.7, 1.0],
                    // Control the spread of the inner shadow
                    center: Alignment.center,
                    radius: 0.9, // Adjust the radius for the effect
                  ),
                ),
              ),
            ],
          ),
        ),
        // Camera icon centered over the image
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Change Profile Picture'),
                      content: const Text('Do you want to change your profile picture?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Add logic to change profile image
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: const Text('Change'),
                        ),
                      ],
                    );
                  },
                );

              },
              icon: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),

      ],
    );
  }
}
