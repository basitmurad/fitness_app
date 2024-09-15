import 'package:fitness/screens/exercise_screen/controller/ExerciseDetailScreenController.dart';
import 'package:fitness/screens/exercise_screen/exercise_detail_screen/widgets/BottomWidget.dart';
import 'package:fitness/screens/exercise_screen/exercise_detail_screen/widgets/CustomIconButton.dart';
import 'package:fitness/screens/exercise_screen/exercise_detail_screen/widgets/InstructionWidget.dart';
import 'package:fitness/screens/exercise_screen/exercise_detail_screen/widgets/Item.dart';
import 'package:fitness/screens/exercise_screen/exercise_detail_screen/widgets/MistakesListWidget.dart';
import 'package:fitness/screens/exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/AppColor.dart';
import '../../../utils/constants/AppImagePaths.dart';

import '../../../utils/helpers/MyAppHelper.dart';

class ExerciseDetailScreen extends StatelessWidget {
  const ExerciseDetailScreen({super.key, required this.exerciseName});

  final String exerciseName;

  Map<String, dynamic> _getExerciseList() {
    switch (exerciseName) {
      case 'Jumping Jack':
        return getCategoryJson[0];
      case 'Abdominal Crunches':
        return getCategoryJson[1];
      case 'Russian Twist':
        return getCategoryJson[2];
      case 'Heel Touch':
        return getCategoryJson[3];
      case 'Leg Raises':
        return getCategoryJson[4];
      case 'Plank':
        return getCategoryJson[5];
      case 'Cobra Stretch':
        return getCategoryJson[6];
      case 'Heel Touch':
        return getCategoryJson[7];
      case 'Spine Lumber Twist Left':
        return getCategoryJson[8];

      default:
        return {};
    }
  }
  final String gender = 'female';

  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);
    Map<String, dynamic> getCategoryX = _getExerciseList();


    final imageUrl = gender == 'female'
        ? getCategoryX['femaleImage']
        : getCategoryX['imagePaths'];
    // String imageurl = getCategoryX['imagePaths'];
    // print('url is $imageurl');
// Fetch the exercise data

    print('<<<<<<<<<<<<<<<<<<data is >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.');
