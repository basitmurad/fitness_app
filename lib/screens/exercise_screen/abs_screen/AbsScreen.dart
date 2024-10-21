
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/common/widgets/ButtonWidget.dart';
import 'package:fitness/screens/exercise_screen/exercise_start_screen/ExerciseProgressScreen.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:fitness/utils/constants/AppImagePaths.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    print('name is ${widget.exerciseType}');

    _getImagePath();
    getData();
    getData1();
  }




  String getImagePath(){


       return widget.gender == 'female' ? AppImagePaths.male : AppImagePaths.female;

  }
  Future<void> getData() async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref("Exercise").child(widget.exerciseType);
    print('Fetching data from: ${databaseReference.path}'); // Debugging print statement

    DataSnapshot snapshot = await databaseReference.get();

    if (snapshot.exists) {
      List<Map<String, String>> fetchedExercises = [];
      for (var child in snapshot.children) {
        if (child.key != null) {
          String? repetition = child.child("exerciseRepetition").value?.toString();
          if (repetition != null) {
            fetchedExercises.add({
              "exerciseName": child.key!,
              "exerciseRepetition": repetition,
            });
            print('Fetched: ${child.key!} - Repetition: $repetition'); // Debugging print
          }
        }
      }
      setState(() {
        exerciseList = fetchedExercises;
        isLoading = false;
      });


    } else {
      print('No data exists for the given exercise type: ${widget.exerciseType}');
      setState(() {
        isLoading = false;
      });
    }
  }
  Future<void> getData1() async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref("Exercise").child(widget.exerciseType);
    print('Fetching data from: ${databaseReference.path}'); // Debugging print statement

    DataSnapshot snapshot = await databaseReference.get();

    if (snapshot.exists) {
      List<Map<String, String>> fetchedExercises = [];
      for (var child in snapshot.children) {
        if (child.key != null) {
          String? repetition = child.child("exerciseRepetition").value?.toString();
          String? durations = child.child("durations").value?.toString(); // Fixed typo from "durarions" to "durations"
          String? musclePath;

          // Access the multimedia node to get musclePath based on gender
          if (widget.gender.toLowerCase() == 'female') {
            musclePath = child.child("multimedia").child("female").child("musclePath").value?.toString(); // Updated path
          } else if (widget.gender.toLowerCase() == 'male') {
            musclePath = child.child("multimedia").child("male").child("musclePath").value?.toString(); // Updated path
          }

          print('Muscle image is $musclePath');

          if (repetition != null) {
            fetchedExercises.add({
              "exerciseName": child.key!,
              "exerciseRepetition": repetition,
              "durations": durations ?? 'N/A',
              "musclePath": musclePath ?? 'N/A', // Default to 'N/A' if musclePath is null
            });

            print('Child Key: ${child.key}');
            print('Female data: ${child.child("multimedia").child("female").value}'); // Updated path
            print('Male data: ${child.child("multimedia").child("male").value}'); // Updated path
          }
        }
      }
      setState(() {
        exerciseList = fetchedExercises;
        isLoading = false;
      });
      await _storeDataInSharedPreferences(fetchedExercises);
    } else {
      print('No data exists for the given exercise type: ${widget.exerciseType}');
      setState(() {
        isLoading = false;
      });
    }
  }





  Future<void> _storeDataInSharedPreferences(List<Map<String, String>> exercises) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Convert the List of Map to a List of JSON Strings for storage
    List<String> jsonExercises = exercises.map((exercise) => jsonEncode(exercise)).toList();

    // Store the List of JSON Strings in Shared Preferences
    await prefs.setStringList('exercises_${widget.exerciseType}', jsonExercises);
    print('Stored exercises in Shared Preferences for type: ${widget.exerciseType}');
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
                            widget.exerciseRepititon,
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
    if (widget.exerciseType.contains('Legs Workout')) {
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