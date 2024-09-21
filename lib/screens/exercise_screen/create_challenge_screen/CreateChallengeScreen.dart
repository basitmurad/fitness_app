import 'package:fitness/common/widgets/ButtonWidget.dart';
import 'package:fitness/screens/exercise_screen/challenge_screen/ChallengeScreen.dart';
import 'package:fitness/screens/exercise_screen/create_challenge_screen/widgets/NotifyWidgets.dart';
import 'package:fitness/screens/exercise_screen_controller/CreateChallengeScreenController.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/AppColor.dart';
import '../../../utils/constants/AppString.dart';
import '../../../utils/helpers/MyAppHelper.dart';
import '../exercise_detail_screen/widgets/SimpleTextWidget.dart';

class CreateChallengeScreen extends StatelessWidget {
  const CreateChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = ['07 Days', '15 Days', '30 Days'];
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



    final fitness, wellness , personal;

    final bool dark = MyAppHelperFunctions.isDarkMode(context);
    CreateChallengeScreenController controller =
        Get.put(CreateChallengeScreenController());

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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SimpleTextWidget(
                          text: 'Select challenges',
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: dark ? AppColor.white : AppColor.black,
                          fontFamily: 'Poppins'),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            // Allows modal to take up full screen height
                            builder: (BuildContext context) {
                              return DraggableScrollableSheet(
                                expand: false,
                                // Allows scrolling to expand modal
                                builder: (context, scrollController) {
                                  return SingleChildScrollView(
                                    controller: scrollController,
                                    // For scroll control
                                    child: Container(
                                      color: dark
                                          ? AppColor.grey.withOpacity(0.1)
                                          : AppColor.grey.withOpacity(0.2),
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          ExpansionTile(
                                            title: const Text(
                                                'Fitness Challenges'),
                                            leading: const Icon(Icons.star),
                                            children: [
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount:
                                                    fitnessChallenges.length,
                                                itemBuilder: (context, index) {
                                                  return Obx(() => ListTile(
                                                        title: Text(
                                                            '${fitnessChallenges[index]}'),
                                                        subtitle: controller
                                                                .isFitnessSubtitleVisible(
                                                                    index)
                                                            ? Text(
                                                                'Selected: ${fitnessChallenges[index]}')
                                                            : null,
                                                        tileColor: controller
                                                            .getFitnessTileColor(
                                                                index),
                                                        // Change tile color based on selection
                                                        onTap: () {
                                                          controller
                                                              .updateSelectedFitnessIndex(
                                                                  index,
                                                                  fitnessChallenges); // Update selected fitness challenge
                                                        },
                                                      ));
                                                },
                                              ),
                                            ],
                                          ),
                                          ExpansionTile(
                                            title: const Text(
                                                'Wellness Challenges'),
                                            leading: const Icon(Icons.star),
                                            children: [
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount:
                                                    wellnessChallenge.length,
                                                itemBuilder: (context, index) {
                                                  return Obx(() => ListTile(
                                                        title: Text(
                                                            '${wellnessChallenge[index]}'),
                                                        subtitle: controller
                                                                .isWellnessSubtitleVisible(
                                                                    index)
                                                            ? Text(
                                                                '${wellnessChallenge[index]}')
                                                            : null,
                                                        tileColor: controller
                                                            .getWellnessTileColor(
                                                                index),
                                                        // Change tile color based on selection
                                                        onTap: () {
                                                          controller
                                                              .updateSelectedWellnessIndex(
                                                                  index,
                                                                  wellnessChallenge); // Update selected wellness challenge
                                                        },
                                                      ));
                                                },
                                              ),
                                            ],
                                          ),
                                          ExpansionTile(
                                            title:
                                                const Text('Personal Growth'),
                                            leading: const Icon(Icons.star),
                                            children: [
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount:
                                                    personalGrowth.length,
                                                itemBuilder: (context, index) {
                                                  return Obx(() => ListTile(
                                                        title: Text(
                                                            '${personalGrowth[index]}'),
                                                        subtitle: controller
                                                                .isPersonalGrowthSubtitleVisible(
                                                                    index)
                                                            ? Text(
                                                                'Selected: ${personalGrowth[index]}')
                                                            : null,
                                                        tileColor: controller
                                                            .getPersonalGrowthTileColor(
                                                                index),
                                                        // Change tile color based on selection
                                                        onTap: () {
                                                          controller
                                                              .updateSelectedPersonalGrowthIndex(
                                                                  index,
                                                                  personalGrowth); // Update selected personal growth challenge
                                                        },
                                                      ));
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
                    color:
                    dark ? AppColor.grey.withOpacity(0.3) : AppColor.white,                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
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
                      const Text(
                        'Select Durations',
                        style: TextStyle(fontSize: 14.0), // Text styling
                      ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            // Allows modal to take up full screen height
                            builder: (BuildContext context) {
                              return DraggableScrollableSheet(
                                expand: false,
                                // Allows scrolling to expand modal
                                builder: (context, scrollController) {
                                  return SingleChildScrollView(
                                    controller: scrollController,
                                    // For scroll control
                                    child: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          ExpansionTile(
                                            title:
                                                const Text('Select Durations'),
                                            leading: const Icon(Icons.star),
                                            children: [
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: items.length,
                                                itemBuilder: (context, index) {
                                                  return Obx(() => ListTile(
                                                        title: Text(
                                                            '${items[index]}'),

                                                        tileColor: controller
                                                            .getFitnessTileColor(
                                                                index),
                                                        // Change tile color based on selection
                                                        onTap: () {
                                                          controller
                                                              .updateSelectedDurationIndex(
                                                                  index,
                                                                  items); // Update selected fitness challenge
                                                        },
                                                      ));
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
                    dark ? AppColor.grey.withOpacity(0.3) : AppColor.white,                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
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
                    dark ? AppColor.grey.withOpacity(0.3) : AppColor.white,                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
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
                    Container(
                      decoration: BoxDecoration(
                        color:
                        dark ? AppColor.grey.withOpacity(0.3) : AppColor.white,                        // Background color of the container
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
                            offset: const Offset(0,
                                2), // Offset in x and y (horizontal, vertical)
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Select Durations',
                            style: TextStyle(fontSize: 14.0), // Text styling
                          ),
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                // Allows modal to take up full screen height
                                builder: (BuildContext context) {
                                  return DraggableScrollableSheet(
                                    expand: false,
                                    // Allows scrolling to expand modal
                                    builder: (context, scrollController) {
                                      return SingleChildScrollView(
                                        controller: scrollController,
                                        // For scroll control
                                        child: Container(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            children: [
                                              ExpansionTile(
                                                title: const Text(
                                                    'Who can see the Challenge ?'),
                                                leading: const Icon(Icons.star),
                                                children: [
                                                  ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount: seeList.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Obx(() => ListTile(
                                                            title: Text(
                                                                '${seeList[index]}'),

                                                            tileColor: controller
                                                                .getSeeTileColor(
                                                                    index),
                                                            // Change tile color based on selection
                                                            onTap: () {
                                                              controller
                                                                  .updateSeeListIndex(
                                                                      index,
                                                                      seeList); // Update selected fitness challenge
                                                            },
                                                          ));
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
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwInputFields + 20),
                SizedBox(
                    width: double.infinity,
                    child: ButtonWidget(
                        dark: dark, onPressed: () {}, buttonText: 'Save'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
