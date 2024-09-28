import 'package:flutter/cupertino.dart';
import '../../../../../utils/constants/AppColor.dart';
import '../../../exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';

class UserFollowingPostWidget extends StatelessWidget {
  const UserFollowingPostWidget({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SimpleTextWidget(
                  text: '47',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: dark ? AppColor.white : AppColor.black,
                  fontFamily: 'Poppins'),
              const SizedBox(height: 10),
              SimpleTextWidget(
                  text: 'Posts',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: dark ? AppColor.white : AppColor.black,
                  fontFamily: 'Poppins'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SimpleTextWidget(
                  text: '47',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: dark ? AppColor.white : AppColor.black,
                  fontFamily: 'Poppins'),
              const SizedBox(height: 10),
              SimpleTextWidget(
                  text: 'Followers',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: dark ? AppColor.white : AppColor.black,
                  fontFamily: 'Poppins'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SimpleTextWidget(
                  text: '47',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: dark ? AppColor.white : AppColor.black,
                  fontFamily: 'Poppins'),
              const SizedBox(height: 10),
              SimpleTextWidget(
                  text: 'Following',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: dark ? AppColor.white : AppColor.black,
                  fontFamily: 'Poppins'),
            ],
          ),
        ],
      ),
    );
  }
}
