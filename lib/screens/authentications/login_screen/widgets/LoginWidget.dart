import 'package:fitness/screens/authentications/signup_screen/SignUpScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/constants/AppDevicesUtils.dart';
import '../../../../utils/constants/AppSizes.dart';
import '../../forget_password/ForgetPassword.dart';
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
            obscureText: controller.isPasswordVisible.value,  // Bind obscureText to isPasswordVisible

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

        }),
          Container(
          margin: const EdgeInsets.only(right: 0),
      alignment: Alignment.bottomRight,
      child: TextButton(
          onPressed: () {
            Get.to(() => ForgetPassword());
          },
          child: Text('Forget Password',textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.labelMedium)),
    ),

        const SizedBox(height: AppSizes.spaceBtwSections,),

        SizedBox(
            width: AppDevicesUtils.getScreenWidth(context) * 0.8,
            child: ElevatedButton(onPressed: () {
              AppDevicesUtils.hideKeyboard(context);
              controller.login();
            }, child:  Text('Login',style: Theme.of(context).textTheme.titleSmall?.copyWith(color:
            Colors.white),))),

        const SizedBox(height: AppSizes.spaceBtwInputFields,),
        SizedBox(
            width: AppDevicesUtils.getScreenWidth(context) * 0.8,
            child: OutlinedButton(onPressed: () {


              Get.to(() =>const SignUpScreen());

            }, child:  Text('Create an Account',   style: Theme.of(context).textTheme.titleSmall,
            ))),


      ],)),
    );
  }
}
