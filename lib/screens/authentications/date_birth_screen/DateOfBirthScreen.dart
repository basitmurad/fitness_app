import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/common/snackbar/ShowSnackbar.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:flutter/material.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import '../../../common/widgets/ButtonWidget.dart';
import '../../../utils/constants/AppSizes.dart';
import '../../../utils/constants/AppString.dart';
import '../../shared_preferences/UserPreferences.dart';
import '../height_screen/HeightScreen.dart';

class DateOfBirthScreen extends StatefulWidget {
  const DateOfBirthScreen({super.key, required this.email, required this.password, required this.gender, required this.name});

  final String email;
  final String password;
  final String gender;
  final String name;

  @override
  _DateOfBirthScreenState createState() => _DateOfBirthScreenState();
}

class _DateOfBirthScreenState extends State<DateOfBirthScreen> {
  final currentYear = DateTime.now().year;

  late FixedExtentScrollController _scrollController;
  int _selectedYear = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    _scrollController = FixedExtentScrollController(
      initialItem: DateTime.now().year - 1900,
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);
    _checkStoredData();

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 30),
          child: ButtonWidget(
            dark: dark,

            onPressed: () async {
              if (_selectedYear.toString().isNotEmpty) {
                String age = (DateTime.now().year - _selectedYear).toString();

                await UserPreferences.saveUserData(
                  email: widget.email,
                  password: widget.password,
                  gender: widget.gender,
                  name: widget.name,
                  age: _selectedYear - DateTime.now().year + 2024 , // Set age based on the selected year
                  height: '', // To be filled later
                  weight: '', // To be filled later
                  targetWeight: '', // To be filled later
                  mainGoal: '',
                );

              await  _uploadGenderToFirebase((_selectedYear - DateTime.now().year + 2024).toString());

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HeightScreen(
                      email: widget.email,
                      password: widget.password,
                      gender: widget.gender,
                      name: widget.name, year: _selectedYear ,
                    ),
                  ),
                );
              } else {

                ShowSnackbar.showMessage(title: "Failed", message: 'Enter valid birth year', backgroundColor: AppColor.error);
                // Handle the case where _selectedYear is empty if needed
              }
            },
            buttonText: AppStrings.next,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                const SizedBox(height: 79),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    AppStrings.birthdaytext,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.appBarHeight + 40),
                SizedBox(
                  height: AppDevicesUtils.getScreenHeight() * 0.3,
                  child: ListWheelScrollView.useDelegate(
                    controller: _scrollController,
                    itemExtent: 50,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selectedYear = 1900 + index;
                      });
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        final year = 1900 + index;
                        final isSelected = _selectedYear == year;

                        return Container(
                          width: 150,
                          decoration: BoxDecoration(
                            color: isSelected ? AppColor.orangeColor : Colors.transparent,
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            year.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? (dark ? Colors.white : Colors.white)
                                  : (dark ? Colors.white.withOpacity(0.5) : Colors.black54),
                            ),
                          ),
                        );
                      },
                      childCount: 200,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _checkStoredData() async {
    try {
      final userData = await UserPreferences.getUserData();

      if (userData.isEmpty) {
        debugPrint('No user data found.');
      } else {
        debugPrint('User data found:');
        debugPrint('Email: ${userData[UserPreferences.emailKey]}');
        debugPrint('Password: ${userData[UserPreferences.passwordKey]}');
        debugPrint('Gender: ${userData[UserPreferences.genderKey]}');
        debugPrint('Name: ${userData[UserPreferences.nameKey]}');
        debugPrint('Age: ${userData[UserPreferences.ageKey]}');
        debugPrint('Height: ${userData[UserPreferences.heightKey]}');
        debugPrint('Weight: ${userData[UserPreferences.weightKey]}');
        debugPrint('Target Weight: ${userData[UserPreferences.targetWeightKey]}');
        debugPrint('Main Goal: ${userData[UserPreferences.mainGoalKey]}');
      }
    } catch (e) {
      debugPrint('Error retrieving user data: ${e.toString()}');
    }
  }

  Future<void> _uploadGenderToFirebase(String name) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    try {
      await databaseReference.child('users/$userId').update({
        'age': name,
      });
      debugPrint('Gender updated in Firebase: $name');
    } catch (e) {
      debugPrint('Error updating gender: ${e.toString()}');
    }
  }

}
