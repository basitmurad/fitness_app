import 'package:fitness/screens/authentications/login_screen/LoginScreen.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:fitness/utils/constants/ImagePaths.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

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
            const Image(image:   AssetImage(ImagePaths.forgetillustration)
              ),

            const SizedBox(height: AppSizes.spaceBtwSections,),

            ///title and sub title
            Text('Password Reset Email Sent',style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center,),
            const SizedBox(height: AppSizes.spaceBtwItems,),
            Text('basitmurad@gmail.com' ,style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center,),
            const SizedBox(height: AppSizes.spaceBtwItems,),
            Text('   Your Account Security is Our Priority! We ve Sent You a Secure Link to Safely Change Your Password and Keep Your Account Protected   '  ,style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),

            const SizedBox(height: AppSizes.spaceBtwSections,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: (){}, child: const Text('Done' ),),
            ),
            const SizedBox(height: AppSizes.spaceBtwItems,),

            SizedBox(
              width: double.infinity,
              child: TextButton(onPressed: (){}, child: const Text('Resend Email' ),),
            ),

          ],),
        ),
      ),
    );
  }
}
