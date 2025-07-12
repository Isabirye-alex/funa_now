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
      backgroundColor: Color(0xFF1C1C2D),
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
                  children: [
                    const SizedBox(height: kToolbarHeight),
                    const Text(
                      'Welcome on Board!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Enter your details to register.',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
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
                                  prefixIcon: Icons.person,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ATextFormField(
                                  validator: (value) =>
                                      AValidator.validateNotEmpty(
                                        value,
                                        'Last name',
                                      ),
                                  labelText: 'Last name',
                                  controller: controller.lastNameController,
                                  prefixIcon: Icons.person,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ATextFormField(
                            validator: AValidator.validateEmail,
                            labelText: 'Email',
                            controller: controller.emailController,
                            prefixIcon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),
                          ATextFormField(
                            validator: (value) =>
                                AValidator.validateNotEmpty(value, 'Username'),
                            labelText: 'Username',
                            controller: controller.usernameController,
                            prefixIcon: Iconsax.user,
                          ),
                          const SizedBox(height: 16),
                          Obx(
                            () => ATextFormField(
                              validator: AValidator.validatePassword,
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
                          const SizedBox(height: 16),
                          Obx(
                            () => ATextFormField(
                              validator: (value) =>
                                  AValidator.validateConfirmPassword(
                                    controller.passwordController.text.trim(),
                                  ),
                              labelText: 'Confirm Password',
                              prefixIcon: Iconsax.lock,
                              controller: controller.confirmPasswordController,
                              isObscureText:
                                  controller.isConfirmPasswordHidden.value,
                              characterType: '*',
                              iconCallBack: () {
                                controller.isConfirmPasswordHidden.value =
                                    !controller.isConfirmPasswordHidden.value;
                              },
                              iconData: controller.isConfirmPasswordHidden.value
                                  ? Iconsax.eye
                                  : Iconsax.eye_slash,
                            ),
                          ),
                          const SizedBox(height: 30),
                          InkWell(
                            onTap: controller.isLoading.value
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      controller.register(context);
                                    }
                                  },
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                color: controller.isLoading.value
                                    ? Colors.blue.shade300
                                    : Colors.blue,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withAlpha(300),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
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
                          ),
                          const SizedBox(height: 18),
                          TextButton(
                            onPressed: () {
                              GoRouter.of(context).go('/loginpage');
                            },
                            child: const Text(
                              'Already have an account? Log in',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
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
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: 1,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.black87, fontSize: 16),
      obscuringCharacter: (characterType != null && characterType!.length == 1)
          ? characterType!
          : '•',
      obscureText: isObscureText!,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 241, 203, 203),
        labelText: labelText,
        labelStyle: const TextStyle(
          fontSize: 18,
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.blueAccent)
            : null,
        suffixIcon: iconData != null
            ? IconButton(
                onPressed: iconCallBack,
                icon: Icon(iconData, color: Colors.blueAccent),
              )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
        ),
      ),
    );
  }
}
