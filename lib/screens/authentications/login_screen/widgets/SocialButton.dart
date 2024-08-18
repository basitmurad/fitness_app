import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../utils/constants/AppImagePaths.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: (){
        Fluttertoast.showToast(msg: "Are you want to contiune with google");
      },
      child: Row(



        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
              height: 28
              ,
              width: 28,
              AppImagePaths.googleIcon),

          const SizedBox(width: 4,),
          const Text('Continue with google'),
          const SizedBox(width: 40), // Adjust horizontal spacing
        ],
      ),
    );
  }
}
