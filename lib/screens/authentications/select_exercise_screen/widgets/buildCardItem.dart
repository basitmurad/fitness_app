import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class buildCardItem extends StatelessWidget {
  buildCardItem({
    super.key,
    required this.imagePath,
    required this.text,
    required this.dark,
    required this.onTap,
    required this.isSelected,
  });

  final bool dark;
  final String imagePath;
  final String text;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Handle tap event
      child: SizedBox(
        height: 150, // Set the desired height of the card
        child: Card(
          color: isSelected ? Colors.blue : (dark ? Colors.grey[800] : Colors.white), // Change to blue when selected
          elevation: 3,
          child: Stack(
            children: [
              Positioned(

                 // Fixes the image to the left
                top: 0,
                left: 0,// Aligns the image to the top
                bottom: 0, // Stretches the image to the bottom
                child: Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Image(
                    width: 60,
                    height: 60,
                    // Makes the image fill the height of the card
                    image: AssetImage(imagePath),
                  ),
                ),
              ),
              Positioned(

                left: 150,
                top: 60,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    textAlign: TextAlign.center,
                    text,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: dark ? Colors.white : Colors.black,
                        fontSize: 16,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
