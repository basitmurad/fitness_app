import 'package:fitness/screens/exercise_screen/exercise_start_screen/widgets/CenteredTextWithIconsRow.dart';
import 'package:fitness/screens/exercise_screen/exercise_start_screen/widgets/CircleWithText.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitness/common/widgets/ButtonWidget.dart';
import 'package:fitness/screens/exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';
import 'package:fitness/utils/constants/AppImagePaths.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import '../../exercise_screen_controller/ExerciseProgressController.dart';

class ExerciseProgressScreen extends StatelessWidget {
  const ExerciseProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);
    final ExerciseProgressController controller = Get.put(ExerciseProgressController());

    return Scaffold(
      bottomNavigationBar: Obx(() {
        return BottomAppBar(
          height: 85,
          padding: const EdgeInsets.only(bottom: 5),
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 18),
            child: controller.isStartButtonVisible.value
                ? ButtonWidget(
              dark: dark,
              onPressed: () {
                controller.toggleButton(); // Hide Start button and show Paused button
              },
              buttonText: 'Start',
            )
                :  GestureDetector(

              onTap: (){
                controller.toggleButton();
              },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.orangeColor,

                      borderRadius: BorderRadius.circular(6)
                    ),
                    
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        const Icon(Icons.pause ,color: Colors.white,),
                        Text('Pause' ,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: dark ?AppColor.white :AppColor.white ,fontSize: 14 ,fontWeight: FontWeight.w400 ,fontFamily: 'Poppins'),)
                      ],
                    ),
                              ),
                )
          ),
        );
      }),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: AppSizes.appBarHeight-10,
              ),
               SimpleTextWidget(
                text: 'Jumping Jack',
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: dark ?AppColor.white :AppColor.black,
                fontFamily: 'Poppins',
              ),
              const SizedBox(
                height: AppSizes.spaceBtwItems,
              ),
              Container(
                width: AppDevicesUtils.getScreenWidth(context) * 0.95,
                height: 231,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(AppImagePaths.femaleChest),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.transparent,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                  ],
                ),
              ),


              const SizedBox(height: AppSizes.appBarHeight,),
               CircleWithText(
                text: '00.20',
                size: 144.0,
                borderColor: AppColor.orangeColor,
                backgroundColor: Colors.transparent,
                textColor: dark ? AppColor.white :AppColor.black,
                borderWidth: 12.0,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems +10,),

              Container(
                alignment: Alignment.center,
                child: SimpleTextWidget(

                    text: '2 sets', fontWeight: FontWeight.w600, fontSize: 16, color: dark ? AppColor.white :AppColor.black, fontFamily: 'Poppins'),
              ),

          const SizedBox(height: AppSizes.spaceBtwItems+10,),
           Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child:
              CenteredTextWithIconsRow(
                text: '1',

                leftIcon: AppImagePaths.right,
                rightIcon: AppImagePaths.left,
                text1: '/'+'09', textColor: dark ? AppColor.white :AppColor.black, onLeftIconPressed: () {  }, onRightIconPressed: () {  },
              ),
            ),
          ),

            ],
          ),
        ),
      ),
    );
  }
}
