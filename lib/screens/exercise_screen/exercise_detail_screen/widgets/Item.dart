import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/AppColor.dart';

class Item extends StatelessWidget {
  const Item({
    super.key, required this.dark, required this.text1,
  });

  final bool dark;
  final String text1;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),

      // Add spacing between items
      width: 130,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 8),
          Container(

            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColor.orangeColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.only(right: 8.0 ,left: 0,top: 0,bottom: 0),
            child: Text(text1 ,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: dark ? AppColor.white : AppColor.black),),
          ),
        ],


      ),);
  }
}
