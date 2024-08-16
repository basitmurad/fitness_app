import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/AppSizes.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: 60.0,
                  height: 25.0,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Center(
                    child: Text(
                      'back',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              // Right Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: 60.0,
                  height: 25.0,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Center(
                    child: Text(
                      'Skip',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Column(
            children: [
              
              Image(
                  height: AppDevicesUtils.getScreenWidth(context) * 0.7,
                  image: AssetImage('')),

              Text(
                '',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: AppSizes.spaceBtwItems,
              ),
              Text(
                '',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              )

            ],
          )



          // Container(
          //
          //   margin: EdgeInsets.only(right: 20),
          //   alignment: Alignment.center,
          //   width: 55.0, // Width of the oval
          //   height: 25.0, // Height of the oval
          //   decoration: BoxDecoration(
          //     color: Colors.white, // Background color
          //     borderRadius: BorderRadius.circular(30.0), // Border radius for oval shape
          //     border: Border.all(
          //       color: Colors.grey, // Stroke color
          //       width:1.5, // Stroke width
          //     ),
          //   ),
          //   child: Center(
          //     child: Text(
          //       'Skip',
          //       style: TextStyle(
          //         fontSize: 12.0, // Text size
          //         color: Colors.black, // Text color
          //       ),
          //     ),
          //   ),
          // ),






        ],
      ),
    );
  }
}
