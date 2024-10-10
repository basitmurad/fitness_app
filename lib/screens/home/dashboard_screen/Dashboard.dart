
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/screens/home/dashboard_screen/widgets/ChallengedWidget.dart';
import 'package:fitness/screens/home/dashboard_screen/widgets/ExerciseWidget.dart';
import 'package:fitness/screens/home/dashboard_screen/widgets/FollowUserCard.dart';
import 'package:fitness/screens/home/dashboard_screen/widgets/TextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common/widgets/MyAppGridLayout.dart';
import '../../../utils/constants/AppColor.dart';
import '../../../utils/constants/AppImagePaths.dart';
import '../../../utils/constants/AppSizes.dart';
import '../../../utils/constants/AppString.dart';
import '../../../utils/helpers/MyAppHelper.dart';

import '../../authentications/login_screen/LoginScreen.dart';

import '../../exercise_screen/abs_screen/AbsScreen.dart';
import '../social/post_screen/AddPostScreen.dart';


List<Map<String, String>> maleExercise = [
  {
    'imagePath': AppImagePaths.maleAbsWorkout,
    'exerciseName': 'Abs Workout',
    'exerciseRepetition': '06 Exercise',
  },
  {
    'imagePath': AppImagePaths.maleChestWorkout,
    'exerciseName': 'Chest Workout',
    'exerciseRepetition': '08 Exercise',
  },
  {
    'imagePath': AppImagePaths.maleArmWorkout,
    'exerciseName': 'Arm Workout',
    'exerciseRepetition': '05 Exercise',
  },
  {
    'imagePath': AppImagePaths.maleLegWorkout,
    'exerciseName': 'Legs Workout',
    'exerciseRepetition': '06 Exercise',
  },
  {
    'imagePath': AppImagePaths.maleShoulderWorkout,
    'exerciseName': 'Shoulder Workout',
    'exerciseRepetition': '04 Exercise',
  },
  {
    'imagePath': AppImagePaths.maleBackWorkout,
    'exerciseName': 'Back Workout',
    'exerciseRepetition': '05',
  },
];
List<Map<String, String>> femaleExercises = [
  {
    'imagePath': AppImagePaths.femaleAbsWorkout,
    'exerciseName': 'Abs Workout',
    'exerciseRepetition': '06 Exercise',
  },
  {
    'imagePath': AppImagePaths.femaleChestWorkout,
    'exerciseName': 'Chest Workout',
    'exerciseRepetition': '08 Exercise',
  },
  {
    'imagePath': AppImagePaths.femaleArmWorkout,
    'exerciseName': 'Arm Workout',
    'exerciseRepetition': '05 Exercise',
  },
  {
    'imagePath': AppImagePaths.femaleLegWorkout,
    'exerciseName': 'Legs Workout',
    'exerciseRepetition': '06 Exercise',
  },
  {
    'imagePath': AppImagePaths.femaleShoulderWorkout,
    'exerciseName': 'Shoulder Workout',
    'exerciseRepetition': '04 Exercise',
  },
  {
    'imagePath': AppImagePaths.femaleBackWorkout,
    'exerciseName': 'Back Workout',
    'exerciseRepetition': '05',
  },
];

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});


  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);
    late FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppStrings.dashboard),
        actions: [
          Image(
            width: 20,
            height: 20,
            color: dark ? AppColor.white : AppColor.black,
            image: const AssetImage(AppImagePaths.messages),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              firebaseAuth.signOut();
            },
            child: Image(
              width: 20,
              height: 20,
              color: dark ? AppColor.white : AppColor.black,
              image: const AssetImage(AppImagePaths.notification),
            ),
          ),
          const SizedBox(width: 8.0),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSizes.inputFieldRadius),
              ChallengedWidget(dark: dark),
              const SizedBox(height: AppSizes.inputFieldRadius - 5),
              Text(
                AppStrings.fitnessTitans,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: dark ? AppColor.white : AppColor.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: AppSizes.inputFieldRadius),
              MyAppGridLayout(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    child: FollowUserCard(dark: dark),
                  );
                },
                scrollDirection: Axis.horizontal,
              ),
              const SizedBox(height: AppSizes.spaceBtwInputFields),
              TextWidget(dark: dark),

              // Use FutureBuilder to handle the async gender fetching
              FutureBuilder<String>(
                future: _fetchUserGender(), // Call the gender fetching function
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show loading while waiting for the future to complete
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // Handle errors
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    // Once the data (gender) is received, update the exercise list based on gender
                    String gender = snapshot.data!;
                    List<Map<String, String>> exercisesList = gender == 'Female'
                        ? femaleExercises
                        : maleExercise;

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: exercisesList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.zero,
                          child: GestureDetector(
                            onTap: () {
                              Get.to(AbsScreen(
                                exerciseType:
                                exercisesList[index]['exerciseName']!,
                                exerciseRepititon:
                                exercisesList[index]['exerciseRepetition']!,
                                gender: gender,
                              ));
                            },
                            child: ExerciseWidget(
                              dark: dark,
                              imagePath: exercisesList[index]['imagePath']!,
                              exerciseName:
                              exercisesList[index]['exerciseName']!,
                              exerciseRepeation:
                              exercisesList[index]['exerciseRepetition']!,
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    // If no data is available
                    return const Text('No gender data available.');
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddPostScreen());
        },
        backgroundColor: AppColor.orangeColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), // Ensures the shape is a circle
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 45), // Customize the FAB icon
      ),
    );
  }

  Future<String> _fetchUserGender() async {
    final User? user = FirebaseAuth.instance.currentUser;
    String gender = 'male'; // Default value for gender

    if (user == null) {
      // If user is not logged in, navigate to login screen
      Get.to(() => LoginScreen());
      throw Exception('User not logged in');
    }

    String userId = user.uid; // Get user ID
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

    try {
      DataSnapshot snapshot = await databaseReference.child('users/$userId').get();

      if (snapshot.exists && snapshot.value is Map) {
        Map<Object?, Object?> userData = snapshot.value as Map<Object?, Object?>;
        gender = userData['gender'] as String? ?? gender;

        print('gender $gender');// Update gender if found
      } else {
        debugPrint("No user data found or data is not in the expected format.");
      }
    } catch (e) {
      debugPrint('Error fetching user gender: ${e.toString()}');
    }

    return gender; // Return the determined gender
  }



}
