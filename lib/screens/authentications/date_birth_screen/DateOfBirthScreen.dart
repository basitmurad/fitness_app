// import 'package:fitness/screens/authentications/height_screen/HeightScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:fitness/utils/helpers/MyAppHelper.dart';
// import 'package:get/get.dart';
// import '../../../common/widgets/ButtonWidget.dart';
// import '../../../utils/constants/AppSizes.dart';
// import '../../../utils/constants/AppString.dart';
//
// class DateOfBirthScreen extends StatefulWidget {
//   const DateOfBirthScreen({super.key});
//
//   @override
//   _DateOfBirthScreenState createState() => _DateOfBirthScreenState();
// }
//
// class _DateOfBirthScreenState extends State<DateOfBirthScreen> {
//   int? _selectedIndex;
//
//   List<String> _generateYears() {
//     final currentYear = DateTime.now().year;
//     return List<String>.generate(
//       currentYear - 1950 + 1,
//           (index) => (1950 + index).toString(),
//     );
//   }
//
//   void _onItemTap(int index) {
//     setState(() {
//       _selectedIndex = _selectedIndex == index ? null : index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final years = _generateYears();
//     final dark = MyAppHelperFunctions.isDarkMode(context);
//
//     return Scaffold(
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.only(bottom: 40),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 30),
//           child: ButtonWidget(
//             dark: dark,
//             onPressed: () {
//
//
//               Get.to(HeightScreen());
//               // Handle the button press
//             },
//             buttonText: AppStrings.next,
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//             child: Column(
//               children: [
//                 // Center the "Sign Up" text just below the app bar
//                 const SizedBox(height: AppSizes.appBarHeight-20),
//                 Align(
//                   alignment: Alignment.center,
//                   child: Text(
//                     AppStrings.signUP,
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 79), // Space between the text and the rest of the content
//
//                 // Center the rest of the content in the middle of the screen
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       textAlign: TextAlign.center,
//                       AppStrings.birthdaytext,
//                       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                         fontFamily: 'Poppins',
//                         fontWeight: FontWeight.w500,
//                         fontSize: 16,
//                       ),
//                     ),
//                     const SizedBox(height: AppSizes.appBarHeight),
//
//                     // Constrain the height of the ListView.builder
//                     SizedBox(
//                       width: 160,
//                       height: 200, // Adjust this value as needed
//                       child: ListView.builder(
//                         itemCount: years.length,
//                         itemBuilder: (context, index) {
//                           bool isSelected = _selectedIndex == index;
//                           return GestureDetector(
//                             onTap: () => _onItemTap(index),
//                             child: Container(
//                               margin: const EdgeInsets.symmetric(horizontal: 0),
//                               decoration: BoxDecoration(
//                                 color: isSelected
//                                     ? Colors.blue
//                                     : Colors.transparent,
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: ListTile(
//                                 title: Text(
//                                   years[index],
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     color: isSelected
//                                         ? Colors.white
//                                         : Theme.of(context).textTheme.bodyMedium!.color,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: AppSizes.appBarHeight),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:fitness/common/snackbar/ShowSnackbar.dart';
import 'package:fitness/screens/authentications/height_screen/HeightScreen.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:get/get.dart';
import '../../../common/widgets/ButtonWidget.dart';
import '../../../utils/constants/AppSizes.dart';
import '../../../utils/constants/AppString.dart';

class DateOfBirthScreen extends StatefulWidget {
  const DateOfBirthScreen({super.key});

  @override
  _DateOfBirthScreenState createState() => _DateOfBirthScreenState();
}

class _DateOfBirthScreenState extends State<DateOfBirthScreen> {
  int? _selectedIndex;

  List<String> _generateYears() {
    final currentYear = DateTime.now().year;
    return List<String>.generate(
      currentYear - 1950 + 1,
          (index) => (1950 + index).toString(),
    );
  }

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = _selectedIndex == index ? null : index;
    });
  }

  void _handleNextButtonPress() {
    if (_selectedIndex != null) {
      // Pass the selected year to the next screen or handle it as needed
      final selectedYear = _generateYears()[_selectedIndex!];
      Get.to(HeightScreen()); // Navigate to the next screen
    } else {
      // Show a message or handle the case where no item is selected


      ShowSnackbar.showMessage(title: 'Empty', message: 'Please Select Your Birth Year', backgroundColor: AppColor.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final years = _generateYears();
    final dark = MyAppHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 30),
          child: ButtonWidget(
            dark: dark,
            onPressed: _handleNextButtonPress, // Use the new method here
            buttonText: AppStrings.next,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                // Center the "Sign Up" text just below the app bar
                const SizedBox(height: AppSizes.appBarHeight - 20),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    AppStrings.signUP,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 79), // Space between the text and the rest of the content

                // Center the rest of the content in the middle of the screen
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      AppStrings.birthdaytext,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: AppSizes.appBarHeight),

                    // Constrain the height of the ListView.builder
                    SizedBox(
                      width: 160,
                      height: 200, // Adjust this value as needed
                      child: ListView.builder(
                        itemCount: years.length,
                        itemBuilder: (context, index) {
                          bool isSelected = _selectedIndex == index;
                          return GestureDetector(
                            onTap: () => _onItemTap(index),
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 0),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.blue
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                title: Text(
                                  years[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Theme.of(context).textTheme.bodyMedium!.color,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: AppSizes.appBarHeight),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
