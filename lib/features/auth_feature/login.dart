import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/login_controller.dart';
import 'package:go_shop/features/helper_function/validator.dart';
import 'package:iconsax/iconsax.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Text(
            'We\'re happy to see you back!',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Log in with your details.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w200,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  ATextFormField(
                    validator: (value) =>
                        AValidator.validateNotEmpty(value, 'Username'),
                    labelText: 'Username',
                    prefixIcon: Iconsax.user,
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
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      controller.login(context);
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
                        'Log in',
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
