import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../utils/constants/AppColor.dart';
import '../../../utils/constants/AppImagePaths.dart';
import '../../../utils/constants/AppSizes.dart';
import '../../../utils/helpers/MyAppHelper.dart';
import '../../exercise_screen_controller/ExerciseDetailScreenController.dart';
import '../exercise_detail_screen/widgets/BottomWidget.dart';
import '../exercise_detail_screen/widgets/CustomIconButton.dart';
import '../exercise_detail_screen/widgets/InstructionWidget.dart';
import '../exercise_detail_screen/widgets/MistakesListWidget.dart';
import '../exercise_detail_screen/widgets/SimpleTextWidget.dart';

class AllDetail extends StatefulWidget {
    const AllDetail({super.key, required this.exerciseName, required this.exerciseType, required this.gender, });


  final String exerciseName;
  final String exerciseType;
  final String gender;

  @override
  State<AllDetail> createState() => _AllDetailState();
}

class _AllDetailState extends State<AllDetail> {

  String? title="";
  String? durarions="";
  String durationInSeconds = "";
  // Will store the duration as an integer for easier manipulation

  List<Map<String, String>> breathingTips = [];
  List<Map<String, String>> commonMistakes = [];
  List<String> focusArea=[];
  String? videoUrl;
  String? darkImagePath1="";
  String? lightImagePath1="";
  String? muscleImage="";
  YoutubePlayerController? _youtubePlayerController;

  @override
  void initState() {
    super.initState();
    fetchExerciseData();

    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoUrl ?? 'https://www.youtube.com/watch?v=dQw4w9WgXcQ')!, // Replace with the actual video URL
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );


  }
  Future<void> fetchExerciseData( ) async {
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref('Exercise').child(widget.exerciseType);

    try {
      final DatabaseEvent event = await databaseReference.child(widget.exerciseName).once();
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        printExerciseData(data , widget.gender);
        print("Data Exist.");


      } else {
        print("No data exist.");
      }
    } catch (error) {
      print("Error fetching data: $error");
    }
  }



  void printExerciseData(Map<dynamic, dynamic> data, String gender) {
    print('============== Print Data in Format ===============');
    print('Exercise name is ${widget.exerciseType} and ${widget.exerciseName}');



    // Print multimedia data

    setState(() {
      // Set the instruction title
      title = "${data['instruction']}\n";
      durarions = "${data['durarions']}\n";

      print('Duration is $durarions');


      // Fetch common mistakes
      commonMistakes.clear();
      for (var mistake in data["commonMistakes"]) {
        commonMistakes.add({
          "title": mistake['title'],
          "description": mistake['description'],
        });
      }

      // Fetch breathing tips
      breathingTips.clear();
      for (var tips in data["breathingTips"]) {
        breathingTips.add({
          "title": tips['title'],
          "description": tips['description'],
        });
      }

      // Fetch focus areas
      focusArea.clear();
      for (var area in data["focusAreas"]) {
        focusArea.add(area);
      }
      print("Multimedia:");
      for (var gender in data["multimedia"].keys) {
        if (data["multimedia"].containsKey(gender)) {
          final media = data["multimedia"][gender];
          // Check if gender is a String before calling capitalize
          if (gender is String) {
           print("  ${gender[0].toUpperCase()}${gender.substring(1)}:");  // Capitalizing manually
          }

          muscleImage = "${media['musclePath']}";
          lightImagePath1 = "${media['lightTheme']}";
          darkImagePath1 = "${media['darkTheme']}";



          print(muscleImage);

        }
      }

    });
  }



  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);


    final ExerciseDetailScreenController controller =
    Get.put(ExerciseDetailScreenController());

    durarions = controller.currentDuration.value.toString();
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
                                imageUrl: muscleImage!,
                              ),


                              const InstructionWidget(
                                imageUrl: AppImagePaths.abs,
                              ),
                              const InstructionWidget(
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
                          _buildControlItem('Muscle', 0),
                          _buildControlItem('Animation', 1),
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
                            onPressed: () => controller.decrementTime(widget.exerciseType, widget.exerciseName),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            alignment: Alignment.center,
                            width: 100,
                            height: 25,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColor.orangeColor, // Border color
                                width: 1.0, // Border width
                              ),
                              borderRadius: BorderRadius.circular(16), // Rounded corners
                            ),
                            child: Center(
                              child: Obx(() => Text(
                                'Sec: ${controller.currentDuration.value}', // Display updated duration
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: dark ? AppColor.white : AppColor.black),
                              )),
                            ),
                          ),
                          const SizedBox(width: 8),
                          CustomIconButton(
                            iconData: Icons.add,
                            dark: dark,
                            onPressed: () => controller.incrementTime(widget.exerciseType, widget.exerciseName),
                          ),
                        ],
                      )





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

                        constraints: const BoxConstraints(maxWidth: 120), // Set a max width
                        child: Chip(
                          label: Text(
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                              color: Colors.black
                            ),
                            area,
                            maxLines: 1, // Limit to one line
                          ),
                          backgroundColor:          AppColor.grey,

                          side: BorderSide.none, // Remove border
                        ),
                      );
                    }).toList(),
                  ),




              const SizedBox(
                    height: AppSizes.inputFieldRadius,
                  ),

                  Image.network(
                      dark ? darkImagePath1! : lightImagePath1! ,                    errorBuilder: (context, error, stackTrace) {
                      return const Text('Error loading image'); // Display an error message or a placeholder
                    },
                  )


                  ,const SimpleTextWidget(
                      text: 'Common Mistakes',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColor.orangeColor,
                      fontFamily: 'Poppins'),
                  const SizedBox(
                    height: AppSizes.spaceBtwItems,
                  ),

                  MistakesListWidget(commonMistakes: commonMistakes, dark: dark),

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
                    commonMistakes:  breathingTips, // Use empty list if null
                    dark: dark,
                  ),

                ],
              ),
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
