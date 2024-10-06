// // import 'package:fitness/common/widgets/ButtonWidget.dart';
// // import 'package:fitness/screens/exercise_screen/exercise_start_screen/ExerciseProgressScreen.dart';
// // import 'package:fitness/utils/constants/AppDevicesUtils.dart';
// // import 'package:fitness/utils/constants/AppImagePaths.dart';
// // import 'package:fitness/utils/constants/AppSizes.dart';
// // import 'package:fitness/utils/helpers/MyAppHelper.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import '../../../utils/constants/AppColor.dart';
// // import 'widgets/ExerciseDetailWidget.dart';
// //
// //
// // class AbsScreen extends StatelessWidget {
// //   const AbsScreen({super.key,
// //     required this.exerciseName,
// //     required this.exerciseRepititon,
// //     required this.gender});
// //
// //   final String exerciseName;
// //   final String exerciseRepititon;
// //   final String gender;
// //
// //
// //   List<Map<String, String>> _getExerciseList() {
// //     switch (exerciseName.trim()) {
// //       case 'Chest Workout':
// //         return chestExercise;
// //       case 'Abs Workout':
// //         return absExercise;
// //       case 'Arm Workout':
// //         return armsExercise;
// //       case 'Leg Workout':
// //         return legExercise;
// //       case 'Shoulder Workout':
// //         return shoulderExercise;
// //       case 'Back Workout':
// //         return backExercise;
// //       default:
// //         return [];
// //     }
// //   }
// //
// //   String _getImagePath() {
// //     // Example logic to get the image path based on exercise name and gender
// //     if (exerciseName.contains('Abs Workout')) {
// //       return gender == 'female' ? AppImagePaths.femaleAbsWorkout : AppImagePaths
// //           .maleAbs;
// //     }
// //     if (exerciseName.contains('Chest Workout')) {
// //       return gender == 'female'
// //           ? AppImagePaths.femaleChestWorkout
// //           : AppImagePaths.maleChestWorkout;
// //     }
// //     if (exerciseName.contains('Arm Workout')) {
// //       return gender == 'female'
// //           ? AppImagePaths.femaleArmWorkout
// //           : AppImagePaths.maleArmWorkout;
// //     }
// //     if (exerciseName.contains('Leg Workout')) {
// //       return gender == 'female'
// //           ? AppImagePaths.femaleLegWorkout
// //           : AppImagePaths.maleLegWorkout;
// //     }
// //     if (exerciseName.contains('Shoulder Workout')) {
// //       return gender == 'female'
// //           ? AppImagePaths.femaleShoulderWorkout
// //           : AppImagePaths.maleShoulderWorkout;
// //     }
// //     if (exerciseName.contains('Back Workout')) {
// //       return gender == 'female'
// //           ? AppImagePaths.femaleBackWorkout
// //           : AppImagePaths.maleBackWorkout;
// //     }
// //     // Add more conditions for other exercise types and genders
// //     return gender == 'female' ? AppImagePaths.male : AppImagePaths.female;
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     print('gender is  $gender');
// //     print('Exercise name is $exerciseName');
// //     final bool dark = MyAppHelperFunctions.isDarkMode(context);
// //     List<Map<String, String>> exerciseList = _getExerciseList();
// //     final imagePath = _getImagePath();
// //
// //     return Scaffold(
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               const SizedBox(
// //                 height: AppSizes.appBarHeight,
// //               ),
// //               Container(
// //                 width: AppDevicesUtils.getScreenWidth(context) * 0.95,
// //                 height: 200,
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(12),
// //                   image: DecorationImage(
// //                     fit: BoxFit.cover,
// //                     image: AssetImage(imagePath),
// //                   ),
// //                   boxShadow: const [
// //                     BoxShadow(
// //                       color: Colors.transparent,
// //                       spreadRadius: 1,
// //                       blurRadius: 2,
// //                       offset: Offset(0, 1),
// //                     ),
// //                   ],
// //                 ),
// //                 child: Stack(
// //                   children: [
// //                     Positioned(
// //                       top: 0,
// //                       left: 0,
// //                       child: IconButton(
// //                         icon: const Icon(Icons.arrow_back),
// //                         color: Colors.white,
// //                         onPressed: () {
// //                           Get.back();
// //                         },
// //                       ),
// //                     ),
// //                     Positioned(
// //                       bottom: 20,
// //                       left: 18,
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           Text(
// //                             exerciseName,
// //                             textAlign: TextAlign.start,
// //                             style: Theme
// //                                 .of(context)
// //                                 .textTheme
// //                                 .displayLarge!
// //                                 .copyWith(
// //                               color: AppColor.white,
// //                               fontFamily: 'Poppins',
// //                               fontWeight: FontWeight.w400,
// //                               letterSpacing: 0.1,
// //                               fontSize: 20,
// //                             ),
// //                           ),
// //                           const SizedBox(height: 2),
// //                           Text(
// //                             exerciseRepititon,
// //                             textAlign: TextAlign.start,
// //                             style: Theme
// //                                 .of(context)
// //                                 .textTheme
// //                                 .displayLarge!
// //                                 .copyWith(
// //                               color: AppColor.white,
// //                               fontFamily: 'Poppins',
// //                               fontWeight: FontWeight.w400,
// //                               letterSpacing: 0.1,
// //                               fontSize: 12,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               const SizedBox(
// //                 height: AppSizes.spaceBtwItems - 10,
// //               ),
// //               ListView.builder(
// //                 shrinkWrap: true,
// //                 physics: const NeverScrollableScrollPhysics(),
// //                 itemCount: exerciseList.length,
// //                 itemBuilder: (context, index) {
// //                   String imageUrl = gender == 'female'
// //                       ? exerciseList[index]['femaleAbs'] ?? AppImagePaths.female // Use fallback if null
// //                       : exerciseList[index]['male'] ?? AppImagePaths.male; // Assuming 'male' is a fallback
// //
// //
// //                   return Padding(
// //                     padding: const EdgeInsets.symmetric(vertical: 8.0),
// //                     child: ExerciseDetailWidget(
// //                       dark: dark,
// //                       exerciseName: exerciseList[index]['exerciseName']!,
// //                       exercieRep: exerciseList[index]['exerciseRepetition']!,
// //                       imageUrl: imageUrl,
// //                       exerciseType: exerciseName, gender: gender, exerciseList: exerciseList,
// //                     ),
// //                   );
// //                 },
// //               ),
// //               const SizedBox(
// //                 height: AppSizes.appBarHeight - 20,
// //               ),
// //               SizedBox(
// //                 width: double.infinity,
// //                 child: ButtonWidget(
// //                   dark: dark,
// //                   onPressed: () {
// //                     Get.to(
// //                         ExerciseProgressScreen(exerciseType: '', gender: '',));
// //                   },
// //                   buttonText: 'Start',
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //
// // }
// //
// // List<Map<String, String>> chestExercise = [
// //   {
// //     'male': AppImagePaths.maleChest,
// //     'female': AppImagePaths.femaleChest,
// //     'exerciseName': 'Jumping Jack',
// //     'exerciseRepetition': '00:20 sec x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleChest,
// //     'female': AppImagePaths.femaleChest,
// //     'exerciseName': 'Knee Push-Ups',
// //     'exerciseRepetition': '06 Reps x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleChest,
// //     'female': AppImagePaths.femaleChest,
// //     'exerciseName': 'Incline Push-Ups',
// //     'exerciseRepetition': '06 Reps x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleChest,
// //     'female': AppImagePaths.femaleChest,
// //     'exerciseName': 'Push-Ups',
// //     'exerciseRepetition': '06 Reps x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleChest,
// //     'female': AppImagePaths.femaleChest,
// //     'exerciseName': 'Wide Arm Push-Ups',
// //     'exerciseRepetition': '05 Reps x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleChest,
// //     'female': AppImagePaths.femaleChest,
// //     'exerciseName': 'Triceps-Dips',
// //     'exerciseRepetition': '06 Reps x 1 set',
// //   },
// //   {
// //     'male': AppImagePaths.maleChest,
// //     'female': AppImagePaths.femaleChest,
// //     'exerciseName': 'Cobra Stretch',
// //     'exerciseRepetition': '00:30 sec x 1 set',
// //   },
// //   {
// //     'male': AppImagePaths.maleChest,
// //     'female': AppImagePaths.femaleChest,
// //     'exerciseName': 'Chest Stretch',
// //     'exerciseRepetition': '00:20 sec x 2 sets',
// //   },
// // ];
// //
// // List<Map<String, String>> absExercise = [
// //   {
// //     'male': AppImagePaths.maleAbs,
// //     'female': AppImagePaths.femaleAbs,
// //     'exerciseName': 'Jumping Jack',
// //     'exerciseRepetition': '00:20 sec x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleAbs,
// //     'female': AppImagePaths.femaleAbs,
// //     'exerciseName': 'Abdominal Crunches',
// //     'exerciseRepetition': '08 Reps x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleAbs,
// //     'female': AppImagePaths.femaleAbs,
// //     'exerciseName': 'Russian Twist',
// //     'exerciseRepetition': '10 Reps x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleAbs,
// //     'female': AppImagePaths.femaleAbs,
// //     'exerciseName': 'Heel Touch',
// //     'exerciseRepetition': '00:20 sec x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleAbs,
// //     'female': AppImagePaths.femaleAbs,
// //     'exerciseName': 'Spine Lumber Twist Left',
// //     'exerciseRepetition': '00:20 sec x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleAbs,
// //     'female': AppImagePaths.femaleAbs,
// //     'exerciseName': 'Spine Lumber Twist Right',
// //     'exerciseRepetition': '00:20 sec x 2 sets',
// //   },
// // ];
// //
// // List<Map<String, String>> armsExercise = [
// //   {
// //     'male': AppImagePaths.maleArmWorkout,
// //     'female': AppImagePaths.femaleArm,
// //     'exerciseName': 'Arm Raises',
// //     'exerciseRepetition': '00:10 sec x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleArmWorkout,
// //     'female': AppImagePaths.femaleArm,
// //     'exerciseName': 'Side Arm Raises',
// //     'exerciseRepetition': '00:30 sec x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleArmWorkout,
// //     'female': AppImagePaths.femaleArm,
// //     'exerciseName': 'Triceps Dips',
// //     'exerciseRepetition': '06 Reps x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleArmWorkout,
// //     'female': AppImagePaths.femaleArm,
// //     'exerciseName': 'Diamond Push-Ups',
// //     'exerciseRepetition': '06 Reps x 1 set',
// //   },
// //   {
// //     'male': AppImagePaths.maleArmWorkout,
// //     'female': AppImagePaths.femaleArm,
// //     'exerciseName': 'Jumping Jacks',
// //     'exerciseRepetition': '00:20 sec x 2 sets',
// //   },
// // ];
// //
// // List<Map<String, String>> legExercise = [
// //   {
// //     'male': AppImagePaths.maleLegWorkout,
// //     'female': AppImagePaths.femaleLegWorkout,
// //     'exerciseName': 'Side Hops',
// //     'exerciseRepetition': '00:10 sec x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleLegWorkout,
// //     'female': AppImagePaths.femaleLegWorkout,
// //     'exerciseName': 'Squats',
// //     'exerciseRepetition': '06 Reps x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleLegWorkout,
// //     'female': AppImagePaths.femaleLegWorkout,
// //     'exerciseName': 'Side Lying Leg Lift Left',
// //     'exerciseRepetition': '06 Reps x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleLegWorkout,
// //     'female': AppImagePaths.femaleLegWorkout,
// //     'exerciseName': 'Side Lying Leg Lift Right',
// //     'exerciseRepetition': '06 Reps x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleLegWorkout,
// //     'female': AppImagePaths.femaleLegWorkout,
// //     'exerciseName': 'Backward Lunge',
// //     'exerciseRepetition': '06 Reps Each x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleLegWorkout,
// //     'female': AppImagePaths.femaleLegWorkout,
// //     'exerciseName': 'Donkey Kicks',
// //     'exerciseRepetition': '06 Reps Each x 2 sets',
// //   },
// // ];
// //
// // List<Map<String, String>> backExercise = [
// //   {
// //     'male': AppImagePaths.maleBackWorkout,
// //     'female': AppImagePaths.femaleBackWorkout,
// //     'exerciseName': 'Side Hops',
// //     'exerciseRepetition': '00:10 sec x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleBackWorkout,
// //     'female': AppImagePaths.femaleBackWorkout,
// //     'exerciseName': 'Squats',
// //     'exerciseRepetition': '06 Reps x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleBackWorkout,
// //     'female': AppImagePaths.femaleBackWorkout,
// //     'exerciseName': 'Side Lying Leg Lift Left',
// //     'exerciseRepetition': '06 Reps x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleBackWorkout,
// //     'female': AppImagePaths.femaleBackWorkout,
// //     'exerciseName': 'Side Lying Leg Lift Right',
// //     'exerciseRepetition': '06 Reps x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleBackWorkout,
// //     'female': AppImagePaths.femaleBackWorkout,
// //     'exerciseName': 'Backward Lunge',
// //     'exerciseRepetition': '06 Reps Each x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleBackWorkout,
// //     'female': AppImagePaths.femaleBackWorkout,
// //     'exerciseName': 'Donkey Kicks',
// //     'exerciseRepetition': '06 Reps Each x 2 sets',
// //   },
// // ];
// //
// // List<Map<String, String>> shoulderExercise = [
// //   {
// //     'male': AppImagePaths.maleShoulderWorkout,
// //     'female': AppImagePaths.femaleShoulderWorkout,
// //     'exerciseName': 'Jumping Jack',
// //     'exerciseRepetition': '00:20 sec x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleShoulderWorkout,
// //     'female': AppImagePaths.femaleShoulderWorkout,
// //     'exerciseName': 'Knee Push-Ups',
// //     'exerciseRepetition': '06 Reps x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleShoulderWorkout,
// //     'female': AppImagePaths.femaleShoulderWorkout,
// //     'exerciseName': 'Side Lying Leg Lift Left',
// //     'exerciseRepetition': '06 Reps x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleShoulderWorkout,
// //     'female': AppImagePaths.femaleShoulderWorkout,
// //     'exerciseName': 'Side Lying Leg Lift Right',
// //     'exerciseRepetition': '06 Reps x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleShoulderWorkout,
// //     'female': AppImagePaths.femaleShoulderWorkout,
// //     'exerciseName': 'Arm Raises',
// //     'exerciseRepetition': '00:10 sec x 2 sets',
// //   },
// //   {
// //     'male': AppImagePaths.maleShoulderWorkout,
// //     'female': AppImagePaths.femaleShoulderWorkout,
// //     'exerciseName': 'Side Arm Raises',
// //     'exerciseRepetition': '00:30 sec x 2 sets',
// //   },
// // ];
//
//
//
//
//
// import 'package:firebase_database/firebase_database.dart';
// import 'package:fitness/common/widgets/ButtonWidget.dart';
// import 'package:fitness/screens/exercise_screen/exercise_start_screen/ExerciseProgressScreen.dart';
// import 'package:fitness/utils/constants/AppDevicesUtils.dart';
// import 'package:fitness/utils/constants/AppImagePaths.dart';
// import 'package:fitness/utils/constants/AppSizes.dart';
// import 'package:fitness/utils/helpers/MyAppHelper.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../utils/constants/AppColor.dart';
// import 'widgets/ExerciseDetailWidget.dart';
//
//
//
// class AbsScreen extends StatefulWidget {
//   const AbsScreen({
//     super.key,
//     required this.exerciseType,
//     required this.gender, required this.exerciseRepititon,
//   });
//
//
//   final String exerciseRepititon;
//
//   final String exerciseType;
//   final String gender;
//
//   @override
//   _AbsScreenState createState() => _AbsScreenState();
// }
//
// class _AbsScreenState extends State<AbsScreen> {
//   List<Map<String, String>> exerciseList = []; // Store exercise names and repetitions
//   bool isLoading = true; // Show loading indicator while data is being fetched
//
//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   Future<void> getData() async {
//     // Reference to the specific exercise name
//     DatabaseReference databaseReference =
//     FirebaseDatabase.instance.ref("Exercise").child(widget.exerciseType);
//
//     // Fetch the snapshot of the data
//     DataSnapshot snapshot = await databaseReference.get();
//
//     if (snapshot.exists) {
//       // Initialize a list to hold fetched exercises
//       List<Map<String, String>> fetchedExercises = [];
//
//       // Iterate through each child in the snapshot
//       for (var child in snapshot.children) {
//         // Ensure child has a key
//         if (child.key != null) {
//           // Fetch the value of the specific child (assuming the value is under a specific child name like 'Reps')
//           String? repetition = child.child("exerciseRepetition").value?.toString();
//
//           if (repetition != null) {
//             // Create a map with exercise name and its single repetition value
//             fetchedExercises.add({
//               "exerciseName": child.key!,
//               "exerciseRepetition": repetition,
//             });
//
//             // Print exerciseName and exerciseRepetition in brackets
//             print('Exercise Name: [${child.key!}]');
//             print('Exercise Repetition: [${repetition}]');
//           }
//         }
//       }
//
//       // Update the state to reflect the fetched data
//       setState(() {
//         exerciseList = fetchedExercises;
//         isLoading = false;
//       });
//     } else {
//       setState(() {
//         isLoading = false;
//       });
//       print('No data exists for the given exercise.');
//     }
//   }
//
//
//   String _getImagePath() {
// //     // Example logic to get the image path based on exercise name and gender
// //     if (exerciseName.contains('Abs Workout')) {
// //       return gender == 'female' ? AppImagePaths.femaleAbsWorkout : AppImagePaths
// //           .maleAbs;
// //     }
// //     if (exerciseName.contains('Chest Workout')) {
// //       return gender == 'female'
// //           ? AppImagePaths.femaleChestWorkout
// //           : AppImagePaths.maleChestWorkout;
// //     }
// //     if (exerciseName.contains('Arm Workout')) {
// //       return gender == 'female'
// //           ? AppImagePaths.femaleArmWorkout
// //           : AppImagePaths.maleArmWorkout;
// //     }
// //     if (exerciseName.contains('Leg Workout')) {
// //       return gender == 'female'
// //           ? AppImagePaths.femaleLegWorkout
// //           : AppImagePaths.maleLegWorkout;
// //     }
// //     if (exerciseName.contains('Shoulder Workout')) {
// //       return gender == 'female'
// //           ? AppImagePaths.femaleShoulderWorkout
// //           : AppImagePaths.maleShoulderWorkout;
// //     }
// //     if (exerciseName.contains('Back Workout')) {
// //       return gender == 'female'
// //           ? AppImagePaths.femaleBackWorkout
// //           : AppImagePaths.maleBackWorkout;
// //     }
// //     // Add more conditions for other exercise types and genders
// //     return gender == 'female' ? AppImagePaths.male : AppImagePaths.female;
// //   }
//
//   @override
//   Widget build(BuildContext context) {
//     final bool dark = MyAppHelperFunctions.isDarkMode(context);
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(
//                 height: AppSizes.appBarHeight,
//               ),
//               // Header Section with Exercise Name and Repetition
//               Container(
//                 width: AppDevicesUtils.getScreenWidth(context) * 0.95,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   color: Colors.red,
//                   borderRadius: BorderRadius.circular(12),
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: AssetImage(AppImagePaths.femaleLegWorkout), // Set your image here
//                   ),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.transparent,
//                       spreadRadius: 1,
//                       blurRadius: 2,
//                       offset: Offset(0, 1),
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
//                             widget.exerciseType,
//                             textAlign: TextAlign.start,
//                             style: Theme.of(context).textTheme.displayLarge!.copyWith(
//                               color: AppColor.white,
//                               fontFamily: 'Poppins',
//                               fontWeight: FontWeight.w400,
//                               letterSpacing: 0.1,
//                               fontSize: 20,
//                             ),
//                           ),
//                           const SizedBox(height: 2),
//                           Text(
//                             'Exercise Repetition',
//                             textAlign: TextAlign.start,
//                             style: Theme.of(context).textTheme.displayLarge!.copyWith(
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
//               const SizedBox(height: AppSizes.spaceBtwItems - 10),
//               // Loading indicator if data is still being fetched
//               if (isLoading)
//                 const CircularProgressIndicator(),
//               // ListView of exercises once data is loaded
//               if (!isLoading && exerciseList.isNotEmpty)
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: exerciseList.length,
//                   itemBuilder: (context, index) {
//                     final exercise = exerciseList[index];
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                       child: ExerciseDetailWidget(
//                         dark: dark,
//                         exerciseName: exercise["exerciseName"]!,
//                         exercieRep: exercise["exerciseRepetition"]!,
//                         imageUrl: 'imageUrl', // Add image URL if you have one
//                         exerciseType: widget.exerciseType,
//                         gender: widget.gender,
//                         exerciseList: [], // Add your list here if needed
//                       ),
//                     );
//                   },
//                 ),
//               if (!isLoading && exerciseList.isEmpty)
//                 const Text('No exercises found.'),
//
//               const SizedBox(height: AppSizes.appBarHeight - 20),
//               // Start Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ButtonWidget(
//                   dark: dark,
//                   onPressed: () {
//                     Get.to(ExerciseProgressScreen(
//                       gender: widget.gender, exerciseType: widget.exerciseType,
//                     ));
//                   },
//                   buttonText: 'Start',
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:fitness/common/widgets/ButtonWidget.dart';
// import 'package:fitness/screens/exercise_screen/exercise_start_screen/ExerciseProgressScreen.dart';
// import 'package:fitness/utils/constants/AppDevicesUtils.dart';
// import 'package:fitness/utils/constants/AppImagePaths.dart';
// import 'package:fitness/utils/constants/AppSizes.dart';
// import 'package:fitness/utils/helpers/MyAppHelper.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../utils/constants/AppColor.dart';
// import 'widgets/ExerciseDetailWidget.dart';
//
//
// class AbsScreen extends StatelessWidget {
//   const AbsScreen({super.key,
//     required this.exerciseName,
//     required this.exerciseRepititon,
//     required this.gender});
//
//   final String exerciseName;
//   final String exerciseRepititon;
//   final String gender;
//
//
//   List<Map<String, String>> _getExerciseList() {
//     switch (exerciseName.trim()) {
//       case 'Chest Workout':
//         return chestExercise;
//       case 'Abs Workout':
//         return absExercise;
//       case 'Arm Workout':
//         return armsExercise;
//       case 'Leg Workout':
//         return legExercise;
//       case 'Shoulder Workout':
//         return shoulderExercise;
//       case 'Back Workout':
//         return backExercise;
//       default:
//         return [];
//     }
//   }
//
//   String _getImagePath() {
//     // Example logic to get the image path based on exercise name and gender
//     if (exerciseName.contains('Abs Workout')) {
//       return gender == 'female' ? AppImagePaths.femaleAbsWorkout : AppImagePaths
//           .maleAbs;
//     }
//     if (exerciseName.contains('Chest Workout')) {
//       return gender == 'female'
//           ? AppImagePaths.femaleChestWorkout
//           : AppImagePaths.maleChestWorkout;
//     }
//     if (exerciseName.contains('Arm Workout')) {
//       return gender == 'female'
//           ? AppImagePaths.femaleArmWorkout
//           : AppImagePaths.maleArmWorkout;
//     }
//     if (exerciseName.contains('Leg Workout')) {
//       return gender == 'female'
//           ? AppImagePaths.femaleLegWorkout
//           : AppImagePaths.maleLegWorkout;
//     }
//     if (exerciseName.contains('Shoulder Workout')) {
//       return gender == 'female'
//           ? AppImagePaths.femaleShoulderWorkout
//           : AppImagePaths.maleShoulderWorkout;
//     }
//     if (exerciseName.contains('Back Workout')) {
//       return gender == 'female'
//           ? AppImagePaths.femaleBackWorkout
//           : AppImagePaths.maleBackWorkout;
//     }
//     // Add more conditions for other exercise types and genders
//     return gender == 'female' ? AppImagePaths.male : AppImagePaths.female;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print('gender is  $gender');
//     print('Exercise name is $exerciseName');
//     final bool dark = MyAppHelperFunctions.isDarkMode(context);
//     List<Map<String, String>> exerciseList = _getExerciseList();
//     final imagePath = _getImagePath();
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(
//                 height: AppSizes.appBarHeight,
//               ),
//               Container(
//                 width: AppDevicesUtils.getScreenWidth(context) * 0.95,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: AssetImage(imagePath),
//                   ),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.transparent,
//                       spreadRadius: 1,
//                       blurRadius: 2,
//                       offset: Offset(0, 1),
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
//                             style: Theme
//                                 .of(context)
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
//                             style: Theme
//                                 .of(context)
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
//                 height: AppSizes.spaceBtwItems - 10,
//               ),
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: exerciseList.length,
//                 itemBuilder: (context, index) {
//                   String imageUrl = gender == 'female'
//                       ? exerciseList[index]['femaleAbs'] ?? AppImagePaths.female // Use fallback if null
//                       : exerciseList[index]['male'] ?? AppImagePaths.male; // Assuming 'male' is a fallback
//
//
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: ExerciseDetailWidget(
//                       dark: dark,
//                       exerciseName: exerciseList[index]['exerciseName']!,
//                       exercieRep: exerciseList[index]['exerciseRepetition']!,
//                       imageUrl: imageUrl,
//                       exerciseType: exerciseName, gender: gender, exerciseList: exerciseList,
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(
//                 height: AppSizes.appBarHeight - 20,
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 child: ButtonWidget(
//                   dark: dark,
//                   onPressed: () {
//                     Get.to( ExerciseProgressScreen(exerciseList: exerciseList, exerciseName: exerciseName, gender: gender,));
//                   },
//                   buttonText: 'Start',
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
// }
//
// List<Map<String, String>> chestExercise = [
//   {
//     'male': AppImagePaths.maleChest,
//     'female': AppImagePaths.femaleChest,
//     'exerciseName': 'Jumping Jack',
//     'exerciseRepetition': '00:20 sec x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleChest,
//     'female': AppImagePaths.femaleChest,
//     'exerciseName': 'Knee Push-Ups',
//     'exerciseRepetition': '06 Reps x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleChest,
//     'female': AppImagePaths.femaleChest,
//     'exerciseName': 'Incline Push-Ups',
//     'exerciseRepetition': '06 Reps x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleChest,
//     'female': AppImagePaths.femaleChest,
//     'exerciseName': 'Push-Ups',
//     'exerciseRepetition': '06 Reps x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleChest,
//     'female': AppImagePaths.femaleChest,
//     'exerciseName': 'Wide Arm Push-Ups',
//     'exerciseRepetition': '05 Reps x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleChest,
//     'female': AppImagePaths.femaleChest,
//     'exerciseName': 'Triceps-Dips',
//     'exerciseRepetition': '06 Reps x 1 set',
//   },
//   {
//     'male': AppImagePaths.maleChest,
//     'female': AppImagePaths.femaleChest,
//     'exerciseName': 'Cobra Stretch',
//     'exerciseRepetition': '00:30 sec x 1 set',
//   },
//   {
//     'male': AppImagePaths.maleChest,
//     'female': AppImagePaths.femaleChest,
//     'exerciseName': 'Chest Stretch',
//     'exerciseRepetition': '00:20 sec x 2 sets',
//   },
// ];
//
// List<Map<String, String>> absExercise = [
//   {
//     'male': AppImagePaths.maleAbs,
//     'female': AppImagePaths.femaleAbs,
//     'exerciseName': 'Jumping Jack',
//     'exerciseRepetition': '00:20 sec x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleAbs,
//     'female': AppImagePaths.femaleAbs,
//     'exerciseName': 'Abdominal Crunches',
//     'exerciseRepetition': '08 Reps x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleAbs,
//     'female': AppImagePaths.femaleAbs,
//     'exerciseName': 'Russian Twist',
//     'exerciseRepetition': '10 Reps x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleAbs,
//     'female': AppImagePaths.femaleAbs,
//     'exerciseName': 'Heel Touch',
//     'exerciseRepetition': '00:20 sec x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleAbs,
//     'female': AppImagePaths.femaleAbs,
//     'exerciseName': 'Spine Lumber Twist Left',
//     'exerciseRepetition': '00:20 sec x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleAbs,
//     'female': AppImagePaths.femaleAbs,
//     'exerciseName': 'Spine Lumber Twist Right',
//     'exerciseRepetition': '00:20 sec x 2 sets',
//   },
// ];
//
// List<Map<String, String>> armsExercise = [
//   {
//     'male': AppImagePaths.maleArmWorkout,
//     'female': AppImagePaths.femaleArm,
//     'exerciseName': 'Arm Raises',
//     'exerciseRepetition': '00:10 sec x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleArmWorkout,
//     'female': AppImagePaths.femaleArm,
//     'exerciseName': 'Side Arm Raises',
//     'exerciseRepetition': '00:30 sec x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleArmWorkout,
//     'female': AppImagePaths.femaleArm,
//     'exerciseName': 'Triceps Dips',
//     'exerciseRepetition': '06 Reps x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleArmWorkout,
//     'female': AppImagePaths.femaleArm,
//     'exerciseName': 'Diamond Push-Ups',
//     'exerciseRepetition': '06 Reps x 1 set',
//   },
//   {
//     'male': AppImagePaths.maleArmWorkout,
//     'female': AppImagePaths.femaleArm,
//     'exerciseName': 'Jumping Jacks',
//     'exerciseRepetition': '00:20 sec x 2 sets',
//   },
// ];
//
// List<Map<String, String>> legExercise = [
//   {
//     'male': AppImagePaths.maleLegWorkout,
//     'female': AppImagePaths.femaleLegWorkout,
//     'exerciseName': 'Side Hops',
//     'exerciseRepetition': '00:10 sec x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleLegWorkout,
//     'female': AppImagePaths.femaleLegWorkout,
//     'exerciseName': 'Squats',
//     'exerciseRepetition': '06 Reps x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleLegWorkout,
//     'female': AppImagePaths.femaleLegWorkout,
//     'exerciseName': 'Side Lying Leg Lift Left',
//     'exerciseRepetition': '06 Reps x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleLegWorkout,
//     'female': AppImagePaths.femaleLegWorkout,
//     'exerciseName': 'Side Lying Leg Lift Right',
//     'exerciseRepetition': '06 Reps x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleLegWorkout,
//     'female': AppImagePaths.femaleLegWorkout,
//     'exerciseName': 'Backward Lunge',
//     'exerciseRepetition': '06 Reps Each x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleLegWorkout,
//     'female': AppImagePaths.femaleLegWorkout,
//     'exerciseName': 'Donkey Kicks',
//     'exerciseRepetition': '06 Reps Each x 2 sets',
//   },
// ];
//
// List<Map<String, String>> backExercise = [
//   {
//     'male': AppImagePaths.maleBackWorkout,
//     'female': AppImagePaths.femaleBackWorkout,
//     'exerciseName': 'Side Hops',
//     'exerciseRepetition': '00:10 sec x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleBackWorkout,
//     'female': AppImagePaths.femaleBackWorkout,
//     'exerciseName': 'Squats',
//     'exerciseRepetition': '06 Reps x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleBackWorkout,
//     'female': AppImagePaths.femaleBackWorkout,
//     'exerciseName': 'Side Lying Leg Lift Left',
//     'exerciseRepetition': '06 Reps x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleBackWorkout,
//     'female': AppImagePaths.femaleBackWorkout,
//     'exerciseName': 'Side Lying Leg Lift Right',
//     'exerciseRepetition': '06 Reps x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleBackWorkout,
//     'female': AppImagePaths.femaleBackWorkout,
//     'exerciseName': 'Backward Lunge',
//     'exerciseRepetition': '06 Reps Each x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleBackWorkout,
//     'female': AppImagePaths.femaleBackWorkout,
//     'exerciseName': 'Donkey Kicks',
//     'exerciseRepetition': '06 Reps Each x 2 sets',
//   },
// ];
//
// List<Map<String, String>> shoulderExercise = [
//   {
//     'male': AppImagePaths.maleShoulderWorkout,
//     'female': AppImagePaths.femaleShoulderWorkout,
//     'exerciseName': 'Jumping Jack',
//     'exerciseRepetition': '00:20 sec x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleShoulderWorkout,
//     'female': AppImagePaths.femaleShoulderWorkout,
//     'exerciseName': 'Knee Push-Ups',
//     'exerciseRepetition': '06 Reps x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleShoulderWorkout,
//     'female': AppImagePaths.femaleShoulderWorkout,
//     'exerciseName': 'Side Lying Leg Lift Left',
//     'exerciseRepetition': '06 Reps x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleShoulderWorkout,
//     'female': AppImagePaths.femaleShoulderWorkout,
//     'exerciseName': 'Side Lying Leg Lift Right',
//     'exerciseRepetition': '06 Reps x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleShoulderWorkout,
//     'female': AppImagePaths.femaleShoulderWorkout,
//     'exerciseName': 'Arm Raises',
//     'exerciseRepetition': '00:10 sec x 2 sets',
//   },
//   {
//     'male': AppImagePaths.maleShoulderWorkout,
//     'female': AppImagePaths.femaleShoulderWorkout,
//     'exerciseName': 'Side Arm Raises',
//     'exerciseRepetition': '00:30 sec x 2 sets',
//   },
// ];
//
//



import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/common/widgets/ButtonWidget.dart';
import 'package:fitness/screens/exercise_screen/exercise_start_screen/ExerciseProgressScreen.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:fitness/utils/constants/AppImagePaths.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/AppColor.dart';
import 'widgets/ExerciseDetailWidget.dart';



class AbsScreen extends StatefulWidget {
  const AbsScreen({
    super.key,
    required this.exerciseType,
    required this.gender,
    required this.exerciseRepititon,
  });


  final String exerciseRepititon;

  final String exerciseType;
  final String gender;

  @override
  _AbsScreenState createState() => _AbsScreenState();
}

class _AbsScreenState extends State<AbsScreen> {
  List<Map<String, String>> exerciseList = []; // Store exercise names and repetitions
  bool isLoading = true; // Show loading indicator while data is being fetched

  @override
  void initState() {
    super.initState();

    print('data is  ${widget.exerciseType}');

    _getImagePath();
    getData();
  }

  String getImagePath(){


       return widget.gender == 'female' ? AppImagePaths.male : AppImagePaths.female;

  }
  Future<void> getData() async {
    // Reference to the specific exercise name
    DatabaseReference databaseReference =
    FirebaseDatabase.instance.ref("Exercise").child(widget.exerciseType);

    // Fetch the snapshot of the data
    DataSnapshot snapshot = await databaseReference.get();

    if (snapshot.exists) {
      // Initialize a list to hold fetched exercises
      List<Map<String, String>> fetchedExercises = [];

      // Iterate through each child in the snapshot
      for (var child in snapshot.children) {
        // Ensure child has a key
        if (child.key != null) {
          // Fetch the value of the specific child (assuming the value is under a specific child name like 'Reps')
          String? repetition = child.child("exerciseRepetition").value?.toString();
          String? durarions = child.child("durarions").value?.toString();

          print('duration is $durarions');
          if (repetition != null) {
            // Create a map with exercise name and its single repetition value
            fetchedExercises.add({
              "exerciseName": child.key!,
              "exerciseRepetition": repetition,
            });

            // Print exerciseName and exerciseRepetition in brackets
            print('Exercise Name: [${child.key!}]');
            print('Exercise Repetition: [${repetition}]');
          }
        }
      }

      // Update the state to reflect the fetched data
      setState(() {
        exerciseList = fetchedExercises;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('No data exists for the given exercise.');
    }
  }


  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);
    final imagePath = _getImagePath();

    print(imagePath);

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
              // Header Section with Exercise Name and Repetition
              Container(
                width: AppDevicesUtils.getScreenWidth(context) * 0.95,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(imagePath), // Set your image here
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
                child: Stack(
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
                            widget.exerciseType,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                              color: AppColor.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.1,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Exercise Repetition',
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.displayLarge!.copyWith(
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
              const SizedBox(height: AppSizes.spaceBtwItems - 10),
              // Loading indicator if data is still being fetched
              if (isLoading)
                const CircularProgressIndicator(),
              // ListView of exercises once data is loaded
              if (!isLoading && exerciseList.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: exerciseList.length,
                  itemBuilder: (context, index) {
                    final exercise = exerciseList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ExerciseDetailWidget(
                        dark: dark,
                        exerciseName: exercise["exerciseName"]!,
                        exercieRep: exercise["exerciseRepetition"]!,
                        imageUrl: imagePath, // Add image URL if you have one
                        exerciseType: widget.exerciseType,
                        gender: widget.gender,
                        exerciseList: [], // Add your list here if needed
                      ),
                    );
                  },
                ),
              if (!isLoading && exerciseList.isEmpty)
                const Text('No exercises found.'),

              const SizedBox(height: AppSizes.appBarHeight - 20),
              // Start Button
              SizedBox(
                width: double.infinity,
                child: ButtonWidget(
                  dark: dark,
                  onPressed: () {
                    Get.to(ExerciseProgressScreen(
                      gender: widget.gender, exerciseType: widget.exerciseType,
                    ));
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




  String _getImagePath() {
    // Example logic to get the image path based on exercise name and gender
    if (widget.exerciseType.contains('Abs Workout')) {
      return widget.gender == 'female' ? AppImagePaths.femaleAbsWorkout : AppImagePaths
          .maleAbs;
    }
    if (widget.exerciseType.contains('Chest Workout')) {
      return widget.gender == 'female'
          ? AppImagePaths.femaleChestWorkout
          : AppImagePaths.maleChestWorkout;
    }
    if (widget.exerciseType.contains('Arm Workout')) {
      return widget.gender == 'female'
          ? AppImagePaths.femaleArmWorkout
          : AppImagePaths.maleArmWorkout;
    }
    if (widget.exerciseType.contains('Leg Workout')) {
      return widget.gender == 'female'
          ? AppImagePaths.femaleLegWorkout
          : AppImagePaths.maleLegWorkout;
    }
    if (widget.exerciseType.contains('Shoulder Workout')) {
      return widget.gender == 'female'
          ? AppImagePaths.femaleShoulderWorkout
          : AppImagePaths.maleShoulderWorkout;
    }
    if (widget.exerciseType.contains('Back Workout')) {
      return widget.gender == 'female'
          ? AppImagePaths.femaleBackWorkout
          : AppImagePaths.maleBackWorkout;
    }
    // Add more conditions for other exercise types and genders
    return widget.gender == 'female' ? AppImagePaths.male : AppImagePaths.female;
  }
}