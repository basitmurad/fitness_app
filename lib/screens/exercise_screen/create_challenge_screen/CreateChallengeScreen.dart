import 'package:fitness/screens/exercise_screen/challenge_screen/ChallengeScreen.dart';
import 'package:fitness/screens/exercise_screen_controller/CreateChallengeScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/AppColor.dart';
import '../../../utils/constants/AppString.dart';
import '../../../utils/helpers/MyAppHelper.dart';
import '../exercise_detail_screen/widgets/SimpleTextWidget.dart';

class CreateChallengeScreen extends StatelessWidget {
  const CreateChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);
    CreateChallengeScreenController controller =
        Get.put(CreateChallengeScreenController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Get.to(const ChallengeScreen());
            },
            icon: Icon(
              Icons.arrow_back,
              color: dark ? AppColor.white : AppColor.black,
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
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [


              
              Obx(
                    () => DropdownButton<String>(
                  value: controller.selectedValue.value.isEmpty
                      ? null
                      : controller.selectedValue.value,
                  onChanged: (String? newValue) {
                    controller.selectedValue.value = newValue!;
                  },
                  items: controller.items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  hint: Text('Select an item'),
                ),
              ),

            ],
          ),
        )),
      ),
    );
  }
}
