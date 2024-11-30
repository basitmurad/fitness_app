import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:fitness/common/snackbar/ShowSnackbar.dart';
import 'package:fitness/common/widgets/TextInputWidget.dart';
import 'package:fitness/navigation_menu.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/constants/AppString.dart';
import 'package:fitness/utils/helpers/KeyboardController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/ButtonWidget.dart';
import '../../../authentication_controllers/LoginScreenController.dart';
import '../../forget_password/ForgetPassword.dart';

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

      // Check if fields are empty
      if (email.isEmpty || password.isEmpty) {
        ShowSnackbar.showMessage(
          title: 'Login Failed',
          message: 'Please fill in all fields.',
          backgroundColor: AppColor.error,
        );
        return;
      }

      // Sign in with email and password
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Unfocus fields after login
      FocusScope.of(Get.context!).unfocus();

      // Navigate to the next screen on success
      Get.to(() => const NavigationMenu());

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

      ShowSnackbar.showMessage(
        title: 'Login Failed',
        message: message,
        backgroundColor: AppColor.error,
      );
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
