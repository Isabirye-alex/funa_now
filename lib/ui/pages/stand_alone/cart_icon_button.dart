import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/cart_controller.dart';

class CartIconButton extends StatelessWidget {
  const CartIconButton({
    super.key,
    required this.icon,
    this.iconText,
    this.onTap,
  });

  final IconData icon;
  final String? iconText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
          child: Column(
            children: [
              Stack(
                children: [
                  Icon(icon, color: Colors.orange, weight: 30.0, grade: 4),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Center(
                      child: Obx(
                        () => cartController.isLoading.value
                            ? SizedBox(
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                '${cartController.cartItem.length}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                iconText ?? '',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
