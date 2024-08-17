// import 'package:fitness/screens/authentications/signup_screen/SignUpScreen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../../../../utils/constants/AppDevicesUtils.dart';
// import '../../../../utils/constants/AppSizes.dart';
// import '../../forget_password/ForgetPassword.dart';
// import '../controller/LoginController.dart';
//
// class LoginWidget extends StatelessWidget {
//   const LoginWidget({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final LoginController controller = Get.put(LoginController());
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10,),
//       child: Form(child: Column(children: [
//
//
//         TextFormField(
//           controller: controller.emailController,
//           style: TextStyle(color: Colors.white),
//           decoration: InputDecoration(
//             labelText: 'Email',
//             labelStyle: TextStyle(color: Colors.white),
//             hintText: 'Email',
//             hintStyle: TextStyle(color: Colors.white),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(12)),
//               borderSide: BorderSide(color: Colors.white),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(12)),
//               borderSide: BorderSide(color: Colors.white),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(12)),
//               borderSide: BorderSide(color: Colors.white),
//             ),
//             suffixIcon: Icon(Icons.email, color: Colors.white),
//           ),
//         ),
//
//
//         // TextFormField(
//         //   controller: controller.emailController,
//         //
//         //   style: TextStyle(color: Colors.white),
//         //   decoration: const InputDecoration(
//         //
//         //     label:  Text('Email' ,style: TextStyle(color: Colors.white)),
//         //
//         //
//         //     hintStyle: TextStyle(color: Colors.white),
//         //     labelStyle: TextStyle(color: Colors.white),
//         //     border: OutlineInputBorder(
//         //         borderRadius: BorderRadius.all(Radius.circular(12)),
//         //         borderSide: BorderSide(color: Colors.white)
//         //     ),
//         //
//         //     hintText: 'Email',
//         //     suffixIcon: Icon(Icons.email ,color:Colors.white ),
//         //
//         //   ),
//         // ),
//
//         const SizedBox(height: AppSizes.spaceBtwInputFields,),
//         Obx((){
//           return             TextFormField(
//             controller: controller.emailController,
//             style: TextStyle(color: Colors.white),
//             decoration: InputDecoration(
//               labelText: 'Password',
//               labelStyle: TextStyle(color: Colors.white),
//               hintText: 'Password',
//               hintStyle: TextStyle(color: Colors.white),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(12)),
//                 borderSide: BorderSide(color: Colors.white),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(12)),
//                 borderSide: BorderSide(color: Colors.white),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(12)),
//                 borderSide: BorderSide(color: Colors.white),
//               ),
//               suffixIcon: Icon(Icons.email, color: Colors.white),
//             ));}),
//
//           //   TextFormField(
//           //   controller: controller.passwordController,
//           //   obscureText: controller.isPasswordVisible.value,  // Bind obscureText to isPasswordVisible
//           //   style: TextStyle(color: Colors.white),
//           //
//           //   decoration: InputDecoration(
//           //     hintStyle: TextStyle(color: Colors.white),
//           //     labelStyle: TextStyle(color: Colors.white),
//           //     label:  Text('Password' ,style: TextStyle(color: Colors.white)),
//           //     border: const OutlineInputBorder(
//           //       borderRadius: BorderRadius.all(Radius.circular(12)),
//           //       borderSide: BorderSide(color: Colors.white),
//           //     ),
//           //
//           //     hintText: 'password',
//           //
//           //
//           //     suffixIcon:
//           //     IconButton(
//           //       icon: Icon(color: Colors.white,
//           //         controller.isPasswordVisible.value
//           //             ? Icons.visibility
//           //             : Icons.visibility_off,
//           //       ),
//           //       onPressed: controller.togglePasswordVisibility,
//           //     ),
//           //
//           //
//           //   ),
//           // );
//
//      //   }),
//           Container(
//           margin: const EdgeInsets.only(right: 0),
//       alignment: Alignment.bottomRight,
//       child: TextButton(
//           onPressed: () {
//             Get.to(() => ForgetPassword());
//           },
//           child: Text('Forget Password',textAlign: TextAlign.end,
//               style: Theme.of(context).textTheme.labelMedium)),
//     ),
//
//         const SizedBox(height: AppSizes.spaceBtwSections,),
//
//         SizedBox(
//             width: AppDevicesUtils.getScreenWidth(context) * 0.8,
//             child: ElevatedButton(onPressed: () {
//               AppDevicesUtils.hideKeyboard(context);
//               controller.login();
//             }, child:  Text('Login',style: Theme.of(context).textTheme.titleSmall?.copyWith(color:
//             Colors.white),))),
//
//         const SizedBox(height: AppSizes.spaceBtwInputFields,),
//         SizedBox(
//             width: AppDevicesUtils.getScreenWidth(context) * 0.8,
//             child: OutlinedButton(onPressed: () {
//
//
//               Get.to(() =>const SignUpScreen());
//
//             }, child:  Text('Create an Account',   style: Theme.of(context).textTheme.titleSmall,
//             ))),
//
//
//       ],)),
//     );
//   }
// }
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


        // TextFormField(
        //   controller: controller.emailController,
        //   style: TextStyle(color: Colors.white),
        //   decoration: InputDecoration(
        //     labelText: 'Email',
        //     labelStyle: TextStyle(color: Colors.white),
        //     hintText: 'Email',
        //     hintStyle: TextStyle(color: Colors.white),
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.all(Radius.circular(12)),
        //       borderSide: BorderSide(color: Colors.white),
        //     ),
        //     focusedBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.all(Radius.circular(12)),
        //       borderSide: BorderSide(color: Colors.white),
        //     ),
        //     enabledBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.all(Radius.circular(12)),
        //       borderSide: BorderSide(color: Colors.white),
        //     ),
        //     suffixIcon: Icon(Icons.email, color: Colors.white),
        //   ),
        // ),


        TextFormField(
          controller: controller.emailController,

          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(

            label:  Text('Email' ,style: TextStyle(color: Colors.black)),


            hintStyle: TextStyle(color: Colors.black),
            labelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: Colors.black)
            ),

            hintText: 'Email',
            suffixIcon: Icon(Icons.email ,color:Colors.grey ),

          ),
        ),

        const SizedBox(height: AppSizes.spaceBtwInputFields,),
        // Obx((){
        //   return             TextFormField(
        //       controller: controller.emailController,
        //       style: TextStyle(color: Colors.white),
        //       decoration: InputDecoration(
        //         labelText: 'Password',
        //         labelStyle: TextStyle(color: Colors.white),
        //         hintText: 'Password',
        //         hintStyle: TextStyle(color: Colors.white),
        //         border: OutlineInputBorder(
        //           borderRadius: BorderRadius.all(Radius.circular(12)),
        //           borderSide: BorderSide(color: Colors.white),
        //         ),
        //         focusedBorder: OutlineInputBorder(
        //           borderRadius: BorderRadius.all(Radius.circular(12)),
        //           borderSide: BorderSide(color: Colors.white),
        //         ),
        //         enabledBorder: OutlineInputBorder(
        //           borderRadius: BorderRadius.all(Radius.circular(12)),
        //           borderSide: BorderSide(color: Colors.white),
        //         ),
        //         suffixIcon: Icon(Icons.email, color: Colors.white),
        //       ));}),
Obx((){

  return
    TextFormField(
      controller: controller.passwordController,
      obscureText: controller.isPasswordVisible.value,  // Bind obscureText to isPasswordVisible
      style: TextStyle(color: Colors.black),

      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.black),
        labelStyle: TextStyle(color: Colors.black),
        label:  Text('Password' ,style: TextStyle(color: Colors.black)),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Colors.black),
        ),

        hintText: 'password',

        suffixIcon:
        IconButton(
          icon: Icon(color: Colors.grey,
            controller.isPasswordVisible.value
                ? Icons.visibility
                : Icons.visibility_off,
          ),
          onPressed: controller.togglePasswordVisibility,
        ),


      ),
    );

}),
        //   }),
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
            Colors.black),))),

        const SizedBox(height: AppSizes.spaceBtwInputFields,),
        SizedBox(
            width: AppDevicesUtils.getScreenWidth(context) * 0.8,
            child: OutlinedButton(onPressed: () {


              Get.to(() =>const SignUpScreen());

            }, child:  Text('Create an Account ',   style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black),
            ))),


      ],)),
    );
  }
}