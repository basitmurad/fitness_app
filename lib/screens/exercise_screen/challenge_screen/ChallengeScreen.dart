import 'package:fitness/screens/exercise_screen/challenge_screen/widgets/RowButtonWidgets.dart';
import 'package:fitness/screens/exercise_screen/challenge_screen/widgets/SelectWidgets.dart';
import 'package:fitness/screens/exercise_screen/challenge_screen/widgets/TipsWidgets.dart';
import 'package:fitness/screens/exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/constants/AppString.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/dashboard_screen/Dashboard.dart';

class ChallengeScreen extends StatelessWidget {
  const ChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Get.back();
            },
            icon:  Icon(
              Icons.arrow_back,
              color: dark ? AppColor.white :AppColor.black,
            )),
        title: SimpleTextWidget(
            align: TextAlign.center,
            text: AppStrings.textChallenge,
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: dark ? AppColor.white : AppColor.black,
            fontFamily: 'Poppins'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: AppDevicesUtils.getScreenHeight() * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [


                    SelectWidgets(dark: dark),


                    TipsWidgets(dark: dark),

                    const SizedBox(
                      height: AppSizes.appBarHeight+20 ,
                    ),
                RowButtonWidgets(dark: dark),

                ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}



