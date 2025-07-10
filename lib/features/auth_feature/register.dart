import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/controllers/signup_controller.dart';
import 'package:go_shop/features/helper_function/validator.dart';
import 'package:iconsax/iconsax.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
                child: Column(
                  children: [
                    SizedBox(height: kToolbarHeight),
                    Text(
                      'Welcome on Board!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Enter your details to register.',
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
                          Row(
                            children: [
                              Expanded(
                                child: ATextFormField(
                                  validator: (value) =>
                                      AValidator.validateNotEmpty(
                                        value,
                                        'First name',
                                      ),
                                  labelText: 'First name',

                                  controller: controller.firstNameController,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ATextFormField(
                                  validator: (value) =>
                                      AValidator.validateNotEmpty(
                                        value,
                                        'Last name',
                                      ),
                                  labelText: 'Last name',

                                  controller: controller.lastNameController,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ATextFormField(
                            validator: AValidator.validateEmail,
                            labelText: 'example@gmail.com',
                            // prefixIcon: Icons.mail,
                            controller: controller.emailController,
                          ),
                          const SizedBox(height: 10),
                          ATextFormField(
                            validator: (value) =>
                                AValidator.validateNotEmpty(value, 'Username'),
                            labelText: 'Username',

                            controller: controller.usernameController,
                          ),
                          const SizedBox(height: 10),
                          ATextFormField(
                            validator: AValidator.validatePassword,
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
                          const SizedBox(height: 10),
                          ATextFormField(
                            validator: (value) =>
                                AValidator.validateConfirmPassword(
                                  controller.passwordController.text.trim(),
                                ),
                            labelText: 'Confirm Password',
                            prefixIcon: Iconsax.lock,
                            controller: controller.confirmPasswordController,
                            isObscureText: controller.isConfirmPasswordHidden,
                            characterType: '*',
                            iconCallBack: () {
                              setState(() {
                                controller.isConfirmPasswordHidden =
                                    !controller.isConfirmPasswordHidden;
                              });
                            },
                            iconData: controller.isConfirmPasswordHidden
                                ? Iconsax.eye
                                : Iconsax.eye_slash,
                          ),
                          const SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                controller.register(context);
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.blue,
                              ),
                              child: const Center(
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () {
                              GoRouter.of(context).go('/loginpage');
                            },
                            child: const Text(
                              'Already have an account? Log in',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
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
    return TextFormField(
      style: const TextStyle(color: Colors.black),

      controller: controller,
      validator: validator,
      maxLines: 1,
      obscuringCharacter: (characterType != null && characterType!.length == 1)
          ? characterType!
          : '•',
      obscureText: isObscureText!,

      decoration: InputDecoration(
        labelStyle: TextStyle(fontSize: 16, color: Colors.black),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.black)
            : null,
        suffixIcon: iconData != null
            ? IconButton(
                onPressed: iconCallBack,
                icon: Icon(iconData, color: Colors.black),
              )
            : null,
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
