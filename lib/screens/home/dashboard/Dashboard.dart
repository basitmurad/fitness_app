import 'package:fitness/common/widgets/ButtonWidget.dart';
import 'package:fitness/common/widgets/MyAppGridLayout.dart';
import 'package:fitness/screens/home/dashboard/widgets/ChallengedWidget.dart';
import 'package:fitness/screens/home/dashboard/widgets/ExerciseWidget.dart';
import 'package:fitness/screens/home/dashboard/widgets/TextTitleWidget.dart';
import 'package:fitness/screens/home/exercise_detail_screen/ExerciseDetailScreen.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppImagePaths.dart';
import 'package:fitness/utils/constants/AppString.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../common/widgets/CustomButton.dart';
import '../../../utils/constants/AppDevicesUtils.dart';
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

List<Map<String, String>> exercises = [
  {
    'imagePath': AppImagePaths.femaleArm,
    'exerciseName': 'Arm w',
    'exerciseRepetition': '09 www 19 reps',
  },
  {
    'imagePath': AppImagePaths.femaleAbs,
    'exerciseName': 'Abs w',
    'exerciseRepetition': '12 min ww reps',
  },
];

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController dashboardController = Get.put(DashboardController());
    final bool dark = MyAppHelperFunctions.isDarkMode(context);

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
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   width: double.infinity,
              //   height: AppDevicesUtils.getScreenHeight() * 0.22,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20),
              //     color: dark ? AppColor.white : AppColor.dark3,
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black.withOpacity(0.2),
              //         blurRadius: 8,
              //         offset: const Offset(0, 4),
              //       ),
              //     ],
              //   ),
              //   child: Stack(
              //     children: [
              //       Positioned(
              //         right: 0,
              //         top: 0,
              //         bottom: 0,
              //         width: 0.3 * MediaQuery.of(context).size.width,
              //         child: const ClipRRect(
              //           borderRadius: BorderRadius.only(
              //             topRight: Radius.circular(20),
              //             bottomRight: Radius.circular(20),
              //           ),
              //           child: Image(
              //             fit: BoxFit.cover,
              //             image: AssetImage(AppImagePaths.gymPic),
              //           ),
              //         ),
              //       ),
              //       Positioned(
              //         left: 0,
              //         top: 0,
              //         bottom: 0,
              //         right: 105,
              //         // Allow the text container to span the remaining width
              //         child: Container(
              //           width: AppDevicesUtils.getScreenWidth(context) * 0.7,
              //           margin: const EdgeInsets.symmetric(
              //               vertical: 10, horizontal: 10),
              //           alignment: Alignment.center,
              //           child: Text(
              //             fitnessSliderTexts[5],
              //             textAlign: TextAlign.start,
              //             style: Theme.of(context)
              //                 .textTheme
              //                 .displayLarge!
              //                 .copyWith(
              //                   color: dark ? AppColor.black : AppColor.white,
              //                   fontSize: 15,
              //                 ),
              //           ),
              //         ),
              //       ),
              //       Positioned(
              //           bottom: 10,
              //           child: Container(
              //             height: 20,
              //             alignment: Alignment.center,
              //             width: AppDevicesUtils.getScreenWidth(context) * 0.6,
              //             child: SmoothPageIndicator(
              //               controller: dashboardController.pageController,
              //               count: 9,
              //               effect: WormEffect(
              //                 activeDotColor:
              //                     dark ? AppColor.lightBlue : AppColor.white,
              //                 dotColor: dark ? Colors.black : AppColor.white,
              //                 dotHeight: 10,
              //                 dotWidth: 10,
              //                 spacing: 8,
              //               ),
              //             ),
              //           ))
              //     ],
              //   ),
              // ),
              const SizedBox(
                height: AppSizes.inputFieldRadius,
              ),
              ChallengedWidget(dark: dark),
              const SizedBox(
                height: AppSizes.inputFieldRadius -5,
              ),

              Text(AppStrings.fitnessTitans ,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: dark ? AppColor.white :AppColor.black ,fontFamily: 'Poppins' ,fontWeight: FontWeight.w400),),
              const SizedBox(
                height: AppSizes.inputFieldRadius,
              ),



              MyAppGridLayout(itemCount: 5, itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        child: Image(
                          height: 70,
                          width: 140,
                          fit: BoxFit.cover, // Ensure the image covers the container
                          image: AssetImage(AppImagePaths.image11),
                        ),
                      ),

                      SizedBox(height: 3,),
                      Text('Sofia Ansari' ,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: dark ?AppColor.white :AppColor.black  ,fontFamily: 'Poppins', fontWeight: FontWeight.w400), textAlign: TextAlign.start,)

                    ,  SizedBox(height: 5,),



                      Row(
                        children: [
                          Expanded(
                            child:
                            SizedBox(
                              height: 50, // Set the height of the buttons
                              child: ElevatedButton(
                                onPressed: () {
                                  // Your onPressed function here
                                },
                                child: Text("Button 1"),
                              ),
                            ),
                          ),
                          SizedBox(width: 4), // Optional spacing between buttons
                          Expanded(
                            child:
                            CustomButton(height1: 30.0, buttontext: 'Start',)                          ),
                        ],
                      ),

                    ],
                  ),
                );
              }),


              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: exercises.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.zero,
                    child: GestureDetector(
                        onTap: () {
                          Get.to(const ExerciseDetailScreen());
                        },
                        child: ExerciseWidget(
                          dark: dark,
                          imagePath: exercises[index]['imagePath']!,
                          exerciseName: exercises[index]['exerciseName']!,
                          exerciseRepeation: exercises[index]
                              ['exerciseRepetition']!,
                        )),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}



