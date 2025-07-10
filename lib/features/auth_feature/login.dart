// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/controllers/login_controller.dart';
import 'package:go_shop/features/helper_function/validator.dart';
import 'package:iconsax/iconsax.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 500,
              ), // optional for tablets
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 24.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    Text(
                      'We\'re happy to see you back!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Log in with your details.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          ATextFormField(
                            validator: (value) =>
                                AValidator.validateNotEmpty(value, 'Username'),
                            labelText: 'Username',
                            prefixIcon: Iconsax.user,
                            controller: controller.usernameController,
                          ),
                          const SizedBox(height: 10),
                          Obx(
                            () => ATextFormField(
                              validator: (value) =>
                                  AValidator.validatePassword(value),
                              labelText: 'Password',
                              prefixIcon: Iconsax.lock,
                              controller: controller.passwordController,
                              isObscureText: controller.isPasswordHidden.value,
                              characterType: '*',
                              iconCallBack: () {
                                setState(() {
                                  controller.isPasswordHidden.value =
                                      !controller.isPasswordHidden.value;
                                });
                              },
                              iconData: controller.isPasswordHidden.value
                                  ? Iconsax.eye
                                  : Iconsax.eye_slash,
                            ),
                          ),
                          const SizedBox(height: 20),
                          InkWell(
                            onTap:controller.isLoading.value ? null: () {
                              if (_formKey.currentState!.validate()) {
                                controller.login(context);
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.86,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.blue,
                              ),
                              child: Obx(
                                () => controller.isLoading.value
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                          'Log in',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 0),
                            minimumSize: Size(0, 30),
                            tapTargetSize: MaterialTapTargetSize
                                .shrinkWrap, // Shrinks tap area
                          ),
                          child: const Text(
                            'Forgot Password? Reset here!',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.go('/registerpage');
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 0),
                            minimumSize: Size(0, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Don\'t have an account? Sign Up!',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ATextFormField extends StatelessWidget {
  const ATextFormField({
    super.key,
    this.controller,
    this.labelText,
    required this.validator,
    this.isObscureText = false,
    this.iconCallBack,
    this.iconData,
    this.characterType,
    this.prefixIcon,
  });

  final TextEditingController? controller;
  final String? labelText;
  final String? Function(String?) validator;
  final bool? isObscureText;
  final VoidCallback? iconCallBack;
  final IconData? iconData;
  final String? characterType;
  final IconData? prefixIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(),
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        controller: controller,
        validator: validator,
        maxLines: 1,
        obscuringCharacter:
            (characterType != null && characterType!.length == 1)
            ? characterType!
            : '•',
        obscureText: isObscureText!,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon, color: Colors.black),
          suffixIcon: IconButton(
            onPressed: iconCallBack,
            icon: Icon(iconData, color: Colors.black),
          ),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
