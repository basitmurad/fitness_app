import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../utils/constants/AppImagePaths.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: (){
        Fluttertoast.showToast(msg: "Are you want to continue with google");
      },
      child: Column(


        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Image.asset(
              height: 36
              ,
              width: 36,
              AppImagePaths.google),

          const SizedBox(height: 6,),
           Text('Google' ,style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 14 ,fontWeight: FontWeight.w400),),
        ],
      ),
    );
  }
}
