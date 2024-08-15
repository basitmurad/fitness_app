import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/constants/device/AppDevicesUtils.dart';
import '../../../../utils/constants/sizes/AppSizes.dart';
import '../controller/LoginController.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,),
      child: Form(child: Column(children: [


        TextFormField(
          controller: controller.emailController,
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
        Obx((){
          return         TextFormField(
            controller: controller.passwordController,
            obscureText:true,

            decoration: InputDecoration(

              label: const Text('Password'),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: Colors.black),
              ),
              hintText: '1cwer34d',


              suffixIcon:
              IconButton(
                icon: Icon(
                  controller.isPasswordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: controller.togglePasswordVisibility,
              ),


            ),
          );

        })

,
        const SizedBox(height: AppSizes.appBarHeight - 15,),
        SizedBox(
            width: AppDevicesUtils.getScreenWidth(context) * 0.8,
            child: ElevatedButton(onPressed: () {
              controller.login();
            }, child: const Text('Login', style: TextStyle(fontSize: 14),)))
      ],)),
    );
  }
}
