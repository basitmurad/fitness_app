// import 'package:fitness/common/widgets/TextInputWidget.dart';
// import 'package:fitness/navigation_menu.dart';
// import 'package:fitness/screens/authentications/forget_password/ForgetPassword.dart';
// import 'package:fitness/utils/constants/AppSizes.dart';
// import 'package:fitness/utils/constants/AppString.dart';
// import 'package:fitness/utils/helpers/KeyboardController.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../common/widgets/ButtonWidget.dart';
// import '../../../authentication_controllers/LoginScreenController.dart';
//
// class LoginWidget extends StatelessWidget {
//   const LoginWidget({
//     super.key,
//     this.dark,
//   });
//
//   final dark;
//
//   @override
//   Widget build(BuildContext context) {
//     final LoginController controller = Get.put(LoginController());
//
//     return Form(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//
//           const SizedBox(
//             height: AppSizes.inputFieldRadius - 9,
//           ),
//           TextInputWidget(
//             controller: controller.emailController,
//             prefixIcon: const Icon(Icons.email),
//             isPassword: false,
//             headerFontWeight: FontWeight.w700,
//             headerFontFamily: 'Manrope',
//             hintText: AppStrings.enterEmail1, dark: dark, headerText: AppStrings.password,// Not a password field
//           ),
//           const SizedBox(height: AppSizes.inputFieldRadius + 3),
//
//           const SizedBox(height: AppSizes.inputFieldRadius - 9),
//           Obx(() => TextInputWidget(
//                 controller: controller.passwordController,
//                 prefixIcon: const Icon(Icons.lock),
//                 isPassword: true,
//                 hintText: AppStrings.entrePassword,
//                 // Password field
//             headerFontWeight: FontWeight.w700,
//                 headerFontFamily: 'Manrope',
//                 obscureText: controller.isPasswordVisible.value,
//                 onObscureTextChanged: controller.togglePasswordVisibility, dark: dark, headerText: AppStrings.passwordNew,
//               )),
//           const SizedBox(height: AppSizes.inputFieldRadius),
//
//
//           GestureDetector(
//             onTap: (){
//
//               Get.to(ForgetPassword());
//               KeyboardController.instance.hideKeyboard(); // Hide keyboard before navigation
//
//             },
//             child: Container(
//               alignment: Alignment.bottomRight,
//               child: Text(
//                 AppStrings.forgetPassword,
//                 textAlign: TextAlign
//                     .right, // Align text to the right within the container
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: AppSizes.spaceBtwSections + 10,
//           ),
//
//           Padding(
//
//             padding: const EdgeInsets.symmetric(horizontal: 0 ,),
//             child: ButtonWidget(dark: dark, onPressed: () {
//               Get.to(const NavigationMenu());
//             }, buttonText: AppStrings.sigIn,),
//           ),
//
//         ],
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:fitness/common/snackbar/ShowSnackbar.dart';
import 'package:fitness/common/widgets/TextInputWidget.dart';
import 'package:fitness/navigation_menu.dart';
import 'package:fitness/screens/authentications/forget_password/ForgetPassword.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/constants/AppString.dart';
import 'package:fitness/utils/helpers/KeyboardController.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/ButtonWidget.dart';
import '../../../authentication_controllers/LoginScreenController.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    super.key,
    this.dark,
  });

  final dark;

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSizes.inputFieldRadius - 9),
          TextInputWidget(
            controller: controller.emailController,
            prefixIcon: const Icon(Icons.email),
            isPassword: false,
            headerFontWeight: FontWeight.w700,
            headerFontFamily: 'Manrope',
            hintText: AppStrings.enterEmail1,
            dark: dark,
            headerText: AppStrings.password,
          ),
          const SizedBox(height: AppSizes.inputFieldRadius + 3),
          const SizedBox(height: AppSizes.inputFieldRadius - 9),
          Obx(() => TextInputWidget(
            controller: controller.passwordController,
            prefixIcon: const Icon(Icons.lock),
            isPassword: true,
            hintText: AppStrings.entrePassword,
            headerFontWeight: FontWeight.w700,
            headerFontFamily: 'Manrope',
            obscureText: controller.isPasswordVisible.value,
            onObscureTextChanged: controller.togglePasswordVisibility,
            dark: dark,
            headerText: AppStrings.passwordNew,
          )),
          const SizedBox(height: AppSizes.inputFieldRadius),
          GestureDetector(
            onTap: () {
              Get.to(ForgetPassword());
              KeyboardController.instance.hideKeyboard(); // Hide keyboard before navigation
            },
            child: Container(
              alignment: Alignment.bottomRight,
              child: Text(
                AppStrings.forgetPassword,
                textAlign: TextAlign.right,
              ),
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwSections + 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: ButtonWidget(
              dark: dark,
              onPressed: () async {
                await _loginUser(controller);
              },
              buttonText: AppStrings.sigIn,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _loginUser(LoginController controller) async {
    try {
      // Get email and password from the controller
      String email = controller.emailController.text.trim();
      String password = controller.passwordController.text.trim();

      // Sign in with email and password
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigate to the Navigation Menu on successful login
      Get.to(() => NavigationMenu());
    } on FirebaseAuthException catch (e) {
      // Handle errors here
      String message;
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else {
        message = 'An error occurred. Please try again.';
      }

      ShowSnackbar.showMessage(title: 'Login Failed', message: 'An error occurred. Please try again.', backgroundColor: AppColor.error);
      // MyAppHelperFunctions.showSnackBar('Login Failed');
      // Get.snackbar('Login Failed', message, snackPosition: SnackPosition.BOTTOM ,backgroundColor: AppColor.error ,duration: Duration(seconds: 1) ,);
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
