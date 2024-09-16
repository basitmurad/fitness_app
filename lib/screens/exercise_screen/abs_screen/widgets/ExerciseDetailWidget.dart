import 'package:fitness/screens/authentications/login_screen/LoginScreen.dart';
import 'package:fitness/screens/exercise_screen/abs_screen/AbsScreen.dart';
import 'package:fitness/screens/exercise_screen/exercise_detail_screen/ExerciseDetailScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/AppColor.dart';
import '../../../../utils/constants/AppDevicesUtils.dart';
import '../../../../utils/constants/AppImagePaths.dart';

class ExerciseDetailWidget extends StatelessWidget {
  const ExerciseDetailWidget({
    super.key,
    required this.dark,
    required this.exerciseName,
    required this.exercieRep,
    required this.imageUrl, required this.context,
  });

  final BuildContext context;
  final bool dark;
  final String exerciseName;
  final String exercieRep;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.grey.withOpacity(0.1),

        borderRadius: BorderRadius.circular(8)

      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      height: 106,
      width: AppDevicesUtils.getScreenWidth(context) * 0.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // Use spaceBetween for even spacing
        children: [
          // First Image aligned at the start

          IconButton(onPressed: ()=>Get.to(ExerciseDetailScreen(exerciseName: exerciseName,)), icon: Icon(Icons.menu)),
          const SizedBox(
            width: 16,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // Aligns children to the start
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  exerciseName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: dark ?AppColor.white.withOpacity(0.9) :AppColor.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // Aligns icon and text vertically centered
                  mainAxisAlignment: MainAxisAlignment.start,
                  // Aligns row content to the start
                  children: [
                    const Icon(CupertinoIcons.clock, size: 16.0),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      exercieRep,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: dark ?AppColor.white.withOpacity(0.8) :AppColor.black,
                        
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Last Image aligned at the end
          Container(
            height: 70,
            width: 70,
            color: Colors.orange,
            child: Image.asset(imageUrl), // Replace with your image
          ),
        ],
      ),
    );
  }
}