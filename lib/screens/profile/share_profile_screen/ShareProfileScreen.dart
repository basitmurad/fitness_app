import 'package:fitness/screens/profile/share_profile_screen/widgets/IconWithTextWidget.dart';
import 'package:fitness/screens/profile/share_profile_screen/widgets/ShareCardItem.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:fitness/utils/constants/AppString.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/CircularImage.dart';
import '../../../../utils/constants/AppColor.dart';
import '../../../../utils/constants/AppSizes.dart';
import '../../exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';


class ShareProfileScreen extends StatelessWidget {
  const ShareProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon:  Icon(CupertinoIcons.arrow_left ,color: dark? AppColor.white : AppColor.black,)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              CircularImage(
                imageUrl:
                    'https://images.unsplash.com/photo-1727324358652-e82abf20aad2?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                size: 100,
              ),
              const SizedBox(height: 4),
              SimpleTextWidget(
                  text: '@knc sors',
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: dark ? AppColor.white : AppColor.black,
                  fontFamily: 'Poppins'),
              SizedBox(
                height: AppDevicesUtils.getScreenHeight() * 0.35,
              ),
               Row(
                children: [
                  const ShareCardItem(
                    text: 'Copy Link',
                    iconData: Icons.copy_outlined, // Pass the icon data
                  ),
                  const SizedBox(width: 16),
                  const Spacer(), // Add space between the containers
                  GestureDetector(
                    onTap: (){},
                    child: const ShareCardItem(
                      text: 'Share Link',
                      iconData: Icons.share, // Pass the icon data
                    ),
                  ),
                ],
              ),
              IconWithTextWidget(dark: dark),
              const SizedBox(
                height: AppSizes.appBarHeight - 25,
              ),
              SimpleTextWidget(
                  text: AppStrings.textConnect,
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: AppColor.orangeColor,
                  fontFamily: 'Poppins')
            ],
          ),
        ),
      ),
    );
  }
}

