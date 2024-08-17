import 'package:fitness/utils/constants/AppImagePaths.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/constants/AppString.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constants/AppDevicesUtils.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(

        automaticallyImplyLeading: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(


            children: [


              Text(AppStrings.unlockBest ,style: Theme.of(context).textTheme.bodyLarge,),
              const SizedBox(height: AppSizes.spaceBtwSections +20,),

              Form(child: Column(children: [


                TextFormField(
                  decoration:  InputDecoration(
                    label: Text(AppStrings.emailText),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(color: Colors.black)
                    ),

                    hintText: AppStrings.email,
                    suffixIcon: const Icon(Iconsax.direct),

                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwInputFields,),
                TextFormField(
                  decoration:  InputDecoration(
                    label: Text(AppStrings.name),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(color: Colors.black)
                    ),

                    hintText: AppStrings.nameText,
                    suffixIcon: const Icon(Icons.person),

                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwInputFields,),



                TextFormField(

                  decoration: const InputDecoration(
                    label: Text('Age'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(color: Colors.black)
                    ),



                    hintText: '10',
                    suffixIcon: Icon(Iconsax.user),

                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwInputFields+20,),



                SizedBox(
                  width: AppDevicesUtils.getScreenWidth(context) * 0.8,
                  child: ElevatedButton(onPressed: (){


                    AppDevicesUtils.hideKeyboard(context);

                  }, child:  Text
                    (AppStrings.signUP),),
                )

              ],))
            ],

          ),
        ),
      ),
    );
  }
}
