import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:fitness/utils/constants/AppImagePaths.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AbsScreen extends StatelessWidget {
  const AbsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            children: [
              SizedBox(
                height: AppSizes.appBarHeight,
              ),
              Container(
                color: Colors.blue,
                width: AppDevicesUtils.getScreenWidth(context) * 0.9,
                height: 231,
                child: Stack(
                  children: [
                    // Main image filling the container
                    Positioned.fill(
                      child: Image.asset(
                        AppImagePaths.maleAbs,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // IconButton at the top left corner
                    Positioned(
                      top: 0,
                      left: 0,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back), // Use any icon you like
                        color: Colors.white, // Set the icon color
                        onPressed: () {
                          // Define your action when the button is pressed
                          print('Back button pressed');
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
