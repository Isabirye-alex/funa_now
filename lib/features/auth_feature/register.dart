import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/signup_controller.dart';
import 'package:go_shop/features/helper_function/validator.dart';
import 'package:go_shop/ui/pages/reusables/custom_text.dart';
import 'package:go_shop/ui/pages/reusables/custom_text_field.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

  File? image;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
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
                    text: 'Create your account',
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                  ),
                  5.verticalSpace,
                  CustomText(
                    textAlign: TextAlign.center,
                    fontFamily: 'Poppins',
                    text: 'We\'re happy to see you Join us!',
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                  5.verticalSpace,
                  Form(
                    // key: controller.formKey,
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          // onTap: selectImage,
                          child: CircleAvatar(
                            foregroundColor: Colors.green,
                            radius: 50,
                            backgroundColor: Colors.purple,
                            backgroundImage: image != null
                                ? FileImage(image!)
                                : null,
                            child: image == null
                                ? const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                        10.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: CustomTextField(
                                controller: controller.firstNameController,
                                validator: (value) => Validator().validateNotEmpty(value, 'First Name'),
                                labelText: 'First Name',
                                prefixIcon: Icons.person,
                              ),
                            ),
                            8.horizontalSpace,
                            Expanded(
                              flex: 5,
                              child: CustomTextField(
                                controller: controller.lastNameController,
                                validator: (value) => Validator().validateNotEmpty(value, 'Last Name'),
                                labelText: 'Last Name',
                                prefixIcon: Icons.person_outline_outlined,
                              ),
                            ),
                          ],
                        ),
                        8.verticalSpace,
                        CustomTextField(
                          prefixIcon: Icons.email,
                          controller: controller.emailController,
                          validator: (value) =>
                              Validator().validateNotEmpty(value, 'Email'),
                          labelText: 'Enter your email',
                        ),
                        8.verticalSpace,
                        CustomTextField(
                          controller: controller.usernameController,
                          validator: (value) =>
                              Validator().validateNotEmpty(value, 'User name'),
                          labelText: 'Username',
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
                          controller: controller.passwordController,
                          validator: (value) =>
                              Validator().validatePassword(value),
                          labelText: 'Password',
                          prefixIcon: Icons.password,
                        ),
                        8.verticalSpace,
                        CustomTextField(
                          iconCallBack: () {
                            setState(() {
                              isConfirmPasswordHidden =
                                  !isConfirmPasswordHidden;
                            });
                          },
                          iconData: isConfirmPasswordHidden
                              ? Icons.visibility
                              : Icons.visibility_off,
                          charcterType: '*',
                          isObscureText: isConfirmPasswordHidden,
                          controller: controller.confirmPasswordController,
                          validator: (value) =>
                              Validator().validateConfirmPassword(value),
                          labelText: 'Confirm your password',
                          prefixIcon: Icons.password,
                        ),
                      ],
                    ),
                  ),
                  20.verticalSpace,
                  // Obx(
                  //   () =>;
                  //   ),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
