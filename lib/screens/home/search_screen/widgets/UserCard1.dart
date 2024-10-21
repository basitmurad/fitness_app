import 'package:flutter/material.dart';
import '../../../../common/widgets/CircularImage.dart';
import '../../../../utils/constants/AppColor.dart';
import '../../../../utils/constants/AppDevicesUtils.dart';
import '../../../exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';

class UserCard1 extends StatelessWidget {
  const UserCard1({
    super.key,
    required this.dark,
    required this.userName,
    required this.onMessage,
    required this.userImageUrl, required this.userID, // Add onRemove parameter
  });

  final bool dark;
  final String userID;
  final String userName;
  final String userImageUrl;
  final VoidCallback onMessage; // Callback to handle removal

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      height: 120,
      width: AppDevicesUtils.screenWidth() * 1.2,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 5),
          CircularImage(
            imageUrl: userImageUrl,
            size: 73,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SimpleTextWidget(
                  text: userName,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: dark ? AppColor.white : AppColor.black,
                  fontFamily: 'Poppins',
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onMessage,
            child: Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              alignment: Alignment.center,
              height: 30,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColor.orangeColor,
              ),
              child: const SimpleTextWidget(
                text: 'Message',
                fontWeight: FontWeight.w300,
                fontSize: 16,
                color: AppColor.white,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          )
        ],
      ),
    );
  }
}
