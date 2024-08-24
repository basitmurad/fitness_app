import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/ButtonWidget.dart';
import '../../../utils/constants/AppString.dart';

class HeightScreen extends StatelessWidget {
  const HeightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // Helps resize the screen when the keyboard is displayed

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: AppSizes.appBarHeight,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    AppStrings.signUP,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  // SizedBox(height: AppDevicesUtils.getScreenWidth(context) * 0.45,),
                  const SizedBox(
                    height: 79,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    AppStrings.textHeight,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),

                  SizedBox(
                    height: AppSizes.appBarHeight,
                  ),
                  // Opacity for TextInputWidget
                  // Obx(() => Opacity(
                  //   opacity: nameScreenController.isNameEntered.value ? 1.0 : 0.4,
                  //   child: TextInputWidget(
                  //       hintText: 'First Name',
                  //       focusNode: nameScreenController.focusNode, // Pass focus node
                  //
                  //       controller: nameScreenController.nameController,
                  //       dark: dark
                  //   ),
                  // )),

                  Container(
                    alignment: Alignment.center,

                    width: 110,
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // Curves the edges
                        border: Border.all(
                            width: 1, color: Colors.grey.withOpacity(0.1))),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 48,

                          color: Colors.redAccent,

                          child: Text(
                            textAlign: TextAlign.center,
                            'Cm',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                          ),
                        ),


                        Container(height: 35,
                        width: 1,
                        color: AppColor.grey,),

                        Container(
                          width: 48,
                          color: Colors.redAccent,

                          child: Text(
                            textAlign: TextAlign.center,

                            'Ft',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: AppSizes.appBarHeight - 20,
                  ),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: ButtonWidget(
                        dark: dark,
                        onPressed: () {

                          // Handle the button press
                        },
                        buttonText: AppStrings.next,
                      ),
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //
                  //   // Opacity for ButtonWidget
                  //   child: Obx(() => Opacity(
                  //     opacity: nameScreenController.isNameEntered.value ? 1.0 : 0.4,
                  //     child: ButtonWidget(
                  //       dark: dark,
                  //       onPressed: () {
                  //
                  //
                  //         nameScreenController.getName();
                  //       },
                  //       buttonText: AppStrings.next,
                  //     ),
                  //   )),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
