import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppImagePaths.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  final String imageUrl;
  final double size;

  CircularImage({required this.imageUrl, required this.size});

  @override
  Widget build(BuildContext context) {
    final bool dark =MyAppHelperFunctions.isDarkMode(context);
    return
      Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.grey,
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: ClipOval(

        child: FadeInImage(
          placeholder: const AssetImage(AppImagePaths.placeholder1), // Placeholder image
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 200),
          fadeOutDuration: const Duration(milliseconds: 200),
          imageErrorBuilder: (context, error, stackTrace) {
            return  Center(child: Text( textAlign: TextAlign.center ,'No profile Photo' ,style: TextStyle(color: dark ? AppColor.black : AppColor.black),));
          },
        ),
      ),
    );
  }
}
