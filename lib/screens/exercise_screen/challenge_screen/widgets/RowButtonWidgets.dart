import 'package:fitness/screens/exercise_screen/create_challenge_screen/CreateChallengeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/constants/AppColor.dart';

class RowButtonWidgets extends StatelessWidget {
  const RowButtonWidgets({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row
      (
      children: [
        Expanded(
          child:
          ElevatedButton(
            onPressed: () {

              Get.to(const CreateChallengeScreen());
              // Define your action for the ElevatedButton here
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(double.infinity, 46)       ,
              padding: const EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6), // Background color of the button
              foregroundColor: Colors.black, backgroundColor: AppColor.orangeColor, // Text color
            ),
            child:
            Text('Create a Challenge' ,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: dark ?AppColor.white :AppColor.white ,fontWeight: FontWeight.w300 ,fontSize: 13, fontFamily: 'Poppins'),),
          ),
        ),
        const SizedBox(width: 8), // Optional spacing between the buttons
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              // Define your action for the OutlinedButton here
            },
            style: OutlinedButton.styleFrom(
              fixedSize: const Size(double.infinity, 46)       ,
              padding: const EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6), // Background color of the button
              foregroundColor: Colors.black, // Text color
            ),
            child:
            Text('Create a Challenge' ,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: dark ?AppColor.white :AppColor.black ,fontWeight: FontWeight.w300 ,fontSize: 13, fontFamily: 'Poppins'),),
          ),
        ),
      ],
    );
  }
}
