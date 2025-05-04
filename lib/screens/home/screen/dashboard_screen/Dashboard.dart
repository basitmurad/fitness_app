
import 'dart:io';
import 'package:fitness/screens/home/controller/DashboardController.dart';
import 'package:fitness/screens/home/screen/dashboard_screen/widgets/ChallengedWidget.dart';
import 'package:fitness/screens/home/screen/dashboard_screen/widgets/ExerciseWidget.dart';
import 'package:fitness/screens/home/screen/dashboard_screen/widgets/FollowUserCard.dart';
import 'package:fitness/screens/home/screen/dashboard_screen/widgets/ProgressContainer.dart';
import 'package:fitness/screens/home/screen/dashboard_screen/widgets/TextWidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/CircularImage.dart';
import '../../../../common/widgets/MyAppGridLayout.dart';
import '../../../../utils/constants/AppColor.dart';
import '../../../../utils/constants/AppImagePaths.dart';
import '../../../../utils/constants/AppSizes.dart';
import '../../../../utils/constants/AppString.dart';
import '../../../../utils/helpers/MyAppHelper.dart';
import '../../../exercise_screen/screen/abs_screen/AbsScreen.dart';
import '../../../exercise_screen/screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';
import '../chats_screen/chat_user_screen/ChatsUserScreen.dart';
import '../social/post_screen/AddPostScreen.dart';
import '../tracking_screen/TrackingScreen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with WidgetsBindingObserver {
  // Use existing controller or create a new one
  DashboardController dashboardController = Get.put(DashboardController());
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);

    return WillPopScope(
      onWillPop: () async {
        if (Platform.isAndroid) {
          SystemNavigator.pop(); // Closes the app on Android
        } else if (Platform.isIOS) {
          exit(0); // Closes the app on iOS
        }
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Obx(() => CircularImage(
                imageUrl: dashboardController.imageUrl.value.isEmpty
                    ? AppImagePaths.placeholder1
                    : dashboardController.imageUrl.value,
                size: 50,
              )),
              const SizedBox(width: 6),
              Obx(() => SimpleTextWidget(
                text: dashboardController.name.value.isEmpty
                    ? 'Loading...'
                    : dashboardController.name.value,
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: dark ? Colors.white : AppColor.black,
                fontFamily: 'Poppins',
              )),
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(() => const ChatsUserScreen());
                if (kDebugMode) {
                  print('message');
                }
              },
              child: Image(
                width: 20,
                height: 20,
                color: dark ? AppColor.white : AppColor.black,
                image: const AssetImage(AppImagePaths.messages),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {},
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
            padding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress Container
                Container(
                  width: MyAppHelperFunctions.screenWidth() * 0.95,
                  height: 130,
                  decoration: BoxDecoration(
                    color: dark
                        ? AppColor.grey.withOpacity(0.1)
                        : AppColor.grey.withOpacity(0.3),
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SimpleTextWidget(
                          text: 'Your progress',
                          fontWeight: FontWeight.w300,
                          fontSize: 13,
                          color: dark ? AppColor.white : AppColor.black,
                          fontFamily: 'Poppins',
                          align: TextAlign.start,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Use Obx for reactive UI updates
                            Obx(() => ProgressContainer(
                              iconPath: AppImagePaths.kcalicon,
                              label: '${dashboardController.calculateCalories(dashboardController.stepCount.value)}',
                              value: 'Kcal',
                            )),
                            Obx(() => ProgressContainer(
                              iconPath: AppImagePaths.clock,
                              label: dashboardController.formatElapsedTime(dashboardController.elapsedTime.value),
                              value: 'Time',
                            )),
                            Obx(() => ProgressContainer(
                              iconPath: AppImagePaths.location,
                              label: '${dashboardController.stepCount.value}',
                              value: 'Steps',
                            )),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => TrackingScreen(
                                dayName: dashboardController.getCurrentDayName(),
                              ));
                            },
                            child: SimpleTextWidget(
                                align: TextAlign.end,
                                text: 'See More',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: dark ? AppColor.white : AppColor.black,
                                fontFamily: 'Poppins'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                // Start/Stop Run Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Obx(() => TextButton(
                        onPressed: dashboardController.isTracking.value
                            ? null
                            : () {
                          MyAppHelperFunctions.showSnackBar(
                              'Tracking has been started');
                          dashboardController.startListening();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: AppColor.orangeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          minimumSize: const Size(double.infinity, 30),
                        ),
                        child: SimpleTextWidget(
                          text: 'Record a Run',
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          color: dark ? AppColor.black : AppColor.white,
                          fontFamily: 'Poppins',
                        ),
                      )),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Obx(() => TextButton(
                        onPressed: dashboardController.isTracking.value
                            ? () {
                          MyAppHelperFunctions.showSnackBar(
                              'Tracking has been Stopped');
                          dashboardController.stopListening();
                        }
                            : null,
                        style: TextButton.styleFrom(
                          backgroundColor: AppColor.error,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          minimumSize: const Size(double.infinity, 30),
                        ),
                        child: SimpleTextWidget(
                          text: 'Stop Run',
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          color: dark ? AppColor.black : AppColor.white,
                          fontFamily: 'Poppins',
                        ),
                      )),
                    ),
                  ],
                ),

                SizedBox(height: AppSizes.inputFieldRadius),
                // Challenge Widget
                ChallengedWidget(dark: dark),

                const SizedBox(height: AppSizes.inputFieldRadius - 5),
                // Fitness Titans section
                Text(
                  AppStrings.fitnessTitans,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: dark ? AppColor.white : AppColor.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400),
                ),

                const SizedBox(height: AppSizes.inputFieldRadius),
                // User grid for following
                Obx(() => MyAppGridLayout(
                  itemCount: dashboardController.filteredUsersList.length,
                  itemBuilder: (context, index) {
                    final user = dashboardController.filteredUsersList[index];
                    return Card(
                      child: FollowUserCard(
                        dark: dark,
                        userName: user['name'] ?? 'Unknown User',
                        imagePath: user['imageUrl'] ?? '',
                        onRemovePressed: () => dashboardController.onRemoveUser(user['id']),
                        onFollowPressed: () => dashboardController.onFollowUser(
                            user['id'], user['name'], user['imageUrl']),
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                )),

                const SizedBox(height: AppSizes.spaceBtwInputFields),
                TextWidget(dark: dark),

                // Exercise list based on gender
                FutureBuilder<String>(
                  future: dashboardController.fetchUserGender(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      String gender = snapshot.data!;
                      List<Map<String, String>> exercisesList =
                      gender == 'Female' ? AppStrings.femaleExercises : AppStrings.maleExercise;

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: exercisesList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.zero,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => AbsScreen(
                                  exerciseType: exercisesList[index]
                                  ['exerciseName']!,
                                  exerciseRepititon: exercisesList[index]
                                  ['exerciseRepetition']!,
                                  gender: gender,
                                ));
                              },
                              child: ExerciseWidget(
                                dark: dark,
                                imagePath: exercisesList[index]['imagePath']!,
                                exerciseName: exercisesList[index]
                                ['exerciseName']!,
                                exerciseRepeation: exercisesList[index]
                                ['exerciseRepetition']!,
                              ),
                            ),
                          );
                        },
                      );
                    } else {
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
            Get.to(() => const AddPostScreen());
          },
          backgroundColor: AppColor.orangeColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 45),
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Forward app lifecycle state changes to the controller
    dashboardController.handleAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    searchController.dispose();
    super.dispose();
  }
}