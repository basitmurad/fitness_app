import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/common/widgets/MyAppGridLayout.dart';
import 'package:fitness/screens/authentications/date_birth_screen/DateOfBirthScreen.dart';
import 'package:fitness/screens/authentications/weight_screen/WeightScreen.dart';
import 'package:fitness/screens/exercise_screen/abs_screen/AbsScreen.dart';
import 'package:fitness/screens/home/dashboard/widgets/ChallengedWidget.dart';
import 'package:fitness/screens/home/dashboard/widgets/ExerciseWidget.dart';
import 'package:fitness/screens/home/dashboard/widgets/FollowUserCard.dart';
import 'package:fitness/screens/home/dashboard/widgets/TextWidget.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppImagePaths.dart';
import 'package:fitness/utils/constants/AppString.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/AppSizes.dart';
import '../../authentications/height_screen/HeightScreen.dart';
import '../../authentications/login_screen/LoginScreen.dart';
import '../../authentications/name_screen/NameScreen.dart';
import '../../authentications/select_gender_screen/SelectGenderScreen.dart';
import '../../authentications/target_weight_screen/TargetWeightScreen.dart';
import '../controller/DashboardController.dart';

List<String> fitnessSliderTexts = [
  "Push Beyond Your Limits.Your Strongest Self Awaits!",
  "Elevate Your Fitness Journey. Every Step Counts.",
  "Unlock Your Potential. Transform Your Body, Transform Your Life.",
  "Strive for Progress, Not Perfection. Your Best is Yet to Come.",
  "Embrace the Challenge. Strength and Success Start Here.",
  "Reimagine Your Limits. Discover What You’re Capable Of.",
  "Stay Committed, Stay Strong. Your Journey, Your Rules.",
  "Rise and Grind. Every Workout is a Step Closer to Greatness.",
  "Ignite Your Passion. Fitness is a Lifestyle, Not a Fad.",
  "Challenge Yourself Today for a Better Tomorrow. Keep Moving Forward."
];

