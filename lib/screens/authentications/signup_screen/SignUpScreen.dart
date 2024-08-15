import 'package:fitness/utils/constants/sizes/AppSizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/device/AppDevicesUtils.dart';

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


              Text('Unlock Your Best Self—Join Us Today!' ,style: Theme.of(context).textTheme.bodyLarge,),
              const SizedBox(height: AppSizes.spaceBtwSections +20,),

              Form(child: Column(children: [


                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Email'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(color: Colors.black)
                    ),

                    hintText: 'abx1234@gmail.com',
                    suffixIcon: Icon(Icons.email),

                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwInputFields,),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Name'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(color: Colors.black)
                    ),

                    hintText: 'basit murad',
                    suffixIcon: Icon(Icons.person),

                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwInputFields,),
                TextFormField(
                  keyboardType: TextInputType.number,  // Ensures only numeric input is accepted

                  decoration: const InputDecoration(
                    label: Text('Age'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(color: Colors.black)
                    ),



                    hintText: '10',
                    suffixIcon: Icon(Icons.email),

                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwInputFields+20,),



                TextFormField(
                  keyboardType: TextInputType.number,  // Ensures only numeric input is accepted

                  decoration: const InputDecoration(
                    label: Text('Age'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(color: Colors.black)
                    ),



                    hintText: '10',
                    suffixIcon: Icon(Icons.email),

                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwInputFields+20,),




                SizedBox(
                  width: AppDevicesUtils.getScreenWidth(context) * 0.8,
                  child: ElevatedButton(onPressed: (){}, child: const Text
                    ('Sign up'),),
                )

              ],))
            ],

          ),
        ),
      ),
    );
  }
}
