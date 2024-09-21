import 'package:fitness/common/widgets/ButtonWidget.dart';
import 'package:fitness/screens/authentications/login_screen/LoginScreen.dart';
import 'package:fitness/screens/exercise_screen/exercise_start_screen/ExerciseProgressScreen.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:fitness/utils/constants/AppImagePaths.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/AppColor.dart';
import 'widgets/ExerciseDetailWidget.dart';


List<Map<String, String>> chestExercise = [
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Jumping Jack',
    'exerciseRepetition': '00:20 sec x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Knee Push-Ups',
    'exerciseRepetition': '06 Reps x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Incline Push-Ups',
    'exerciseRepetition': '06 Reps x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Push-Ups',
    'exerciseRepetition': '06 Reps x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Wide Arm Push-Ups',
    'exerciseRepetition': '05 Reps x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Triceps-Dips',
    'exerciseRepetition': '06 Reps x 1 set',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Cobra Stretch',
    'exerciseRepetition': '00:30 sec x 1 set',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Chest Stretch',
    'exerciseRepetition': '00:20 sec x 2 sets',
  },
];


List<Map<String, String>> absExercise = [
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Jumping Jack',
    'exerciseRepetition': '00:20 sec x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Abdominal Crunches',
    'exerciseRepetition': '08 Reps x 2 sets',
  },

  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Russian Twist',
    'exerciseRepetition': '10 Reps x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Heel Touch',
    'exerciseRepetition': '00:20 sec x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Leg Raises',
    'exerciseRepetition': '10 Reps x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Plank',
    'exerciseRepetition': '00:20 sec x 1 set',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Cobra Stretch',
    'exerciseRepetition': '00:30 sec x 1 set',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Spine Lumber Twist Left',
    'exerciseRepetition': '00:20 sec x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Spine Lumber Twist Left',
    'exerciseRepetition': '00:20 sec x 2 sets',
  },
];


List<Map<String, String>> armsExercise = [
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Arm Raises',
    'exerciseRepetition': '00:10 sec x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Side Arm Raises',
    'exerciseRepetition': '00:30 sec x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Triceps Dips',
    'exerciseRepetition': '06 Reps x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Diamond Push-Ups',
    'exerciseRepetition': '06 Reps x 1 set',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Jumping Jacks',
    'exerciseRepetition': '00:20 sec x 2 sets',
  },
];

List<Map<String, String>> legExercise = [
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Side Hops',
    'exerciseRepetition': '00:10 sec x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Squats',
    'exerciseRepetition': '06 Reps x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Side Lying Leg Lift Left',
    'exerciseRepetition': '06 Reps x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Side Lying Leg Lift Right',
    'exerciseRepetition': '06 Reps x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Backward Lunge',
    'exerciseRepetition': '06 Reps Each x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Donkey Kicks',
    'exerciseRepetition': '06 Reps Each x 2 sets',
  },
];

List<Map<String, String>> backExercise = [
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Side Hops',
    'exerciseRepetition': '00:10 sec x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Squats',
    'exerciseRepetition': '06 Reps x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Side Lying Leg Lift Left',
    'exerciseRepetition': '06 Reps x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Side Lying Leg Lift Right',
    'exerciseRepetition': '06 Reps x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Backward Lunge',
    'exerciseRepetition': '06 Reps Each x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Donkey Kicks',
    'exerciseRepetition': '06 Reps Each x 2 sets',
  },
];

List<Map<String, String>> shoulderExercise = [
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Jumping Jack',
    'exerciseRepetition': '00:20 sec x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Knee Push-Ups',
    'exerciseRepetition': '06 Reps x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Side Lying Leg Lift Left',
    'exerciseRepetition': '06 Reps x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Side Lying Leg Lift Right',
    'exerciseRepetition': '06 Reps x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Arm Raises',
    'exerciseRepetition': '00:10 sec x 2 sets',
  },
  {
    'imagePath': AppImagePaths.maleAbs,
    'exerciseName': 'Side Arm Raises',
    'exerciseRepetition': '00:30 sec x 2 sets',
  },
];


class AbsScreen extends StatelessWidget {
  const AbsScreen({super.key, required this.exerciseName, required this.exerciseRepititon, required this.gender});

  final String exerciseName;
  final String exerciseRepititon;
  final String gender;

