//
// import 'package:fitness/screens/exercise_screen/exercise_start_screen/widgets/CenteredTextWithIconsRow.dart';
// import 'package:fitness/screens/exercise_screen/exercise_start_screen/widgets/CircleWithText.dart';
// import 'package:fitness/utils/constants/AppColor.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:fitness/common/widgets/ButtonWidget.dart';
// import 'package:fitness/screens/exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';
// import 'package:fitness/utils/constants/AppImagePaths.dart';
// import 'package:fitness/utils/constants/AppSizes.dart';
// import 'package:fitness/utils/helpers/MyAppHelper.dart';
// import 'package:fitness/utils/constants/AppDevicesUtils.dart';
// import 'dart:async'; // Import the async package for Timer
// import '../../exercise_screen_controller/ExerciseProgressController.dart';
//
// class ExerciseProgressScreen extends StatefulWidget {
//   const ExerciseProgressScreen({
//     super.key,
//     required this.exerciseList,
//     required this.exerciseName,
//     required this.gender,
//   });
//
//   final String exerciseName;
//   final String gender;
//   final List<Map<String, String>> exerciseList;
//
//   @override
//   _ExerciseProgressScreenState createState() => _ExerciseProgressScreenState();
// }
//
// class _ExerciseProgressScreenState extends State<ExerciseProgressScreen> {
//   final ExerciseProgressController controller = Get.put(ExerciseProgressController());
//
//   late String exerciseText;
//   late String imageUrl;
//   late String sets;
//   int currentIndex = 0;
//   int countdownSeconds = 20; // Starting countdown seconds
//   Timer? countdownTimer; // Timer variable to manage countdown
//
//   @override
//   void initState() {
//     super.initState();
//     updateExerciseDetails();
//   }
//
//   void updateExerciseDetails() {
//     if (widget.exerciseList.isNotEmpty) {
//       exerciseText = widget.exerciseList[currentIndex]['exerciseName'] ?? '';
//       imageUrl = widget.gender.toLowerCase() == 'male'
//           ? widget.exerciseList[currentIndex]['male'] ?? ''
//           : widget.exerciseList[currentIndex]['female'] ?? '';
//       sets = widget.exerciseList[currentIndex]['exerciseRepetition'] ?? '';
//     } else {
//       exerciseText = 'No Exercise';
//       imageUrl = '';
//     }
//   }
//
//   void goToPreviousExercise() {
//     if (currentIndex > 0) {
//       setState(() {
//         currentIndex--;
//         updateExerciseDetails();
//         startCountdown(); // Restart the countdown when changing exercises
//       });
//     }
//   }
//
//   void goToNextExercise() {
//     if (currentIndex < widget.exerciseList.length - 1) {
//       setState(() {
//         currentIndex++;
//         updateExerciseDetails();
//         startCountdown(); // Restart the countdown when changing exercises
//       });
//     }
//   }
//
//   void startCountdown() {
//     countdownSeconds = 20; // Reset countdown to 20 seconds
//     countdownTimer?.cancel(); // Cancel any existing timer
//     countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (countdownSeconds > 1) {
//         setState(() {
//           countdownSeconds--;
//         });
//       } else {
//         timer.cancel(); // Stop the timer when it reaches 1
//         goToNextExercise(); // Move to the next exercise
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     countdownTimer?.cancel(); // Cancel timer when the widget is disposed
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final bool dark = MyAppHelperFunctions.isDarkMode(context);
//
//     return Scaffold(
//       bottomNavigationBar: Obx(() {
//         return BottomAppBar(
//           height: 85,
//           padding: const EdgeInsets.only(bottom: 5),
//           color: Colors.transparent,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 18),
//             child: controller.isStartButtonVisible.value
//                 ? ButtonWidget(
//               dark: dark,
//               onPressed: () {
//                 controller.toggleButton(); // Hide Start button and show Paused button
//                 startCountdown(); // Start the countdown
//               },
//               buttonText: 'Start',
//             )
//                 : GestureDetector(
//               onTap: () {
//                 controller.toggleButton();
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: AppColor.orangeColor,
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.pause, color: Colors.white),
//                     Text(
//                       'Pause',
//                       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                         color: dark ? AppColor.white : AppColor.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                         fontFamily: 'Poppins',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       }),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(
//                 height: AppSizes.appBarHeight - 10,
//               ),
//               SimpleTextWidget(
//                 text: exerciseText,
//                 fontWeight: FontWeight.w700,
//                 fontSize: 24,
//                 color: dark ? AppColor.white : AppColor.black,
//                 fontFamily: 'Poppins',
//               ),
//               const SizedBox(
//                 height: AppSizes.spaceBtwItems,
//               ),
//               Container(
//                 width: AppDevicesUtils.getScreenWidth(context) * 0.95,
//                 height: 231,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: AssetImage(imageUrl),
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
//                         icon: const Icon(Icons.arrow_back, color: Colors.white),
//                         onPressed: () {
//                           Get.back();
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: AppSizes.appBarHeight),
//               CircleWithText(
//                 text: countdownSeconds.toString(), // Display the countdown seconds
//                 size: 144.0,
//                 borderColor: AppColor.orangeColor,
//                 backgroundColor: Colors.transparent,
//                 textColor: dark ? AppColor.white : AppColor.black,
//                 borderWidth: 12.0,
//               ),
//               const SizedBox(height: AppSizes.spaceBtwItems + 10),
//               Container(
//                 alignment: Alignment.center,
//                 child: SimpleTextWidget(
//                   text: sets,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16,
//                   color: dark ? AppColor.white : AppColor.black,
//                   fontFamily: 'Poppins',
//                 ),
//               ),
//               const SizedBox(height: AppSizes.spaceBtwItems + 10),
//               Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: CenteredTextWithIconsRow(
//                     text: '${currentIndex + 1}', // Show the current index + 1
//                     leftIcon: AppImagePaths.right,
//                     rightIcon: AppImagePaths.left,
//                     text1: '/' + '${widget.exerciseList.length}',
//                     textColor: dark ? AppColor.white : AppColor.black,
//                     onLeftIconPressed: goToPreviousExercise,
//                     onRightIconPressed: goToNextExercise,
//                     leftIconAngle: 0,
//                     rightIconAngle: 0,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/screens/exercise_screen/exercise_start_screen/widgets/CenteredTextWithIconsRow.dart';
import 'package:fitness/screens/exercise_screen/exercise_start_screen/widgets/CircleWithText.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitness/common/widgets/ButtonWidget.dart';
import 'package:fitness/screens/exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';
import 'package:fitness/utils/constants/AppImagePaths.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'dart:async'; // Import the async package for Timer
import '../../exercise_screen_controller/ExerciseProgressController.dart';

