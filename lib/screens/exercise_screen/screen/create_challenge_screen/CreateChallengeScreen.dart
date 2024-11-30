import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/common/snackbar/ShowSnackbar.dart';
import 'package:fitness/common/widgets/ButtonWidget.dart';
import 'package:fitness/screens/exercise_screen/screen/create_challenge_screen/widgets/NotifyWidgets.dart';
import 'package:fitness/screens/home/dashboard_screen/Dashboard.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/AppColor.dart';
import '../../../../utils/constants/AppString.dart';
import '../../../../utils/helpers/MyAppHelper.dart';
import '../../exercise_screen_controller/CreateChallengeScreenController.dart';
import '../challenge_screen/ChallengeScreen.dart';
import '../exercise_detail_screen/widgets/SimpleTextWidget.dart';

class CreateChallengeScreen extends StatelessWidget {
  const CreateChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> durations = ['07 Days', '15 Days', '30 Days'];
    final List<String> seeList = ['Everyone', 'Followers', 'Only me'];

    final List<String> fitnessChallenges = [
      'Push-Up Challenge',
      '10,000 Steps a Day',
      '15-Minute Daily Yoga',
      'Run a Mile a Day'
    ];
    final List<String> fitnessChallengesSubtitle = [
      'Increase daily push-ups each day',
      'Walk 10,000 steps daily',
      'Practice yoga for 15 minutes each day.',
      'Run one mile every day for a month'
    ];

    final List<String> wellnessChallenge = [
      'Daily Meditation',
      'Hydration Challenge',
      'No Sugar Week',
      'Sleep Improvement',
      'Digital Detox'
    ];
    final List<String> wellnessChallengeSubtitles = [
      'Meditate for 10 minutes daily for 21 days',
      ' Drink 8 glasses of water each day.',
      'Avoid added sugars.',
      'Aim for 8 hours of sleep each night.',
      'Limit screen time to 2 hours a day for a week.'
    ];

    final List<String> personalGrowth = [
      'Gratitude Journal',
      'Learn a New Skill',
      'Random Acts of Kindness',
      'Daily Reading',
      'Declutter Challenge'
    ];
    final List<String> personalGrowthSubtitle = [
      'Write down three things your are grateful for each day.',
      'Dedicate 20 minutes daily to learning something new.',
      'Do one kind act for someone each day .',
      'Read 10 pages of a book every day.',
      'Organize one area of your home each day for.'
    ];
    final List<String> selectedChallenges = [];
    String duration ="";
    String seeListw ="";





    final bool dark = MyAppHelperFunctions.isDarkMode(context);
    CreateChallengeScreenController controller =
        Get.put(CreateChallengeScreenController());


