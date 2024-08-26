import 'package:fitness/common/widgets/ButtonWidget.dart';
import 'package:fitness/screens/authentications/name_screen/NameScreen.dart';
import 'package:fitness/screens/authentications/select_gender_screen/widgets/GenderWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/AppDevicesUtils.dart';
import '../../../utils/constants/AppImagePaths.dart';
import '../../../utils/constants/AppSizes.dart';
import '../../../utils/constants/AppString.dart';
import '../../../utils/helpers/MyAppHelper.dart';
import '../../controller/SelectGenderController.dart';

class SelectGenderScreen extends StatelessWidget {
  const SelectGenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);

    SelectGenderController selectGenderController =
        Get.put(SelectGenderController());
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 110,
        padding: EdgeInsets.only(bottom: 40),
        color: Colors.transparent,
        child: Obx(() => Opacity(
              opacity: selectGenderController.selectedGender.value.isEmpty
                  ? 0.4
                  : 1.0,
              child: Padding(
                padding: EdgeInsets.only(left: 40, right: 40 ,
                top: 11,bottom: 11
                ),
                // Systematic padding
                child: ButtonWidget(
                  dark: dark,
                  onPressed: () {
                    if (selectGenderController
                        .selectedGender.value.isNotEmpty) {
                      Get.to(NameScreen());
                    } else
                      (MyAppHelperFunctions.showSnackBar(
                          'Please Select Your Gender'));
                    selectGenderController.selectedGender.value;
                    // Define your onPressed logic here
                  },
                  buttonText: AppStrings.next,
                ),
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: AppSizes.appBarHeight,
              ),
              Text(
                AppStrings.signUP,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              const SizedBox(
                height: AppSizes.spaceBtwItems + 30,
              ),
              Container(
                height: AppDevicesUtils.getScreenWidth(context) * 1.4,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: GenderWidget(
                          imagePath: AppImagePaths.male,
                          checkBoxText: AppStrings.male,
                          isMaleWidget: true,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Container(
                        child: GenderWidget(
                          imagePath: AppImagePaths.female,
                          checkBoxText: AppStrings.female,
                          isMaleWidget: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 10,
              //   ),
              //   child: Obx(() => Opacity(
              //         opacity:
              //             selectGenderController.selectedGender.value.isEmpty
              //                 ? 0.4
              //                 : 1.0,
              //         child: ButtonWidget(
              //           dark: dark,
              //           onPressed: () {},
              //           buttonText: AppStrings.next,
              //         ),
              //       )),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
