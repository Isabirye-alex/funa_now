import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/signup_controller.dart';
import 'package:go_shop/features/helper_function/validator.dart';
import 'package:iconsax/iconsax.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Text(
            'Welcome on Board!',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Enter your details to register.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w200,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Form(
              key: controller.registerformKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ATextFormField(
                          validator: (value) =>
                              AValidator.validateNotEmpty(value, 'First Name'),
                          labelText: 'First Name',
                          prefixIcon: Iconsax.user,
                          controller: controller.usernameController,
                        ),
                      ),
                      Expanded(
                        child: ATextFormField(
                          validator: (value) =>
                              AValidator.validateNotEmpty(value, 'Last Name'),
                          labelText: 'Last Name',
                          prefixIcon: Iconsax.user,
                          controller: controller.usernameController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ATextFormField(
                    validator: (value) => AValidator.validateEmail(value),
                    labelText: 'example@gmail.com',
                    prefixIcon: Iconsax.message,
                    controller: controller.emailController,
                  ),
                  SizedBox(height: 10),
                  ATextFormField(
                    validator: (value) =>
                        AValidator.validateNotEmpty(value, 'Username'),
                    labelText: 'Username',
                    prefixIcon: Iconsax.user2,
                    controller: controller.usernameController,
                  ),
                  SizedBox(height: 10),
                  ATextFormField(
                    validator: (value) => AValidator.validatePassword(value),
                    labelText: 'Password',
                    prefixIcon: Iconsax.lock,
                    controller: controller.passwordController,
                    isObscureText: controller.isPasswordHidden,
                    characterType: '*',
                    iconCallBack: () {
                      setState(() {
                        controller.isPasswordHidden =
                            !controller.isPasswordHidden;
                      });
                    },
                    iconData: controller.isPasswordHidden
                        ? Iconsax.eye
                        : Iconsax.eye_slash,
                  ),
                  ATextFormField(
                    validator: (value) => AValidator.validateConfirmPassword(
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
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      controller.register(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width * 0.85,
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.blue,
                      ),
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
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Already Have an account? Log in',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ],
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
      controller: controller,
      validator: validator,
      maxLines: 1,
      obscuringCharacter: (characterType != null && characterType!.length == 1)
          ? characterType!
          : '•',
      obscureText: isObscureText!,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        suffixIcon: IconButton(onPressed: iconCallBack, icon: Icon(iconData)),
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
