import 'package:fitness/utils/constants/sizes/AppSizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

import '../../../utils/constants/device/AppDevicesUtils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(height: AppSizes.spaceBtwSections +30,),
            const Center(
              child: Icon(
                Icons.fitness_center,
                size: 100,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 40),

            // Welcome Text
            const Text(
              'Welcome to Fitness App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.appBarHeight +30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10 ,),
              child: Form(child: Column(children: [


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

                const SizedBox( height: AppSizes.spaceBtwInputFields,),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Password'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Colors.black)
                    ),

                    hintText: '1cwer34d',
                    suffixIcon: Icon(Icons.password),

                  ),
                ),


                SizedBox(height: AppSizes.appBarHeight -15,),
                SizedBox(
                  width: AppDevicesUtils.getScreenWidth(context) * 0.8 ,
                    height: 49,
                    child: ElevatedButton(onPressed: (){}, child: Text('Login' ,style: TextStyle(fontSize: 14),)))
              ],)),
            )



          ],
        ),
      ),

    );
  }
}