  List<Map<String, String>> _getExerciseList() {
    switch (exerciseName.toLowerCase()) {
      case 'chest workout':
        return chestExercise;
      case 'abs workout':
        return absExercise;
      case 'arm workout':
        return armsExercise;
      case 'leg workout':
        return legExercise;
      case 'shoulder workout':
        return shoulderExercise;
      case 'back workout':
        return backExercise;
      default:
        return [];
    }
  }
  String _getImagePath() {
    // Example logic to get the image path based on exercise name and gender
    if (exerciseName.toLowerCase().contains('Abs Workout')) {
      return gender == 'female'
          ? AppImagePaths.abs
          : AppImagePaths.maleAbs;
    }
    if (exerciseName.toLowerCase().contains('Chest Workout')) {
      return gender == 'female'
          ? AppImagePaths.maleChest
          : AppImagePaths.femaleChest;
    }
    // Add more conditions for other exercise types and genders
    return gender == 'female'
        ? AppImagePaths.male
        : AppImagePaths.female;
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);
    List<Map<String, String>> exerciseList = _getExerciseList();
    final imagePath = _getImagePath();


    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: AppSizes.appBarHeight,
              ),
              Container(
                width: AppDevicesUtils.getScreenWidth(context) * 0.95,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(imagePath),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.transparent,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child:
                Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.white,
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 18,
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
                              color: AppColor.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.1,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            exerciseRepititon,
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                              color: AppColor.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.1,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: AppSizes.spaceBtwItems - 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: exerciseList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ExerciseDetailWidget(
                      dark: dark,
                      exerciseName: exerciseList[index]['exerciseName']!,
                      exercieRep: exerciseList[index]['exerciseRepetition']!,
                      imageUrl: exerciseList[index]['imagePath']!,
                      context: context,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: AppSizes.appBarHeight - 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ButtonWidget(
                  dark: dark,
                  onPressed: () {
                    Get.to(const ExerciseProgressScreen());
                  },
                  buttonText: 'Start',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class AbsScreen extends StatelessWidget {
//   const AbsScreen({super.key, required this.exerciseName, required this.exerciseRepititon});
//
//   final String exerciseName;
//   final String exerciseRepititon;
//   @override
//   Widget build(BuildContext context) {
//     final bool dark = MyAppHelperFunctions.isDarkMode(context);
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             // Centers horizontally if the child width is less than the parent
//             mainAxisAlignment: MainAxisAlignment.center,
//             // Centers vertically
//             children: [
//               const SizedBox(
//                 height: AppSizes.appBarHeight,
//               ),
//               Container(
//
//
//                 width: AppDevicesUtils.getScreenWidth(context) * 0.95,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   image: const DecorationImage(
//
//                    fit: BoxFit.cover,
//                     image: AssetImage(AppImagePaths.maleArmWorkout ,
//                     ),
//                   ),
//                   boxShadow: const [
//
//                     BoxShadow(
//                       color: Colors.transparent, // Shadow color
//                       spreadRadius: 1, // Spread radius
//                       blurRadius: 2, // Blur radius
//                       offset: Offset(0, 1), // Shadow offset
//                     ),
//                   ],
//                 ),
//                 child: Stack(
//                   children: [
//                     Positioned(
//                       top: 0,
//                       left: 0,
//                       child: IconButton(
//                         icon: const Icon(Icons.arrow_back),
//                         color: Colors.white,
//                         onPressed: () {
//                           Get.back();
//                           print('Back button pressed');
//                         },
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 20,
//                       left: 18,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             exerciseName,
//                             textAlign: TextAlign.start,
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .displayLarge!
//                                 .copyWith(
//                               color: AppColor.white,
//                               fontFamily: 'Poppins',
//                               fontWeight: FontWeight.w400,
//                               letterSpacing: 0.1,
//                               fontSize: 20,
//                             ),
//                           ),
//                           const SizedBox(height: 2),
//                           Text(
//                             exerciseRepititon,
//                             textAlign: TextAlign.start,
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .displayLarge!
//                                 .copyWith(
//                               color: AppColor.white,
//                               fontFamily: 'Poppins',
//                               fontWeight: FontWeight.w400,
//                               letterSpacing: 0.1,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: AppSizes.spaceBtwItems -10,
//               ),
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: 8,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(left: 2.0 ,right: 2.0 ,top: 8.0 ,bottom: 8.0),
//                     child: ExerciseDetailWidget(dark: dark,
//                       exerciseName: chestExercise[index]['exerciseName']!,
//                       exercieRep: chestExercise[index]['exerciseRepetition']!,
//                       imageUrl: chestExercise[index]['imagePath']!, context: context,
//                     ),
//                   );
//                 },
//               ),
//
//               const SizedBox(
//                 height: AppSizes.appBarHeight - 20,
//               ),
//
//               SizedBox(
//                   width: double.infinity,
//                   child: ButtonWidget(dark: dark, onPressed: (){
//                     Get.to(LoginScreen());
//                   }, buttonText:'Start'))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
