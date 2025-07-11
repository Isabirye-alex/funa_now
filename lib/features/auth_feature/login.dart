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
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 32,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    const Text(
                      'We\'re happy to see you back!',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Log in with your details.',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
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
                          const SizedBox(height: 16),
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
                                controller.isPasswordHidden.value =
                                    !controller.isPasswordHidden.value;
                              },
                              iconData: controller.isPasswordHidden.value
                                  ? Iconsax.eye
                                  : Iconsax.eye_slash,
                            ),
                          ),
                          const SizedBox(height: 28),
                          InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: controller.isLoading.value
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      controller.login(context);
                                    }
                                  },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: controller.isLoading.value
                                    ? Colors.blue.shade300
                                    : Colors.blue,
                                boxShadow: controller.isLoading.value
                                    ? null
                                    : [
                                        BoxShadow(
                                          color: Colors.blue.withOpacity(0.4),
                                          blurRadius: 6,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                              ),
                              child: Obx(
                                () => controller.isLoading.value
                                    ? const Center(
                                        child: SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 3,
                                          ),
                                        ),
                                      )
                                    : const Center(
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
                    const SizedBox(height: 10),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            minimumSize: const Size(0, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            minimumSize: const Size(0, 30),
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
    this.keyboardType,
  });

  final TextEditingController? controller;
  final String? labelText;
  final String? Function(String?) validator;
  final bool? isObscureText;
  final VoidCallback? iconCallBack;
  final IconData? iconData;
  final String? characterType;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: TextFormField(
        style: const TextStyle(color: Colors.black87, fontSize: 16),
        controller: controller,
        validator: validator,
        maxLines: 1,
        keyboardType: keyboardType,
        obscuringCharacter:
            (characterType != null && characterType!.length == 1)
            ? characterType!
            : '•',
        obscureText: isObscureText!,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: Colors.blueAccent)
              : null,
          suffixIcon: iconData != null
              ? IconButton(
                  onPressed: iconCallBack,
                  icon: Icon(iconData, color: Colors.blueAccent),
                )
              : null,
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 16, color: Colors.black54),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
          ),
        ),
      ),
    );
  }
}
