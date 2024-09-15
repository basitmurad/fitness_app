import 'package:fitness/screens/exercise_screen/challenge_screen/ChallengeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/constants/AppColor.dart';
import '../../../utils/constants/AppString.dart';
import '../../../utils/helpers/MyAppHelper.dart';
import '../exercise_detail_screen/widgets/SimpleTextWidget.dart';

class CreateChallengeScreen extends StatelessWidget {
  const CreateChallengeScreen({super.key});

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
            icon:  Icon(
              Icons.arrow_back,
              color: dark ? AppColor.white :AppColor.black,
            )),
        title: SimpleTextWidget(
            align: TextAlign.center,
            text: AppStrings.textCreateChallenge,
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: dark ? AppColor.white : AppColor.black,
            fontFamily: 'Poppins'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: SafeArea(child: Padding(padding: EdgeInsets.symmetric(vertical: 10 ,horizontal: 10) ,
        child: Column(

          children: [


          ],
        ),)),
      ),
    );
  }
}
