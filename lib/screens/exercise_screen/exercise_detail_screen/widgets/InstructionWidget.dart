
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Optional: For loading spinner

import '../../../../utils/constants/AppDevicesUtils.dart';

class InstructionWidget extends StatelessWidget {
  const InstructionWidget({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    String imageUrlToUse = imageUrl.isNotEmpty ? imageUrl : 'https://firebaqweqwsestorage.googleapis.comwew/v0/b/socialfitnessapp-5ac05.appspot.com/o/abs%20image%2Fjumingf.png?alt=media&token=ac54b31a-0bb0-42d2-91d1-adeb0eeda71f'; // Use a placeholder URL

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
                  child: Image.network(
                    imageUrlToUse,
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child; // Image loaded successfully
                      }
                      // Show a loading spinner while the image is loading
                      return const Center(
                        child: SpinKitFadingCircle( // Optional: Loading spinner
                          color: Colors.blue, // Customize the spinner color
                          size: 50.0,
                        ),
                      );
                    },
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      // Show a placeholder or error widget if the image fails to load
                      return const Center(
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                          size: 50.0,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back ,color: Colors.black,),
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
