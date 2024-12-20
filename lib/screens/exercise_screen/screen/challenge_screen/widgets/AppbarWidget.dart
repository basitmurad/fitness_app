import 'package:fitness/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/AppColor.dart';
import '../../../../../utils/constants/AppDevicesUtils.dart';
import '../../../../../utils/constants/AppString.dart';
import '../../../../home/screen/dashboard_screen/Dashboard.dart';
import '../../exercise_detail_screen/widgets/SimpleTextWidget.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(


      children: [

        IconButton(
            padding: EdgeInsets.zero,
            onPressed: (){
          Get.to( NavigationMenu());

        }, icon: Icon(Icons.arrow_back ,color: dark ? AppColor.white :AppColor.black
          ,)),

        Container(
          padding: EdgeInsets.zero,
          width: AppDevicesUtils.getScreenWidth(context) *0.7,
          alignment: Alignment.center,
          child:
          SimpleTextWidget(

              align: TextAlign.center,

              text: AppStrings.textChallenge, fontWeight: FontWeight.w700, fontSize: 16, color: dark ?AppColor.white : AppColor.black, fontFamily: 'Poppins'),
        )
      ],
    );
  }
}
