import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/AppColor.dart';
import '../../../exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';
import '../../edit_profile_screen/EditProfileScreen.dart';
import '../../share_profile_screen/ShareProfileScreen.dart';

class ButtonsWidget extends StatelessWidget {
  const ButtonsWidget({
    super.key,
    required this.dark,
  });

  final bool dark;
  String generateProfileLink(String userId) {
    const String baseUrl = 'https://yourapp.com/profile/'; // Replace with your actual app URL
    return '$baseUrl$userId';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColor.grey,
              ),
              child: TextButton(
                onPressed: () {
                  // Navigate to Edit Profile screen
                  Get.to(() => const EditProfileScreen());
                },
                child: const SimpleTextWidget(
                  text: 'Edit Profile',
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColor.grey,
              ),
              child: TextButton(
                onPressed: () {


                  Get.to(() => const ShareProfileScreen());

                },
                child: const SimpleTextWidget(
                  text: 'Share Profile',
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColor.grey,
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.person,
                  color: dark ? AppColor.black : AppColor.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
