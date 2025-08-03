import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:iconsax/iconsax.dart';


class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    required this.product,
    required this.cartController,
  });

  final dynamic product;
  final CartController cartController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        cartController.addToCart(product, context);
        Flushbar(
          shouldIconPulse: false,
          duration: const Duration(milliseconds: 500),
          isDismissible: true,
          dismissDirection: FlushbarDismissDirection.HORIZONTAL,
          borderRadius: BorderRadius.circular(8),
          margin: const EdgeInsets.all(16),
          flushbarPosition: FlushbarPosition.TOP,
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.green,
          messageText: const Text(
            'Item added to cart',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          icon: const Icon(Icons.check_circle, color: Colors.white),
        ).show(context);
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        child: const Icon(Iconsax.add, size: 20, color: Colors.white),
      ),
    );
  }
}
