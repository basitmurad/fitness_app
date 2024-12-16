import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/CustomButton.dart';
import '../../../../../utils/constants/AppColor.dart';
import '../../../../../utils/constants/AppDevicesUtils.dart';
import '../../../../../utils/constants/AppImagePaths.dart';
import '../../../../../utils/constants/AppString.dart';
import '../../../../exercise_screen/screen/challenge_screen/ChallengeScreen.dart';


class ChallengedWidget extends StatelessWidget {
  const ChallengedWidget({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: AppDevicesUtils.getScreenWidth(context),
        height: 161,
        decoration: const BoxDecoration(
            color: AppColor.orangeColor,
            borderRadius: BorderRadius.all(Radius.circular(6))),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 24,
              left: 12,
              right: 90,
              child: Text(
                AppStrings.challenges,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(
                    color: dark ? AppColor.white : AppColor.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              top: 52,
              left: 10,
              right: 60,
              child: Text(
                AppStrings.boostText,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: dark ? AppColor.white : AppColor.white,
                    fontFamily: 'Poppins',
                    fontSize: 14),
              ),
            ),
            Positioned(
                right: -5,
                top: 1,
                child: Transform.rotate(
                  angle: -0.1,
                  child: const Image(
                    height: 60,
                    width: 60,
                    image: AssetImage(AppImagePaths.upperImage),
                  ),
                )),
            Positioned(
                bottom: -5,
                left: 1,
                child: Transform.rotate(
                  angle: -0.1,
                  child: const Image(
                    height: 60,
                    width: 60,
                    image: AssetImage(AppImagePaths.bottomImage),
                  ),
                )),
             Positioned(
                bottom: 10,
                left: 55,
                right: 55,
                child: GestureDetector(

                    onTap: ()=>Get.to(const ChallengeScreen()),
                    child: const CustomButton(height1: 30.0, buttontext: 'Start', backColor: AppColor.white, textColor: AppColor.orangeColor,)))
          ],
        ));
  }
}

