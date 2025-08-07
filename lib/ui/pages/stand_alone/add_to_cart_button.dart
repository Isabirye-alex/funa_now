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
