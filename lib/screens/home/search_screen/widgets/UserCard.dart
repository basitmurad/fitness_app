import 'package:flutter/material.dart';
import '../../../../common/widgets/CircularImage.dart';
import '../../../../utils/constants/AppColor.dart';
import '../../../../utils/constants/AppDevicesUtils.dart';
import '../../../exercise_screen/screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.dark,
    required this.userName,
    required this.onRemove,
    required this.onFollow,
    required this.userImageUrl, // Add onRemove parameter
  });

  final bool dark;
  final String userName;
  final String userImageUrl;
  final VoidCallback onRemove; // Callback to handle removal
  final VoidCallback onFollow; // Callback to handle removal

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
            size: 98,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              SimpleTextWidget(
                text: userName,
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: dark ? AppColor.white : AppColor.black,
                fontFamily: 'Poppins',
              ),
              const SizedBox(height: 1),
              SimpleTextWidget(
                text: 'You may know “$userName”',
                fontWeight: FontWeight.w300,
                fontSize: 14,
                color: dark ? AppColor.white : AppColor.black,
                fontFamily: 'Poppins',
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    height: 50,
                    width: 220,
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 91,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColor.grey1.withOpacity(0.6),
                          ),
                          child: TextButton(
                            onPressed: onRemove, // Call the onRemove callback
                            child: SimpleTextWidget(
                              text: 'Remove',
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                              color: dark ? AppColor.white : AppColor.black,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                          height: 40,
                          width: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColor.orangeColor,
                          ),
                          child: TextButton(
                            onPressed: onFollow,
                            child: const SimpleTextWidget(
                              text: 'Follow',
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                              color: AppColor.white,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
