import 'package:fitness/screens/authentications/login_screen/LoginScreen.dart';
import 'package:fitness/utils/constants/AppImagePaths.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/constants/AppString.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [

          IconButton(onPressed: (){
            Get.to(()=>const LoginScreen());

          }, icon: const Icon(Icons.clear))
        ],),
      
      body: SingleChildScrollView(
        child:

        Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(children: [
            ///image
            const Image(image:   AssetImage(AppImagePaths.forgetillustration)
              ),

            const SizedBox(height: AppSizes.spaceBtwSections,),

            ///title and sub title
            Text(AppStrings.passwordResetEmail,style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center,),
            const SizedBox(height: AppSizes.spaceBtwItems,),
            Text(AppStrings.email ,style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center,),
            const SizedBox(height: AppSizes.spaceBtwItems,),
            Text(AppStrings.accountText  ,style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),

            const SizedBox(height: AppSizes.spaceBtwSections,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: (){}, child:  Text(AppStrings.done ),),
            ),
            const SizedBox(height: AppSizes.spaceBtwItems,),

            SizedBox(
              width: double.infinity,
              child: TextButton(onPressed: (){}, child:  Text(AppStrings.submit ),),
            ),

          ],),
        ),
      ),
    );
  }
}
