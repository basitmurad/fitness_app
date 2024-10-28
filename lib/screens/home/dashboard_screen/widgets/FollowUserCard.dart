
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/CustomButton.dart';
import '../../../../common/widgets/CustomButtonWithIcon.dart';
import '../../../../utils/constants/AppColor.dart';
import '../../../../utils/constants/AppImagePaths.dart'; // Import the file containing your placeholder image path

class FollowUserCard extends StatelessWidget {
  final bool dark;
  final String userName;
  final String imagePath;
  final VoidCallback onFollowPressed;
  final VoidCallback onRemovePressed;
  final bool isFollowing;

  const FollowUserCard({
    super.key,
    required this.dark,
    required this.userName,
    required this.imagePath,
    required this.onFollowPressed,
    required this.onRemovePressed,
    this.isFollowing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6.0),
              topRight: Radius.circular(6.0),
            ),
            child: imagePath.isNotEmpty
                ? Image.network(
              imagePath,
              height: 70,
              width: 155,
              fit: BoxFit.fitWidth,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child; // Return the child if loading is done
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                ); // Show loading indicator while loading
              },
              errorBuilder: (context, error, stackTrace) {
                // Display placeholder if there's an error
                return Image.asset(
                  AppImagePaths.placeholder1, // Placeholder image path
                  height: 70,
                  width: 155,
                  fit: BoxFit.cover,
                );
              },
            )
                : Image.asset(
              AppImagePaths.placeholder1, // Placeholder image path
              height: 70,
              width: 155,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 6.0),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              userName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: dark ? AppColor.white : AppColor.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: CustomButtonWithIcon(
                    height1: 18.0,
                    buttontext: isFollowing ? 'Unfollow' : 'Follow',
                    backColor: isFollowing ? AppColor.grey : AppColor.orangeColor,
                    textColor: AppColor.white,
                    iconData: isFollowing ? Iconsax.user_minus : Iconsax.user_add,
                    onPressed: onFollowPressed,
                  ),
                ),
                const SizedBox(width: 4.0),
                Expanded(
                  child: CustomButton(
                    height1: 18.0,
                    buttontext: 'Remove',
                    backColor: AppColor.grey,
                    textColor: AppColor.black,
                    onPressed: onRemovePressed,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
