import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/widgets/MyAppGridLayout.dart';
import '../../../utils/constants/AppColor.dart';
import '../../../utils/constants/AppImagePaths.dart';
import '../../../utils/constants/AppSizes.dart';
import '../../../utils/helpers/MyAppHelper.dart';
import '../../exercise_screen_controller/ExerciseDetailScreenController.dart';
import '../exercise_detail_screen/ExerciseDetailScreen.dart';
import '../exercise_detail_screen/widgets/BottomWidget.dart';
import '../exercise_detail_screen/widgets/CustomIconButton.dart';
import '../exercise_detail_screen/widgets/InstructionWidget.dart';
import '../exercise_detail_screen/widgets/Item.dart';
import '../exercise_detail_screen/widgets/MistakesListWidget.dart';
import '../exercise_detail_screen/widgets/SimpleTextWidget.dart';

class AllDetail extends StatefulWidget {
    const AllDetail({super.key, required this.exerciseName, required this.exerciseType});


  final String exerciseName;
  final String exerciseType;

  @override
  State<AllDetail> createState() => _AllDetailState();
}

class _AllDetailState extends State<AllDetail> {
  String? title="";
  List<Map<String, String>> breathingTips = [];
  List<Map<String, String>> commonMistakes = [];
  List<String> focusArea=[];
  @override
  void initState() {
    super.initState();
    fetchExerciseData(); // Fetch data once when the widget is initialized
  }
  Future<void> fetchExerciseData() async {
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref('Exercise').child(widget.exerciseType);

    try {
      final DatabaseEvent event = await databaseReference.child(widget.exerciseName).once();
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        printExerciseData(data);
      } else {
        print("No data found.");
      }
    } catch (error) {
      print("Error fetching data: $error");
    }
  }



  void printExerciseData(Map<dynamic, dynamic> data) {
    print('==============print data in format===============');


    print("\nInstruction:");
    print(" instrucion are  ${data['instruction']}\n");

    setState(() {
      // Set the instruction title
      title = "${data['instruction']}\n";

      for (var mistake in data["commonMistakes"]) {
        commonMistakes.add({
          "title": mistake['title'],
          "description": mistake['description'],
        });
      }
      for (var tips in data["breathingTips"]) {
        breathingTips.add({
          "title": tips['title'],
          "description": tips['description'],
        });

      }

      for (var area in data["focusAreas"]) {
        focusArea.add(area);
      }



    });


  }

  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);

    final ExerciseDetailScreenController controller =
    Get.put(ExerciseDetailScreenController());
    return Scaffold(


      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: AppSizes.appBarHeight,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        textAlign: TextAlign.start,
                        widget.exerciseName,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: dark ? AppColor.white : AppColor.black,
                          fontFamily: 'Poppins-Bold',
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 8.0,
                  ),
                  // Container to specify height and width of PageView
                  SizedBox(
                    width: double.infinity, // Full width
                    height: 200.0, // Set your desired height
                    child: Column(
                      children: [
                        // PageView widget
                        Expanded(
                          child: PageView(
                            controller: controller.pageController,
                            onPageChanged: controller.onPageChanged,
                            children:  [
                              InstructionWidget(
                                imageUrl: '',
                                // imageUrl:  getCategoryX['imagePaths'],
                              ),
                              InstructionWidget(
                                imageUrl: AppImagePaths.femaleAbs,
                              ),
                              InstructionWidget(
                                imageUrl: AppImagePaths.abs,
                              )
                            ],
                          ),
                        ),

                        // Row of control items
                      ],
                    ),
                  ),

                  Obx(() {
                    return Container(
                      height: 40,
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 2, bottom: 2),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(24)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildControlItem('Animation', 0),
                          _buildControlItem('Muscle', 1),
                          _buildControlItem('Video', 2),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(
                    height: AppSizes.spaceBtwItems,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SimpleTextWidget(
                        text: 'Durations',
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,
                        color: AppColor.orangeColor,
                        fontFamily: 'Poppins-bold',
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomIconButton(
                            iconData: Icons.remove,
                            dark: dark,
                            onPressed: () => controller.decrementTime(),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColor.orangeColor, // Border color
                                width: 1.0, // Border width
                              ),
                              borderRadius: BorderRadius.circular(16), // Rounded corners
                            ),
                            child: Center(
                              child: Obx(
                                    () => Text(
                                  controller.formattedTime,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: dark ? AppColor.white : AppColor.black),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          CustomIconButton(
                            iconData: Icons.add,
                            dark: dark,
                            onPressed: () => controller.incrementTime(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSizes.spaceBtwItems,
                  ),
                  const SimpleTextWidget(
                    text: 'Instructions',
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                    color: AppColor.orangeColor,
                    fontFamily: 'Poppins',
                  ),

                  const SizedBox(
                    height: AppSizes.inputFieldRadius,
                  ),


                  Text(title!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: dark
                              ? AppColor.white.withOpacity(0.9)
                              : AppColor.black)),
                  const SizedBox(
                    height: AppSizes.inputFieldRadius,
                  ),
                  const SimpleTextWidget(
                    text: 'Focus Areas',
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                    color: AppColor.orangeColor,
                    fontFamily: 'Poppins',
                  ),

                  const SizedBox(
                    height: AppSizes.inputFieldRadius,
                  ),


              Wrap(
                spacing: 8.0, // Space between items horizontally
                runSpacing: 4.0, // Space between lines vertically
                children: focusArea.map((area) {
                  return Container(
                    constraints: BoxConstraints(maxWidth: 120), // Set a max width
                    child: Chip(
                      label: Text(
                        area,
                        overflow: TextOverflow.ellipsis, // Handle overflow
                        maxLines: 1, // Limit to one line
                      ),
                      backgroundColor: Colors.blueAccent,
                    ),
                  );
                }).toList(),
              ),


              const SizedBox(
                    height: AppSizes.inputFieldRadius,
                  ),

                  const Image(image: AssetImage('')),

                  const SimpleTextWidget(
                      text: 'Common Mistakes',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColor.orangeColor,
                      fontFamily: 'Poppins'),
                  const SizedBox(
                    height: AppSizes.spaceBtwItems,
                  ),

                  MistakesListWidget(commonMistakes: breathingTips, dark: dark),

                  const SizedBox(
                    height: AppSizes.spaceBtwItems,
                  ),
                  const SimpleTextWidget(
                      text: 'Breathing Tips',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColor.orangeColor,
                      fontFamily: 'Poppins'),
                  const SizedBox(
                    height: AppSizes.spaceBtwItems,
                  ),

                  MistakesListWidget(
                    commonMistakes:  commonMistakes, // Use empty list if null
                    dark: dark,
                  ),

                ],
              ),
            ),

            ElevatedButton(
              onPressed: () {

                fetchExerciseData();
              },
              child: Text('Fetch Exercise Data'),
            ),
            BottomWidget(dark: dark,),
          ],
        ),
      ),
    );
  }

  // Build control items
  Widget _buildControlItem(String label, int pageIndex) {
    final ExerciseDetailScreenController controller =
    Get.put(ExerciseDetailScreenController());
    return GestureDetector(
      onTap: () => controller.goToPage(pageIndex),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: controller.currentPage.value == pageIndex
              ? AppColor.orangeColor
              : Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: controller.currentPage.value == pageIndex
                ? Colors.white
                : Colors.black,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
