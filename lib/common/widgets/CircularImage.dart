import 'package:fitness/utils/constants/AppImagePaths.dart';
import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  final String imageUrl;
  final double size;

  CircularImage({required this.imageUrl, required this.size});

  @override
  Widget build(BuildContext context) {
    return
      Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: ClipOval(
        child: FadeInImage(
          placeholder: AssetImage(AppImagePaths.placeholder1), // Placeholder image
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 200),
          fadeOutDuration: Duration(milliseconds: 200),
          imageErrorBuilder: (context, error, stackTrace) {
            return Center(child: Text('Failed to load image'));
          },
        ),
      ),
    );
  }
}