List<Map<String, String>> maleExercise = [
  {
    'imagePath': AppImagePaths.maleAbsWorkout,
    'exerciseName': 'Abs Workout',
    'exerciseRepetition': '09 Exercise',
  },
  {
    'imagePath': AppImagePaths.maleChestWorkout,
    'exerciseName': 'Chest Workout',
    'exerciseRepetition': '08 Exercise',
  },
  {
    'imagePath': AppImagePaths.maleArmWorkout,
    'exerciseName': 'Arm Workout',
    'exerciseRepetition': '5 Exercise',
  },
  {
    'imagePath': AppImagePaths.maleLegWorkout,
    'exerciseName': 'Leg Workout',
    'exerciseRepetition': '6 Exercise',
  },
  {
    'imagePath': AppImagePaths.maleShoulderWorkout,
    'exerciseName': 'Shoulder Workout',
    'exerciseRepetition': '6 Exercise',
  },
  {
    'imagePath': AppImagePaths.maleBackWorkout,
    'exerciseName': 'Back Workout',
    'exerciseRepetition': '6',
  },
];
List<Map<String, String>> femaleExercises = [
  {
    'imagePath': AppImagePaths.femaleAbsWorkout,
    'exerciseName': 'Abs Workout',
    'exerciseRepetition': '09 Exercise',
  },
  {
    'imagePath': AppImagePaths.femaleChestWorkout,
    'exerciseName': 'Chest Workout',
    'exerciseRepetition': '08 Exercise',
  },
  {
    'imagePath': AppImagePaths.femaleArmWorkout,
    'exerciseName': 'Arm Workout',
    'exerciseRepetition': '5 Exercise',
  },
  {
    'imagePath': AppImagePaths.femaleLegWorkout,
    'exerciseName': 'Leg Workout',
    'exerciseRepetition': '6 Exercise',
  },
  {
    'imagePath': AppImagePaths.femaleShoulderWorkout,
    'exerciseName': 'Shoulder Workout',
    'exerciseRepetition': '6 Exercise',
  },
  {
    'imagePath': AppImagePaths.femaleBackWorkout,
    'exerciseName': 'Back Workout',
    'exerciseRepetition': '6',
  },
];

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController dashboardController = Get.put(DashboardController());
    String gender = 'female';
    final bool dark = MyAppHelperFunctions.isDarkMode(context);
    final List<Map<String, String>> exercisesList = gender == 'female'
        ? femaleExercises
        : maleExercise;


    _checkUserData(context);

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
          Image(
            width: 20,
            height: 20,
            color: dark ? AppColor.white : AppColor.black,
            image: const AssetImage(AppImagePaths.notification),
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
              const SizedBox(
                height: AppSizes.inputFieldRadius,
              ),
              ChallengedWidget(dark: dark),
              const SizedBox(
                height: AppSizes.inputFieldRadius - 5,
              ),
              Text(
                AppStrings.fitnessTitans,
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(
                    color: dark ? AppColor.white : AppColor.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: AppSizes.inputFieldRadius,
              ),
              MyAppGridLayout(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
                      child: FollowUserCard(dark: dark),
                    );
                  }),
              const SizedBox(
                height: AppSizes.spaceBtwInputFields,
              ),
              TextWidget(dark: dark),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: exercisesList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.zero,
                    child: GestureDetector(
                      onTap: () {
                        // Pass the exercise name when navigating to AbsScreen
                        Get.to(AbsScreen(
                          exerciseName: exercisesList[index]['exerciseName']!,
                          exerciseRepititon: exercisesList[index]['exerciseRepetition']!,
                          gender: gender,));
                      },
                      child: ExerciseWidget(
                        dark: dark,
                        imagePath: exercisesList[index]['imagePath']!,
                        exerciseName: exercisesList[index]['exerciseName']!,
                        exerciseRepeation: exercisesList[index]['exerciseRepetition']!,
                      ),
                    ),
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> _checkUserData(BuildContext context) async {
    final User? user = FirebaseAuth.instance.currentUser; // Get the current user
    if (user == null) {
      // Handle the case when no user is logged in
      Get.to(() => LoginScreen());
      return;
    }

    String userId = user.uid; // Get user ID
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

    try {
      DataSnapshot snapshot = await databaseReference.child('users/$userId').get();

      if (snapshot.exists) {
        // Check if the snapshot value is a Map
        if (snapshot.value is Map) {
          Map<Object?, Object?> userData = snapshot.value as Map<Object?, Object?>;
          debugPrint("User Data: $userData"); // Log the entire user data

          // Extract the required fields
          String? gender = userData['gender'] as String?;
          String? name = userData['name'] as String?;
          int? age = int.tryParse(userData['age']?.toString() ?? '') ?? 0; // Convert to int
          String? email = userData['email'] as String?;
          String? height = userData['height'] as String?;
          String? currentWeight = userData['weight'] as String?;
          int? targetWeight = int.tryParse(userData['targetWeight']?.toString() ?? '') ?? null; // Convert to int

          // Navigate based on the presence of data
          if (email != null && email.isNotEmpty) {
            if (gender == null || gender.isEmpty) {
              debugPrint("Navigating to SelectGenderScreen");
              Get.to(() => SelectGenderScreen(email: email, password: ''));
            } else if (name == null || name.isEmpty) {
              debugPrint("Navigating to NameScreen");
              Get.to(() => NameScreen(email: email, gender: gender, password: '',));
            } else if (age == null || age == 0) {
              debugPrint("Navigating to DateOfBirthScreen");
              Get.to(() => DateOfBirthScreen(email: email, password: '', gender: gender, name: name));
            } else if (height == null) {
              debugPrint("Navigating to HeightScreen");
              Get.to(() => HeightScreen(email: email, password: '', gender: gender, name: name, year: age));
            } else if (currentWeight == null || currentWeight.isEmpty) {
              debugPrint("Navigating to WeightScreen");
              Get.to(() => WeightScreen(email: email, password: '', gender: gender, name: name, height: height, year: age,));
              debugPrint("Age: $age, Current Weight: $currentWeight, Target Weight: $targetWeight");


            } else if (targetWeight == null) {
              debugPrint("Navigating to TargetWeightScreen");
              Get.to(() => TargetWeightScreen(email: email, password: '', gender: gender, name: name, height: height, currentWeight: currentWeight, year: age,));
            } else {
              // If all data is present, navigate to Dashboard and print user data
              Get.to(Dashboard());
              debugPrint("User Data: Email: $email, Name: $name, Gender: $gender, Age: $age, Height: $height, Current Weight: $currentWeight, Target Weight: $targetWeight");
            }
          } else {
            debugPrint("Email is missing.");
          }
        } else {
          debugPrint("User data is not in the expected format.");
        }
      } else {
        debugPrint("No user data found for this user ID.");
      }
    } catch (e) {
      debugPrint('Error checking user data: ${e.toString()}');
    }
  }



}