import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/CustomButton.dart';
import '../../../../common/widgets/CustomButtonWithIcon.dart';
import '../../../../utils/constants/AppColor.dart';
import '../../../../utils/constants/AppImagePaths.dart';

class FollowUserCard extends StatelessWidget {
  const FollowUserCard({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6.0),
              topRight: Radius.circular(6.0),
            ),
            child: Image(
              height: 70,
              width: 155,
              fit: BoxFit.fitWidth,
              image: AssetImage(AppImagePaths.abs),
            ),
          ),
          const SizedBox(height: 6.0),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              'Sofia Ansari',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: dark ? AppColor.black : AppColor.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 10,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(height: 16.0),
          const Padding(
            padding: EdgeInsets.only(left: 6, right: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: CustomButtonWithIcon(
                    height1: 18.0,
                    buttontext: 'Follow',
                    backColor: AppColor.orangeColor,
                    textColor: AppColor.white, iconData: Iconsax.user,
                  ),
                ),
                SizedBox(width: 4.0),
                Expanded(
                  child: CustomButton(
                    height1: 18.0,
                    buttontext: 'Remove',
                    backColor: AppColor.grey,
                    textColor: AppColor.black,
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
