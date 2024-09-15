import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/AppColor.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 5 ,horizontal: 5),
      decoration: const BoxDecoration(
          color: AppColor.orangeColor,

          borderRadius: BorderRadius.only(topLeft: Radius.circular(16) ,topRight: Radius.circular(16))



      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Container(
            width: 100,
            height: 34,
            color: Colors.blue,
          ),

          const SizedBox(width: 70,),
          Container(
            width: 100,
            height: 34,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
