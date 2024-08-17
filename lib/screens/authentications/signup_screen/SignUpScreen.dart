import 'package:fitness/screens/authentications/signup_screen/controller/SignUpController.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/constants/AppString.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constants/AppDevicesUtils.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController genderController = Get.put(SignUpController());

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
            style: const TextStyle(color: Colors.black),

            decoration: InputDecoration(
              label:   Text(AppStrings.password ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: Colors.black),
              ),

              hintText: AppStrings.password,

              suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.visibility),)

            ),
          )
                ,

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


          Row(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => Radio<String>(
                value: AppStrings.male,
                groupValue: genderController.selectedGender.value,
                onChanged: (value) {
                  genderController.setGender(value!);
                },
              )),
               Text(AppStrings.male),

              const SizedBox( width: 70,),
              Obx(() => Radio<String>(
                value: AppStrings.female,
                groupValue: genderController.selectedGender.value,
                onChanged: (value) {
                  genderController.setGender(value!);
                },
              )),
               Text(AppStrings.female),
            ],
          ),



                const SizedBox(height: AppSizes.spaceBtwSections+30,),


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
