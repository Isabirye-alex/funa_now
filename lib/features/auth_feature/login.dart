import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_shop/ui/pages/reusables/custom_text.dart';
import 'package:go_shop/ui/pages/reusables/custom_text_field.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isPasswordHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 0.85.sh,
          width: 1.sw,
          child: Center(
            child: Container(
              margin: EdgeInsets.all(12.w),
              padding: EdgeInsets.all(8.spMax),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  35.verticalSpace,
                  CustomText(
                    fontFamily: 'Poppins',
                    text: 'Login to your account',
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                  ),
                  5.verticalSpace,
                  CustomText(
                    textAlign: TextAlign.center,
                    fontFamily: 'Poppins',
                    text: 'We\'re happy to see you back!',
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                  5.verticalSpace,
                  Form(
                    key: controller.formKey,
                    child: Column(
                      children: <Widget>[
                        CustomTextField(
                          controller: controller.usernameController,
                          validator: (value) =>
                              controller.validateNotEmpty(value, 'Email'),
                          labelText: 'Enter your Username',
                          prefixIcon: Icons.person_4_outlined,
                        ),
                        8.verticalSpace,
                        CustomTextField(
                          iconCallBack: () {
                            setState(() {
                              isPasswordHidden = !isPasswordHidden;
                            });
                          },
                          iconData: isPasswordHidden
                              ? Icons.visibility
                              : Icons.visibility_off,
                          isObscureText: isPasswordHidden,
                          charcterType: '*',
                          prefixIcon: Icons.password,
                          controller: controller.passwordController,
                          validator: (value) =>
                              controller.validatePassword(value),
                          labelText: 'Enter Password',
                        ),
                      ],
                    ),
                  ),
                  20.verticalSpace,
                  Obx(
                    () => CustomTextButton(
                      isLoading: controller.isLoading.value,
                      fontSize: 24,
                      color: Colors.blue,
                      text: 'LogIn',
                      radius: 10.r,
                      textColor: Colors.white,
                      callBack: () => controller.validateAndSubmit(),
                    ),
                  ),
                  10.verticalSpace,
                  CustomTextButton(
                    isLoading: false,
                    fontSize: 18,
                    text: 'Don\'t have an account? Sign Up',
                    textColor: Colors.blue,
                    callBack: () {
                      Get.off(() => SignUpScreen(), binding: LogInBindings());
                    },
                  ),
                  SocialSignInButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
