import 'package:fitness/screens/profile/edit_profile_screen/widgets/ImageWidget.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants/AppColor.dart';
import '../../../../../utils/helpers/MyAppHelper.dart';
import '../../../../common/widgets/ButtonWidget.dart';
import '../../../../utils/constants/AppString.dart';
import '../../exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';
import '../controller/EditProfileScreenController.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);

    // Using GetX controller
    final EditProfileScreenController controller = Get.put(EditProfileScreenController());

    return Scaffold(

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 30),
          child: ButtonWidget(
            dark: dark,

            onPressed: () async {
              Get.back();
              }
            ,
            buttonText: AppStrings.save,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSizes.appBarHeight - 15,),
              Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.arrow_back,
                        color: dark ? AppColor.white : AppColor.black),
                  ),
                  const Spacer(),
                  SimpleTextWidget(
                    align: TextAlign.center,
                    text: 'Edit Profile',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: dark ? AppColor.white : AppColor.black,
                    fontFamily: "Poppins",
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(
                width: AppDevicesUtils.getScreenWidth(context) * 0.8,
                child: const Divider(
                  height: 2,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: AppSizes.productImageRadius,),
              const Align(
                alignment: Alignment.topCenter,
                child: ImageWidget1(),
              ),
              const SizedBox(height: 4,),
              SimpleTextWidget(
                text: 'Change Photo',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: dark ? AppColor.white : AppColor.black,
                fontFamily: "Poppins",
              ),



              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: dark ? AppColor.white : AppColor.black.withOpacity(0.6),
                      fontFamily: "Poppins",
                    ),
                  ),
                  const Spacer(),

                  Obx(() => Text(
                    controller.name.value, // Fetching name from controller
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: dark ? AppColor.white : AppColor.black,
                      fontFamily: "Poppins",
                    ),
                  )),
                  IconButton(
                    onPressed: () {
                      controller.showChangeNameDialog(context);
                    },
                    icon: Icon(Icons.navigate_next_rounded, color: dark ? AppColor.white : AppColor.black),
                  ),
                ],
              ),

              const SizedBox(height: AppSizes.spaceBtwInputFields -10,),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: dark ? AppColor.white : AppColor.black.withOpacity(0.6),
                      fontFamily: "Poppins",
                    ),
                  ),
                  const Spacer(),

                 Text(
                    '@sdkjfw4', // Fetching name from controller
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: dark ? AppColor.white : AppColor.black,
                      fontFamily: "Poppins",
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.showChangeNameDialog(context);
                    },
                    icon: Icon(Icons.navigate_next_rounded, color: dark ? AppColor.white : AppColor.black),
                  ),
                ],
              ),

              const SizedBox(height: AppSizes.spaceBtwInputFields -10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between all items
                children: [
                  // The first 'Bio' text
                  Text(
                    'Bio',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: dark ? AppColor.white : AppColor.black.withOpacity(0.6),
                      fontFamily: "Poppins",
                    ),
                  ),

                  // Spacer to push the second 'Bio' to the left of the next element
                  const Spacer(),

                  // The second 'Bio' text (optional if needed for display)
                  Text(
                    'Fitness Lover',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: dark ? AppColor.white : AppColor.black,
                      fontFamily: "Poppins",
                    ),
                  ),

                  // IconButton aligned to the right
                  IconButton(
                    onPressed: () {
                      controller.showChangeNameDialog(context);
                    },
                    icon: Icon(Icons.navigate_next_rounded, color: dark ? AppColor.white : AppColor.black),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
