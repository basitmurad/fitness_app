import 'package:fitness/common/widgets/MyAppGridLayout.dart';
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
    String gender ='female';
    final bool dark = MyAppHelperFunctions.isDarkMode(context);
    final List<Map<String, String>> exercisesList = gender == 'female' ? femaleExercises : maleExercise;

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
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                        Get.to(AbsScreen(exerciseName: exercisesList[index]['exerciseName']!,
                          exerciseRepititon: exercisesList[index]['exerciseRepetition']!,));
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
}
