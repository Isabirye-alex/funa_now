import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/wishlist_controller.dart';
import 'package:go_shop/features/helper_function/internet_helper.dart';

void main() {
    Get.put(WishlistController()); // Register once
  // Get.put(CartController()); 
  runApp(const FunaNow());
}

class FunaNow extends StatelessWidget {
  const FunaNow({super.key});

  @override
  Widget build(BuildContext context) {
    return const ConnectionChecker(); // handles both online/offline scenarios
  }
}
