import 'package:flutter/material.dart';
import 'package:go_shop/features/helper_function/internet_helper.dart';

void main() {
  runApp(const FunaNow());
}

class FunaNow extends StatelessWidget {
  const FunaNow({super.key});

  @override
  Widget build(BuildContext context) {
    return const ConnectionChecker(); // handles both online/offline scenarios
  }
}
