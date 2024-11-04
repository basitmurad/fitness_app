import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/constants/AppColor.dart';
import '../../../../utils/constants/AppImagePaths.dart';
import '../../exercise_start_screen/widgets/CenteredTextWithIconsRow.dart';
import 'SimpleTextWidget.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({
    super.key, required this.dark,
  });
  final bool dark ;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 1 ,horizontal: 5),
      decoration: const BoxDecoration(
          color: AppColor.orangeColor,

          borderRadius: BorderRadius.only(topLeft: Radius.circular(16) ,topRight: Radius.circular(16))



      ),
      child:
      Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          // SizedBox(
          //   width: 150,
          //   height: 34,
          //   child:
          //
          //   CenteredTextWithIconsRow(
          //     text: '1',
          //
          //     leftIcon: AppImagePaths.right,
          //     rightIcon: AppImagePaths.right,
          //     text1: '/'+'09', textColor: dark ? AppColor.white :AppColor.black, onLeftIconPressed: () {  }, onRightIconPressed: () {  }, leftIconAngle: 0, rightIconAngle: 3.15,
          //   ),
          //
          //
          //
          // ),

          GestureDetector(
            onTap: ()=> Get.back(),
            child: Container(
              width: 150,
              height: 34,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12)
              ),
              child: const SimpleTextWidget(text: 'Close', fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black, fontFamily: 'Poppins',),
            ),
          )
        ],
      ),
    );
  }
}
