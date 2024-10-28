import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import '../../../common/widgets/ButtonWidget.dart';
import '../../../utils/constants/AppColor.dart';
import '../challenge_screen/ChallengeScreen.dart';
import '../exercise_detail_screen/widgets/SimpleTextWidget.dart';

class JoinChallengeScreen extends StatefulWidget {
  const JoinChallengeScreen({super.key});

  @override
  _JoinChallengeScreenState createState() => _JoinChallengeScreenState();
}

class _JoinChallengeScreenState extends State<JoinChallengeScreen> {
  final DatabaseReference _challengeRef = FirebaseDatabase.instance.ref().child('challenges');
  List<Map<String, dynamic>> challenges = [];

  @override
  void initState() {
    super.initState();
    _fetchChallenges();
  }

  Future<void> _fetchChallenges() async {
    _challengeRef.once().then((DatabaseEvent event) {
      if (event.snapshot.exists) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        print('Fetched data: $data');  // Debugging statement
        List<Map<String, dynamic>> fetchedChallenges = [];
        data.forEach((key, value) {
          fetchedChallenges.add({
            'key': key,
            ...Map<String, dynamic>.from(value),
          });
        });
        setState(() {
          challenges = fetchedChallenges;
        });
      }
    }).catchError((error) {
      print('Error fetching challenges: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);
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
          ),
        ),
        title: SimpleTextWidget(
          align: TextAlign.center,
          text: 'Join Challenge',
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: dark ? AppColor.white : AppColor.black,
          fontFamily: 'Poppins',
        ),
        centerTitle: true,
      ),
      body: challenges.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator while fetching
          : Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListView.builder(
          itemCount: challenges.length,
          itemBuilder: (context, index) {
            final challenge = challenges[index];
            return ChallengeWidget(
              dark: dark,
              challengeData: challenge,
            );
          },
        ),
      ),
    );
  }
}

class ChallengeWidget extends StatelessWidget {
  final bool dark;
  final Map<String, dynamic> challengeData;

  const ChallengeWidget({
    super.key,
    required this.dark,
    required this.challengeData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MyAppHelperFunctions.screenWidth() * 0.90,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      height: 120,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: dark ? AppColor.grey.withOpacity(0.1) : AppColor.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: MyAppHelperFunctions.screenWidth() * 0.60,
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SimpleTextWidget(
                  text: '${challengeData['duration']} days challenge',
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: dark ? AppColor.white : AppColor.black,
                  fontFamily: 'Poppins',
                ),
                const SizedBox(height: 6),
                SimpleTextWidget(
                  text: 'See details',
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                  color: dark ? AppColor.white : AppColor.black,
                  fontFamily: 'Poppins',
                ),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () {
                    // Show the bottom sheet with more details
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: dark ? AppColor.grey : Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (BuildContext context) {
                        return _ChallengeDetailsBottomSheet(
                          challengeData: challengeData,
                          dark: dark,
                        );
                      },
                    );
                  },
                  child: const SimpleTextWidget(
                    text: 'See more',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: AppColor.orangeColor,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 6),

                SimpleTextWidget(text: 'Follow by: 1.6k', fontWeight: FontWeight.w400, fontSize: 12, color: dark ? AppColor.white : AppColor.black, fontFamily: 'Poppins')
              ],
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 90,
            height: 35,
            child: ButtonWidget(
              dark: dark,
              onPressed: () {
                // Implement "Join" functionality
              },
              buttonText: 'Join',
            ),
          ),
        ],
      ),
    );
  }
}

class _ChallengeDetailsBottomSheet extends StatelessWidget {
  final Map<String, dynamic> challengeData;
  final bool dark;

  const _ChallengeDetailsBottomSheet({
    required this.challengeData,
    required this.dark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Close Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SimpleTextWidget(
                text: '${challengeData['duration']} Days Challenge',
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: dark ? AppColor.white : AppColor.black,
                fontFamily: 'Poppins',
              ),
              IconButton(
                icon: Icon(Icons.close, color: dark ? AppColor.white : AppColor.black),
                onPressed: () {
                  Navigator.pop(context); // Close the sheet
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          // More Details about the Challenge
          SimpleTextWidget(
            text: 'Challenge Duration: ${challengeData['duration']}',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: dark ? AppColor.white : AppColor.black,
            fontFamily: 'Poppins',
          ),
          const SizedBox(height: 10),
          SimpleTextWidget(
            text: 'Challenge Date Range: ${challengeData['dateRange'] ?? 'N/A'}',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: dark ? AppColor.white : AppColor.black,
            fontFamily: 'Poppins',
          ),
          const SizedBox(height: 10),
          SimpleTextWidget(
            text: 'Challenge Time: ${challengeData['time'] ?? 'N/A'}',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: dark ? AppColor.white : AppColor.black,
            fontFamily: 'Poppins',
          ),
          const SizedBox(height: 10),
          SimpleTextWidget(
            text: 'Participants: 1.2k People',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: dark ? AppColor.white : AppColor.black,
            fontFamily: 'Poppins',
          ),
          const SizedBox(height: 20),
          // Display Selected Challenges
          SimpleTextWidget(
            text: 'Selected Challenges:',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: dark ? AppColor.white : AppColor.black,
            fontFamily: 'Poppins',
          ),
          const SizedBox(height: 5),
          for (var challenge in challengeData['selectedChallenges'] ?? [])
            SimpleTextWidget(
              text: challenge,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: dark ? AppColor.white : AppColor.black,
              fontFamily: 'Poppins',
            ),
        ],
      ),
    );
  }
}