class ExerciseProgressScreen extends StatefulWidget {
  const ExerciseProgressScreen({
    super.key,
    required this.exerciseType,
    required this.gender,
  });

  final String exerciseType;
  final String gender;

  @override
  _ExerciseProgressScreenState createState() => _ExerciseProgressScreenState();
}



class _ExerciseProgressScreenState extends State<ExerciseProgressScreen> {
  // List<Map<String, String>> exerciseList = []; // Store exercise names and repetitions
  // bool isLoading = true; // Show loading indicator while data is being fetched
  //
  // Future<void> getData() async {
  //   // Reference to the specific exercise name
  //   DatabaseReference databaseReference =
  //   FirebaseDatabase.instance.ref("Exercise").child(widget.exerciseType);
  //
  //   // Fetch the snapshot of the data
  //   DataSnapshot snapshot = await databaseReference.get();
  //
  //   if (snapshot.exists) {
  //     // Initialize a list to hold fetched exercises
  //     List<Map<String, String>> fetchedExercises = [];
  //
  //     // Iterate through each child in the snapshot
  //     for (var child in snapshot.children) {
  //       // Ensure child has a key
  //       if (child.key != null) {
  //         // Fetch the value of the specific child (assuming the value is under a specific child name like 'Reps')
  //         String? repetition = child.child("exerciseRepetition").value?.toString();
  //
  //         if (repetition != null) {
  //           // Create a map with exercise name and its single repetition value
  //           fetchedExercises.add({
  //             "exerciseName": child.key!,
  //             "exerciseRepetition": repetition,
  //           });
  //
  //           // Print exerciseName and exerciseRepetition in brackets
  //           print('Exercise Name: [${child.key!}]');
  //           print('Exercise Repetition: [${repetition}]');
  //         }
  //       }
  //     }
  //
  //     // Update the state to reflect the fetched data only for the first exercise
  //     if (fetchedExercises.isNotEmpty) {
  //       setState(() {
  //         exerciseList = [fetchedExercises[0]]; // Only keep the first exercise
  //         isLoading = false;
  //       });
  //     } else {
  //       setState(() {
  //         isLoading = false;
  //       });
  //       print('No data exists for the given exercise.');
  //     }
  //   } else {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     print('No data exists for the given exercise.');
  //   }
  // }

  final ExerciseProgressController controller = Get.put(ExerciseProgressController());


  @override
  void initState() {
    super.initState();

    // getData();
  }



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(() {
        return BottomAppBar(
          height: 85,
          padding: const EdgeInsets.only(bottom: 5),
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 18),
            child: controller.isStartButtonVisible.value
                ? ButtonWidget(
              dark: dark,
              onPressed: () {
                controller
                    .toggleButton(); // Hide Start button and show Paused button
              },
              buttonText: 'Start',
            )
                : GestureDetector(
              onTap: () {
                controller.toggleButton();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.orangeColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.pause, color: Colors.white),
                    Text(
                      'Pause',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                        color: dark ? AppColor.white : AppColor.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: AppSizes.appBarHeight - 10,
              ),
              SimpleTextWidget(
                text: "",
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: dark ? AppColor.white : AppColor.black,
                fontFamily: 'Poppins',
              ),
              const SizedBox(
                height: AppSizes.spaceBtwItems,
              ),
              Container(
                width: AppDevicesUtils.getScreenWidth(context) * 0.95,
                height: 231,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(AppImagePaths.femaleLegWorkout),
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
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.appBarHeight),
              CircleWithText(
                text: 'dsfds',
                // Display the countdown seconds
                size: 144.0,
                borderColor: AppColor.orangeColor,
                backgroundColor: Colors.transparent,
                textColor: dark ? AppColor.white : AppColor.black,
                borderWidth: 12.0,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems + 10),
              Container(
                alignment: Alignment.center,
                child: SimpleTextWidget(
                  text: "",


                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: dark ? AppColor.white : AppColor.black,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems + 10),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CenteredTextWithIconsRow(
                    text: '1',
                    // Show the current index + 1
                    leftIcon: AppImagePaths.right,
                    rightIcon: AppImagePaths.left,
                    text1: "",
                    textColor: dark ? AppColor.white : AppColor.black,
                    onLeftIconPressed: () {},
                    onRightIconPressed: () {},
                    leftIconAngle: 0,
                    rightIconAngle: 0,
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