// Check if the map is not empty and print its values
    if (getCategoryX.isNotEmpty) {
      print('Instruction: ${getCategoryX['instruction']}');
      print('Common Mistakes: ${getCategoryX['commonMistakes']}');
      print('Breathing Tips: ${getCategoryX['breathingTips']}');
      print('Items: ${getCategoryX['items']}');

      print('image ${getCategoryX['imagePaths']}');
    } else {
      print('No data found for the selected exercise.');
    }

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
                        exerciseName,
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
                                imageUrl: imageUrl,
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
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColor.orangeColor, // Border color
                                width: 1.0, // Border width
                              ),
                              borderRadius:
                                  BorderRadius.circular(16), // Rounded corners
                            ),
                            child: Center(
                              child: Text(
                                '00:20',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: dark
                                            ? AppColor.white
                                            : AppColor.black),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          CustomIconButton(iconData: Icons.add, dark: dark)
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
                  //todo back here later
                  // Text( getCategoryJson[1]['instruction'] ?? 'No instructions available',
                  //     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  //         color: dark
                  //             ? AppColor.white.withOpacity(0.9)
                  //             : AppColor.black)),
                  Text('${getCategoryX['instruction']}',
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

                  Row(
                    children: [
                      Flexible(
                          child: Item(
                        dark: dark,
                        text1: jumpingJacksItems[0],
                      )),
                      Flexible(
                          child: Item(
                        dark: dark,
                        text1: jumpingJacksItems[1],
                      )),
                      Flexible(
                          child: Item(
                        dark: dark,
                        text1: jumpingJacksItems[2],
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: AppSizes.inputFieldRadius,
                  ),

                  Row(
                    children: [
                      Flexible(
                          child: Item(
                        dark: dark,
                        text1: jumpingJacksItems[3],
                      )),
                      Flexible(
                          child: Item(
                        dark: dark,
                        text1: jumpingJacksItems[4],
                      )),
                    ],
                  ),

                  const SizedBox(
                    height: AppSizes.inputFieldRadius,
                  ),

                  const Image(image: AssetImage('assets/images/dark.png')),

                  const SimpleTextWidget(
                      text: 'Common Mistakes',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColor.orangeColor,
                      fontFamily: 'Poppins'),
                  const SizedBox(
                    height: AppSizes.spaceBtwItems,
                  ),

                  MistakesListWidget(
                    commonMistakes: List<Map<String, String>>.from(
                        getCategoryX['commonMistakes'] ?? []),
                    dark: dark,
                  ),
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
                    commonMistakes: List<Map<String, String>>.from(
                        getCategoryX['breathingTips'] ?? []),
                    dark: dark,
                  ),
                ],
              ),
            ),
            const BottomWidget(),
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

List<Map<String, dynamic>> getCategoryJson = [

  {
    'commonMistakes': jumpingJacksCommonMistakesList,
    'breathingTips': jumpingJacksBreathingTipsL,
    'items': List<String>.of(jumpingJacksItems),
    'instruction': jumpingJacksInstruction,
    'imagePaths' : jumpingImageMale,
    'femaleImage' : jumpingImageFemale
  },
  {
    'commonMistakes': abdominalCrunchesCommonMistakes,
    'breathingTips': abdominalCrunchesBreathingTips,
    'items': List<String>.of(abdominalCrunchesItems),
    'instruction': abdominalCrunchesInstruction,
    'imagePaths' : abdominalImageMale,
    'femaleImage' : jumpingImageFemale

  },
  {
    'commonMistakes': russianTwistCommonMistakes,
    'breathingTips': russianTwistBreathingTips,
    'items': List<String>.of(russianTwistItems),
    'instruction': russianTwistInstruction,
    'imagePaths' : russianImageMale
  },
  {
    'commonMistakes': heelTouchCommonMistakes,
    'breathingTips': heelTouchBreathingTips,
    'items': List<String>.of(heelTouchItems),
    'instruction': heelTouchInstruction,
    'imagePaths' : heelTouchMale
  },
  {
    'commonMistakes': legRaisesCommonMistakes,
    'breathingTips': legRaisesBreathingTips,
    'items': List<String>.of(legRaisesItems),
    'instruction': legRaisesInstruction,
    'imagePaths' : legImageMale
  },
  {
    'commonMistakes': plankRaisesCommonMistakes,
    'breathingTips': plankRaisesBreathingTips,
    'items': List<String>.of(plankRaisesItems),
    'instruction': plankInstruction,
    'imagePaths' : plankImageMale
  },
  {
    'commonMistakes': cobraStretchCommonMistakes,
    'breathingTips': cobraStretchBreathingTips,
    'items': List<String>.of(cobraStretchItems),
    'instruction': cobraStretchInstruction,
    'imagePaths' : cobraImageMale
  },
  {
    'commonMistakes': spineLumberTwistRightCommonMistakes,
    'breathingTips': spineLumberTwistRightBreathingTips,
    'items': List<String>.of(spineLumberTwistRightItems),
    'instruction': spineLumberTwistRightInstruction,
    'imagePaths' : spineImageMale
  },
  {
    'commonMistakes': spineLumberTwistLeftCommonMistakes,
    'breathingTips': spineLumberTwistLeftBreathingTips,
    'items': List<String>.of(spineLumberTwistLeftItems),
    'instruction': spineLumberTwistLeftInstruction,
    'imagePaths' : spineleftFemale
  },
];



/// Jumping Jacks
List<Map<String, String>> jumpingJacksCommonMistakesList = [
  {
    'title': 'Landing Hard',
    'description':
        'Not landing softly on your toes, which can strain your joints.',
  },
  {
    'title': 'Poor Arm Form',
    'description': 'Not fully extending arms overhead or flailing them.',
  },
  {
    'title': 'Hunched Posture',
    'description': 'Slouching or not keeping your chest up and back straight.',
  },
  {
    'title': 'Uneven Timing',
    'description':
        'Performing the movement too quickly or unevenly, losing rhythm.',
  },
  {
    'title': 'Shallow Jumps',
    'description': 'Not spreading feet wide enough or jumping high enough.',
  },
];
List<Map<String, String>> jumpingJacksBreathingTipsL = [
  {
    'title': 'Inhale as You Prepare',
    'description': 'Breathe in before starting to lift your arms.',
  },
  {
    'title': 'Exhale as You Raise',
    'description':
        'Breathe out slowly as you lift your arms to shoulder height.',
  },
  {
    'title': 'Inhale as You Lower',
    'description': 'Breathe in as you bring your arms back down.',
  },
  {
    'title': 'Maintain a Steady Rhythm',
    'description':
        'Keep your breathing consistent and in sync with your movements.',
  },
  {
    'title': 'Avoid Holding Your Breath',
    'description':
        'Continue to breathe naturally throughout the exercise to maintain control and focus.',
  },
];
List<String> jumpingJacksItems = [
  'Shoulder',
  'Legs',
  'Cardio',
  'Coordination',
  'Core',
];
const String jumpingJacksInstruction =
    "Stand with your feet together and arms by your sides. Jump, spreading your feet apart and raising your arms overhead. Jump again, bringing your feet together and lowering your arms.Repeat, keeping a steady rhythm. Engage your core and land softly.";
const String jumpingImageMale = AppImagePaths.maleAbs;
const String jumpingImageFemale = AppImagePaths.abs;

/// Abdominal Crunches

List<Map<String, String>> abdominalCrunchesCommonMistakes = [
  {
    'title': 'Rushed Movements',
    'description': 'Performing crunches too quickly without proper control.',
  },
  {
    'title': 'Pulling on the Neck',
    'description':
        'Using your hands to pull your head up, which can strain your neck.',
  },
  {
    'title': 'Lifting Too High',
    'description':
        'Raising your back off the floor instead of just your shoulders.',
  },
  {
    'title': 'Arching the Lower Back',
    'description':
        'Allowing your lower back to lift off the floor, reducing effectiveness.',
  },
  {
    'title': 'Holding Breath',
    'description':
        'Not breathing consistently, which can reduce oxygen flow and make the exercise harder.',
  },
];
List<Map<String, String>> abdominalCrunchesBreathingTips = [
  {
    'title': 'Inhale as You Prepare',
    'description': 'Breathe in before starting to lift your arms.',
  },
  {
    'title': 'Exhale as You Raise',
    'description':
        'Breathe out slowly as you lift your arms to shoulder height.',
  },
  {
    'title': 'Inhale as You Lower',
    'description': 'Breathe in as you bring your arms back down.',
  },
  {
    'title': 'Maintain a Steady Rhythm',
    'description':
        'Keep your breathing consistent and in sync with your movements.',
  },
  {
    'title': 'Avoid Holding Your Breath',
    'description':
        'Continue to breathe naturally throughout the exercise to maintain control and focus.',
  },
];
final List<String> abdominalCrunchesItems = [
  'Shoulder',
  'Legs',
  'Cardio',
  'Coordination',
  'Core',
];
const String abdominalCrunchesInstruction =
    "Lie on your back with your knees bent and feet flat on the floor. Place your hands behind your head, elbows out to the sides. Engage your core and lift your upper body off the floor, bringing your shoulders towards your knees. Lower your upper body back down with control. Repeat, keeping a steady rhythm and focusing on your core engagement.";
const String abdominalImageFemale = AppImagePaths.femaleAbs;
const String abdominalImageMale = AppImagePaths.maleAbs;

/// Russian Twist

List<Map<String, String>> russianTwistCommonMistakes = [
  {
    'title': 'Rounding the Back',
    'description':
        'Not keeping your back straight, which can strain the lower back.',
  },
  {
    'title': 'Using Momentum',
    'description':
        'Swinging your arms instead of twisting your torso, reducing effectiveness.',
  },
  {
    'title': 'Not Engaging the Core',
    'description':
        'Failing to keep the core tight, which lessens the workout\'s impact.',
  },
  {
    'title': 'Twisting Too Quickly',
    'description':
        'Moving too fast, which can lead to poor form and reduced results.',
  },
  {
    'title': 'Feet on the Ground',
    'description':
        'Keeping feet planted, which decreases the challenge for your core.',
  },
];
List<Map<String, String>> russianTwistBreathingTips = [
  {
    'title': 'Inhale at Center',
    'description':
        'Breathe in as you return to the center position between twists.',
  },
  {
    'title': 'Exhale as You Twist',
    'description': 'Breathe out as you twist your torso to each side.',
  },
  {
    'title': 'Inhale as You Lower',
    'description':
        'Breathe in again as you slowly lower back down to the floor.',
  },
  {
    'title': 'Maintain Rhythm',
    'description':
        'Keep a steady, controlled breathing pattern to match your movement.',
  },
  {
    'title': 'Avoid Holding Breath',
    'description':
        'Continue breathing smoothly throughout the exercise to maintain energy and control.',
  },
];
final List<String> russianTwistItems = [
  'Hip Flexors',
  'Lower Back',
  'Obliques',
  'Core Stability',
];
const String russianTwistInstruction =
    "Sit with knees bent, feet slightly off the ground, and lean back slightly. Hold your hands together or a weight. Twist your torso from side to side, keeping your core engaged. Repeat.";
const String russianImageFemale = AppImagePaths.femaleAbs;
const String russianImageMale = AppImagePaths.maleAbs;

/// Heel Touch
List<Map<String, String>> heelTouchCommonMistakes = [
  {
    'title': 'Rounding the Back',
    'description':
        'Not keeping your back flat against the floor, which can strain your lower back.',
  },
  {
    'title': 'Using Momentum',
    'description':
        'Swinging your arms or legs instead of using your core muscles to reach your heels.',
  },
  {
    'title': 'Overextending',
    'description':
        'Reaching too far or pulling on your neck, which can lead to improper form.',
  },
  {
    'title': 'Not Engaging the Core',
    'description':
        'Failing to tighten your core, reducing the effectiveness of the exercise.',
  },
  {
    'title': 'Holding Breath',
    'description':
        'Not breathing consistently, which can affect your performance and comfort.',
  },
];
List<Map<String, String>> heelTouchBreathingTips = [
  {
    'title': 'Inhale at Center',
    'description': 'Breathe in as you return to the starting position.',
  },
  {
    'title': 'Exhale as You Reach',
    'description': 'Breathe out while reaching your hand toward your heel.',
  },
  {
    'title': 'Maintain Steady Breathing',
    'description':
        'Keep a consistent breathing pattern to match your movements.',
  },
  {
    'title': 'Avoid Holding Breath',
    'description':
        'Continue to breathe smoothly to stay relaxed and maintain core engagement.',
  },
];
final List<String> heelTouchItems = [
  'Core',
  'Upper Abs',
  'Obliques',
];
const String heelTouchInstruction =
    "Lie on your back with knees bent. Lift your shoulders slightly and reach your right hand to your right heel, then left hand to left heel. Alternate sides, keeping your core tight.";
String legImageMale =  AppImagePaths.maleAbs;
String legImageFemale =  AppImagePaths.femaleAbs;
/// Leg Raises
List<Map<String, String>> legRaisesCommonMistakes = [
  {
    'title': 'Arching the Lower Back',
    'description':
        'Allowing your lower back to lift off the floor, which can strain your back.',
  },
  {
    'title': 'Bending the Knees',
    'description':
        'Not keeping legs straight, reducing the exercise\'s effectiveness.',
  },
  {
    'title': 'Using Momentum',
    'description':
        'Swinging legs up and down rather than controlling the movement.',
  },
  {
    'title': 'Not Engaging the Core',
    'description':
        'Failing to keep your core tight, which lessens the impact on your abs.',
  },
  {
    'title': 'Holding Breath',
    'description':
        'Not breathing consistently, which can affect performance and form.',
  },
];
List<Map<String, String>> legRaisesBreathingTips = [
  {
    'title': 'Inhale as You Lower',
    'description': 'Breathe in as you slowly lower your legs back down.',
  },
  {
    'title': 'Exhale as You Lift',
    'description': 'Breathe out while lifting your legs toward the ceiling.',
  },
  {
    'title': 'Maintain Steady Breathing',
    'description':
        'Keep a consistent rhythm with your breathing to match your movements.',
  },
  {
    'title': 'Avoid Holding Your Breath',
    'description':
        'Continue breathing smoothly to help maintain core engagement and control.',
  },
];
final List<String> legRaisesItems = [
  'Core Stability',
  'Lower Abs',
  'Hip Flexors',
];
const String legRaisesInstruction =
    "Lie on your back with legs straight. Lift your legs toward the ceiling, then lower them slowly without touching the floor. Repeat.";
 String heelTouchMale =  AppImagePaths.maleAbs;
 String heelTouchFemale =  AppImagePaths.femaleAbs;

/// Plank
List<Map<String, String>> plankRaisesCommonMistakes = [
  {
    'title': 'Sagging Hips',
    'description': 'Allowing your hips to drop, which strains your lower back.',
  },
  {
    'title': 'Piking Hips',
    'description': 'Lifting your hips too high, reducing core engagement.',
  },
  {
    'title': 'Arching the Back',
    'description': 'Rounding your back, which can lead to discomfort.',
  },
  {
    'title': 'Not Engaging Core',
    'description':
        'Failing to tighten your core muscles, which lessens effectiveness.',
  },
  {
    'title': 'Poor Arm Position',
    'description': 'Placing elbows or hands incorrectly, affecting stability.',
  },
];
List<Map<String, String>> plankRaisesBreathingTips = [
  {
    'title': 'Inhale Deeply',
    'description': 'Breathe in through your nose before you start the plank.',
  },
  {
    'title': 'Exhale Slowly',
    'description':
        'Breathe out through your mouth while holding the plank position.',
  },
  {
    'title': 'Maintain Steady Breathing',
    'description': 'Keep a steady rhythm, breathing in and out regularly.',
  },
  {
    'title': 'Avoid Holding Breath',
    'description':
        'Continue to breathe steadily to help maintain core engagement and stability.',
  },
];
final List<String> plankRaisesItems = [
  'Shoulders',
  'Back',
  'Glutes',
  'Legs',
  'Core',
];
const String plankInstruction =
    "Start in a push-up position, then shift to your forearms. Keep your body straight from head to heels, engage your core, and hold the position. Keep your back flat and avoid sagging or lifting your hips. Breathe steadily.";
 String plankImageMale =  AppImagePaths.maleAbs;
 String plankImageFemale =  AppImagePaths.femaleAbs;

/// Cobra Stretch
List<Map<String, String>> cobraStretchCommonMistakes = [
  {
    'title': 'Overarching the Back',
    'description': 'Lifting too high, which can strain the lower back.',
  },
  {
    'title': 'Tensing Shoulders',
    'description':
        'Allowing shoulders to creep up towards the ears, which reduces the stretch.',
  },
  {
    'title': 'Not Engaging Core',
    'description':
        'Failing to engage the core, which can lead to an exaggerated arch.',
  },
  {
    'title': 'Hips Off the Floor',
    'description':
        'Lifting hips or legs, which limits the effectiveness of the stretch.',
  },
  {
    'title': 'Head Position',
    'description': 'Looking too far up or down, which can strain the neck.',
  },
];
List<Map<String, String>> cobraStretchBreathingTips = [
  {
    'title': 'Inhale as You Lift',
    'description':
        'Breathe in deeply as you press into your hands and lift your chest.',
  },
  {
    'title': 'Exhale to Deepen',
    'description':
        'Breathe out slowly while holding the stretch to deepen the stretch.',
  },
  {
    'title': 'Maintain Steady Breathing',
    'description':
        'Keep a steady, relaxed breathing pattern throughout the stretch.',
  },
  {
    'title': 'Avoid Holding Breath',
    'description':
        'Continue breathing normally to stay relaxed and enhance the stretch.',
  },
];
final List<String> cobraStretchItems = [
  'Abdominal',
  'Lower Back',
  'Chest',
  'Shoulders',
];
const String cobraStretchInstruction =
    "Lie face down with your legs extended and hands under your shoulders. Press into your hands to lift your chest off the ground, keeping your face up and shoulders relaxed. Hold the stretch while keeping your hips and legs on the floor. Breathe deeply, then lower back down.";
 String cobraImageMale =  AppImagePaths.maleAbs;
 String cobraImageFemale=  AppImagePaths.femaleAbs;

/// Spine Lumber Twist Right
List<Map<String, String>> spineLumberTwistRightCommonMistakes = [
  {
    'title': 'Rounding the Back',
    'description':
        'Allowing the lower back to arch or round, which can strain the spine.',
  },
  {
    'title': 'Shoulders Lifting Off the Floor',
    'description':
        'Not keeping shoulders flat, reducing the effectiveness of the stretch.',
  },
  {
    'title': 'Too Much Force',
    'description':
        'Using excessive force to twist, which can lead to discomfort or injury.',
  },
  {
    'title': 'Holding Breath',
    'description':
        'Not breathing deeply and consistently, which can affect relaxation and stretch.',
  },
  {
    'title': 'Uneven Positioning',
    'description':
        'Not aligning knees and hips properly, which can limit the stretch and effectiveness.',
  },
];
List<Map<String, String>> spineLumberTwistRightBreathingTips = [
  {
    'title': 'Inhale as You Twist',
    'description':
        'Breathe in deeply as you drop your knees to one side and turn your head in the opposite direction.',
  },
  {
    'title': 'Exhale to Relax',
    'description':
        'Breathe out slowly while holding the twist to deepen the stretch.',
  },
  {
    'title': 'Maintain Steady Breathing',
    'description':
        'Keep a steady, relaxed breathing pattern throughout the stretch.',
  },
  {
    'title': 'Avoid Holding Breath',
    'description':
        'Continue breathing normally to stay relaxed and enhance the stretch.',
  },
];
final List<String> spineLumberTwistRightItems = [
  'Lower Back',
  'Spine',
  'Glutes',
  'Core',
  'Hips',
];
const String spineLumberTwistRightInstruction =
    "Lie on your back with knees bent and arms out to the sides. Drop your knees to the left, turning your head to the right. Hold for 15-30 seconds, then return to the center. Repeat by dropping your knees to the right and turning your head to the left. Hold and return to the center.";
 String spineImageMale =  AppImagePaths.maleAbs;
 String spineImageFemale =  AppImagePaths.femaleAbs;

/// Spine Lumber Twist left
List<Map<String, String>> spineLumberTwistLeftCommonMistakes = [
  {
    'title': 'Rounding the Back',
    'description':
        'Allowing the lower back to arch or round, which can strain the spine.',
  },
  {
    'title': 'Shoulders Lifting Off the Floor',
    'description':
        'Not keeping shoulders flat, reducing the effectiveness of the stretch.',
  },
  {
    'title': 'Too Much Force',
    'description':
        'Using excessive force to twist, which can lead to discomfort or injury.',
  },
  {
    'title': 'Holding Breath',
    'description':
        'Not breathing deeply and consistently, which can affect relaxation and stretch.',
  },
  {
    'title': 'Uneven Positioning',
    'description':
        'Not aligning knees and hips properly, which can limit the stretch and effectiveness.',
  },
];
List<Map<String, String>> spineLumberTwistLeftBreathingTips = [
  {
    'title': 'Inhale as You Lift',
    'description':
        'Breathe in deeply as you press into your hands and lift your chest.',
  },
  {
    'title': 'Exhale to Deepen',
    'description':
        'Breathe out slowly while holding the stretch to deepen the stretch.',
  },
  {
    'title': 'Maintain Steady Breathing',
    'description':
        'Keep a steady, relaxed breathing pattern throughout the stretch.',
  },
  {
    'title': 'Avoid Holding Breath',
    'description':
        'Continue breathing normally to stay relaxed and enhance the stretch.',
  },
];
final List<String> spineLumberTwistLeftItems = [
  'Lower Back',
  'Spine',
  'Glutes',
  'Core',
  'Hips',
];
const String spineLumberTwistLeftInstruction =
    "Lie on your back with knees bent and arms out to the sides. Drop your knees to the left, turning your head to the right. Hold for 15-30 seconds, then return to the center. Repeat by dropping your knees to the right and turning your head to the left. Hold and return to the center.";
 String spineleftImage = AppImagePaths.maleAbs;
String spineleftFemale =  AppImagePaths.femaleAbs;