    print('============================data============== ${selectedChallenges}');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Get.to(const ChallengeScreen());
            },
            icon: Icon(
              Icons.arrow_back,
              color: dark ? AppColor.white : AppColor.black,
            )),
        title: SimpleTextWidget(
            align: TextAlign.center,
            text: AppStrings.textCreateChallenge,
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: dark ? AppColor.white : AppColor.black,
            fontFamily: 'Poppins'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: AppSizes.spaceBtwSections - 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: dark
                        ? AppColor.grey.withOpacity(0.3)
                        : AppColor.white, // Background color of the container
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        // Shadow color
                        spreadRadius: 1,
                        // Spread radius (how much the shadow grows)
                        blurRadius: 3,
                        // Blur radius (how soft or sharp the shadow is)
                        offset: const Offset(
                            0, 2), // Offset in x and y (horizontal, vertical)
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.only(left: 8),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SimpleTextWidget(
                        text: 'Select challenges',
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: dark ? AppColor.white : AppColor.black,
                        fontFamily: 'Poppins',
                      ),
                      IconButton(
                        onPressed: () {
                          // Clear the selectedChallenges list when the button is pressed
                          controller.selectedChallenges.clear(); // This will be reactive
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return DraggableScrollableSheet(
                                expand: false,
                                builder: (context, scrollController) {
                                  return SingleChildScrollView(
                                    controller: scrollController,
                                    child: Container(
                                      color: dark
                                          ? AppColor.grey.withOpacity(0.1)
                                          : AppColor.grey.withOpacity(0.2),
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          // Fitness Challenges ExpansionTile
                                          ExpansionTile(
                                            title: const Text('Fitness Challenges'),
                                            leading: const Icon(Icons.star),
                                            children: [
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount: fitnessChallenges.length,
                                                itemBuilder: (context, index) {
                                                  return Obx(() {
                                                    bool isSelected = controller.selectedFitnessIndices.contains(index);
                                                    return ListTile(
                                                      title: Text(fitnessChallenges[index]),
                                                      subtitle: controller.isFitnessSubtitleVisible(index)
                                                          ? Text(fitnessChallengesSubtitle[index])
                                                          : null,
                                                      tileColor: isSelected ? AppColor.orangeColor : controller.getFitnessTileColor(index),
                                                      onTap: () {
                                                        controller.updateSelectedFitnessIndex(index, fitnessChallenges);
                                                        // Add or remove challenge to/from selectedChallenges
                                                        if (isSelected) {
                                                          selectedChallenges.remove(fitnessChallenges[index]);
                                                        } else {
                                                          selectedChallenges.add(fitnessChallenges[index]);
                                                        }
                                                        print('Selected Challenges: $selectedChallenges');
                                                      },
                                                    );
                                                  });
                                                },
                                              ),
                                            ],
                                          ),

                                          // Wellness Challenges ExpansionTile
                                          ExpansionTile(
                                            title: const Text('Wellness Challenges'),
                                            leading: const Icon(Icons.star),
                                            children: [
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount: wellnessChallenge.length,
                                                itemBuilder: (context, index) {
                                                  return Obx(() {
                                                    bool isSelected = controller.selectedWellnessIndices.contains(index);
                                                    return ListTile(
                                                      title: Text(wellnessChallenge[index]),
                                                      subtitle: controller.isSelectedWellnessVisible(index)
                                                          ? Text(wellnessChallengeSubtitles[index])
                                                          : null,
                                                      tileColor: isSelected ? AppColor.orangeColor : controller.getSelectedWellnessColor(index),
                                                      onTap: () {
                                                        controller.updateSelectedWellnessIndex(index, wellnessChallenge);
                                                        // Add or remove wellness challenge to/from selectedChallenges
                                                        if (isSelected) {
                                                          selectedChallenges.remove(wellnessChallenge[index]);
                                                        } else {
                                                          selectedChallenges.add(wellnessChallenge[index]);
                                                        }
                                                        print('Selected Challenges: $selectedChallenges');
                                                      },
                                                    );
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          ExpansionTile(
                                            title: const Text('Personal Growth Challenges'),
                                            leading: const Icon(Icons.star),
                                            children: [
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount: personalGrowth.length,
                                                itemBuilder: (context, index) {
                                                  return Obx(() {
                                                    bool isSelected = controller.selectedPersonalGrowthIndices.contains(index);
                                                    return ListTile(
                                                      title: Text(personalGrowth[index]),
                                                      subtitle: controller.isSelectedPersonalGrowthVisible(index)
                                                          ? Text(personalGrowthSubtitle[index])
                                                          : null,
                                                      tileColor: isSelected ? AppColor.orangeColor : controller.getSelectedWellnessColor(index),
                                                      onTap: () {
                                                        controller.updateSelectedPersonalGrowthIndex(index, personalGrowth);
                                                        // Add or remove wellness challenge to/from selectedChallenges
                                                        if (isSelected) {
                                                          selectedChallenges.remove(personalGrowth[index]);
                                                        } else {
                                                          selectedChallenges.add(personalGrowth[index]);
                                                        }
                                                        print('Selected Challenges: $selectedChallenges');
                                                      },
                                                    );
                                                  });
                                                },
                                              ),
                                            ],
                                          ),

                                          // Display selected challenges
                                          if (selectedChallenges.isNotEmpty) ...[
                                            Padding(
                                              padding: const EdgeInsets.only(top: 16.0),
                                              child: Text(
                                                'Selected Challenges: ${selectedChallenges.join(', ')}',
                                                style: TextStyle(
                                                  color: dark ? AppColor.white : AppColor.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ).whenComplete(() {
    // This will be called when the bottom sheet is closed
    print('Selected Challenges on Close: $selectedChallenges');
    });
    },

                        icon: const Icon(Icons.arrow_downward),
                      ),
                    ],
                  ),

                ),
                const SizedBox(
                  height: AppSizes.spaceBtwInputFields,
                ),
                Container(
                  height: 128,
                  decoration: BoxDecoration(
                    color:
                        dark ? AppColor.grey.withOpacity(0.3) : AppColor.white,
                    borderRadius: BorderRadius.circular(8.0),
                    // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        // Shadow color
                        spreadRadius: 1,
                        // Spread radius (how much the shadow grows)
                        blurRadius: 3,
                        // Blur radius (how soft or sharp the shadow is)
                        offset: const Offset(
                            0, 2), // Offset in x and y (horizontal, vertical)
                      ),
                    ],
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        // Ensures no border when focused
                        enabledBorder: InputBorder.none,
                        // Ensures no border when enabled
                        contentPadding: EdgeInsets.all(16.0),
                        // Adds padding inside the TextField
                        hintText: 'Write description (Optional)',
                        hintStyle: TextStyle(color: Colors.grey)),
                    maxLines: null, // Allows the TextField to expand vertically
                  ),
                ),
                const SizedBox(
                  height: AppSizes.spaceBtwInputFields,
                ),
            Container(
              decoration: BoxDecoration(
                color: dark ? AppColor.grey.withOpacity(0.3) : AppColor.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select Durations',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return DraggableScrollableSheet(
                            expand: false,
                            builder: (context, scrollController) {
                              return SingleChildScrollView(
                                controller: scrollController,
                                child: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      ExpansionTile(
                                        title: const Text('Durations'),
                                        leading: const Icon(Icons.star),
                                        children: [
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: durations.length,
                                            itemBuilder: (context, index) {
                                              return Obx(() {
                                                bool isSelected = controller.selectedDurations.contains(index);
                                                return ListTile(
                                                  title: Text(durations[index]),
                                                  tileColor: isSelected ? Colors.orange : controller.getDurationsColor(index),
                                                  onTap: () {
                                                    controller.updateDurationsIndex(index, durations);
                                                    print('Selected duration: ${durations[index]}');
                                                    duration = durations[index];
                                                    print(duration);
                                                  },
                                                );
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.arrow_downward),
                  ),
                ],
              ),
            ),

                const SizedBox(
                  height: AppSizes.spaceBtwInputFields + 16,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: SimpleTextWidget(
                      align: TextAlign.start,
                      text: 'Select Date & Time',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: dark ? AppColor.white : AppColor.black,
                      fontFamily: 'Poppins'),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                    color:
                        dark ? AppColor.grey.withOpacity(0.3) : AppColor.white,
                    borderRadius: BorderRadius.circular(8.0),
                    // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        // Shadow color
                        spreadRadius: 1,
                        // Spread radius (how much the shadow grows)
                        blurRadius: 3,
                        // Blur radius (how soft or sharp the shadow is)
                        offset: const Offset(
                            0, 2), // Offset in x and y (horizontal, vertical)
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Observe the selected date range using GetX's Obx
                      Obx(() {
                        return Text(
                          controller.getFormattedDateRange(),

                          style:
                              const TextStyle(fontSize: 14.0), // Text styling
                        );
                      }),
                      IconButton(
                        onPressed: () {
                          controller.pickDateRange(context);
                        },
                        icon: const Icon(
                          Icons.date_range,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppSizes.spaceBtwInputFields,
                ),
                Container(
                  decoration: BoxDecoration(
                    color:
                        dark ? AppColor.grey.withOpacity(0.3) : AppColor.white,
                    borderRadius: BorderRadius.circular(8.0),
                    // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        // Shadow color
                        spreadRadius: 1,
                        // Spread radius (how much the shadow grows)
                        blurRadius: 3,
                        // Blur radius (how soft or sharp the shadow is)
                        offset: const Offset(
                            0, 2), // Offset in x and y (horizontal, vertical)
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Observe the selected time using GetX's Obx
                      Obx(() {
                        return Text(
                          controller.getFormattedTime(),

                          style:
                              const TextStyle(fontSize: 14.0), // Text styling
                        );
                      }),
                      IconButton(
                        onPressed: () {
                          controller.pickTime(context);

                        },
                        icon: const Icon(
                          Icons.access_time,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwInputFields),
                NotifyWidgets(dark: dark),
                const SizedBox(height: AppSizes.spaceBtwInputFields),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SimpleTextWidget(
                        text: 'Visibility',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: dark ? AppColor.white : AppColor.black,
                        fontFamily: 'Poppins'),
                    const SizedBox(height: AppSizes.spaceBtwInputFields - 6),
                  ],
                ),

                Container(
                  decoration: BoxDecoration(
                    color: dark ? AppColor.grey.withOpacity(0.3) : AppColor.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Who can see the challenge',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return DraggableScrollableSheet(
                                expand: false,
                                builder: (context, scrollController) {
                                  return SingleChildScrollView(
                                    controller: scrollController,
                                    child: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          ExpansionTile(
                                            title: const Text('Who can'),
                                            leading: const Icon(Icons.star),
                                            children: [
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount: durations.length,
                                                itemBuilder: (context, index) {
                                                  return Obx(() {
                                                    bool isSelected = controller.selectedSeeListIndices.contains(index);
                                                    return ListTile(
                                                      title: Text(seeList[index]),
                                                      tileColor: isSelected ? Colors.orange : controller.getSeeListColor(index),
                                                      onTap: () {
                                                        controller.updateSeeListIndex(index, durations);
                                                        print('Selected : ${seeList[index]}');
                                                        seeListw = seeList[index];
                                                        print(duration);
                                                      },
                                                    );
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.arrow_downward),
                      ),
                    ],
                  ),
                ),





                const SizedBox(height: AppSizes.spaceBtwInputFields + 20),
                SizedBox(
                  width: double.infinity,
                  child: ButtonWidget(
                    dark: dark,
                    onPressed: () async {
                      String time = controller.getFormattedTime();
                      String userID = FirebaseAuth.instance.currentUser!.uid;
                      String dateRange = controller.getFormattedDateRange();

                      // Check if any required information is missing
                      if (selectedChallenges.isEmpty || duration.isEmpty ||
                          time == 'Select Time' || time.isEmpty ||
                          dateRange == 'Select Date' || dateRange.isEmpty) {
                        ShowSnackbar.showMessage(
                          title: "Error",
                          message: 'Please fill all the details',
                          backgroundColor: AppColor.orangeLight,
                        );
                      } else {
                        // Create challenge data
                        Map<String, dynamic> challengeData = {
                          'userId': userID,
                          'selectedChallenges': selectedChallenges,
                          'duration': duration,
                          'time': time,
                          'dateRange': dateRange,
                          'seeListw': seeListw, // Assuming seeListw is a list of users who can see the challenge
                          'createdAt': DateTime.now().toIso8601String(),
                        };

                        try {
                          // Push the challenge data to Firebase Realtime Database
                          await FirebaseDatabase.instance
                              .ref()
                              .child('challenges')
                              .push()
                              .set(challengeData);

                          // Show success message
                          ShowSnackbar.showMessage(
                            title: "Success",
                            message: 'Challenge created successfully!',
                            backgroundColor: Colors.green, // Use an appropriate color for success
                          );

                          Get.to(Dashboard());

                          // Optionally, navigate or clear the form after saving
                          // Navigator.pop(context); // Navigate back if needed

                        } catch (error) {
                          // Handle error (optional)
                          ShowSnackbar.showMessage(
                            title: "Error",
                            message: 'Failed to create challenge: $error',
                            backgroundColor: AppColor.orangeLight,
                          );
                        }
                      }
                    },
                    buttonText: 'Save',
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}




