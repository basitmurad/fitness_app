import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../utils/constants/AppColor.dart';
import '../../../../utils/constants/AppDevicesUtils.dart';

class ExerciseWidget extends StatelessWidget {
  const ExerciseWidget({
    super.key,
    required this.dark, required this.imagePath, required this.exerciseName, required this.exerciseRepeation,
  });

  final String imagePath;
  final String exerciseName;
  final String exerciseRepeation;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10 ,horizontal: 10),
      width: double.infinity,
      height: AppDevicesUtils.getScreenHeight() * 0.19,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: dark ? AppColor.white : AppColor.dark3,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            left: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
                topLeft: Radius.circular(8),
              ),
              child:      ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), // Adjust the opacity to control the darkness
                  BlendMode.darken,
                ),
                child: Image.asset(imagePath ,
                  fit: BoxFit.cover,), // Replace with your image asset
              ),

            ),
          ),
          Positioned(
              left: 16,
              top: 10,
              bottom: 10,
              right: 10,
              // Allow the text container to span the remaining width
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    exerciseName,
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(
                      color: dark
                          ? AppColor.white
                          : AppColor.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.1,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    exerciseRepeation,
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(
                      color: dark
                          ? AppColor.white
                          : AppColor.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.1,
                      fontSize: 12,
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
